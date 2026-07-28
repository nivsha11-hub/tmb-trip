-- ══════════════════════════════════════════════════════════════
--  Mont Blanc Trek — Supabase schema, RLS and triggers
--  Project: lefqiqhprqfrxjwlmbbx
--
--  Run this whole file in:  Supabase Dashboard → SQL Editor → New query
--  It is idempotent — safe to run more than once.
-- ══════════════════════════════════════════════════════════════

-- ───────────────────────── TABLES ─────────────────────────

create table if not exists public.profiles (
  id           uuid primary key references auth.users(id) on delete cascade,
  display_name text not null default 'מטייל',
  email        text,
  role         text not null default 'member' check (role in ('member','admin')),
  created_at   timestamptz not null default now(),
  joined_at    timestamptz not null default now()
);

create table if not exists public.equipment_progress (
  user_id    uuid not null references public.profiles(id) on delete cascade,
  item_id    text not null,
  checked    boolean not null default false,
  updated_at timestamptz not null default now(),
  primary key (user_id, item_id)
);

create table if not exists public.trip_data (
  id         int primary key,
  huts       jsonb not null default '[]'::jsonb,
  segments   jsonb not null default '[]'::jsonb,
  trip       jsonb not null default '{}'::jsonb,
  updated_at timestamptz not null default now()
);

-- The app upserts trip_data row id = 1. Make sure it exists.
insert into public.trip_data (id) values (1)
on conflict (id) do nothing;

-- ───────────── AUTO-CREATE PROFILE ON SIGNUP ─────────────
-- Without this a user exists in auth.users but has no profiles row,
-- and the app has nothing to log them in as.

create or replace function public.handle_new_user()
returns trigger
language plpgsql
security definer
set search_path = public
as $$
begin
  insert into public.profiles (id, display_name, email)
  values (
    new.id,
    coalesce(
      new.raw_user_meta_data->>'display_name',
      new.raw_user_meta_data->>'full_name',
      split_part(new.email, '@', 1)
    ),
    new.email
  )
  on conflict (id) do update
    set email = excluded.email;
  return new;
end;
$$;

drop trigger if exists on_auth_user_created on auth.users;
create trigger on_auth_user_created
  after insert on auth.users
  for each row execute function public.handle_new_user();

-- Backfill profiles for users who signed up before the trigger existed
insert into public.profiles (id, display_name, email)
select u.id,
       coalesce(u.raw_user_meta_data->>'display_name',
                u.raw_user_meta_data->>'full_name',
                split_part(u.email, '@', 1)),
       u.email
from auth.users u
left join public.profiles p on p.id = u.id
where p.id is null
on conflict (id) do nothing;

-- ───────────────── ADMIN CHECK HELPER ─────────────────
-- security definer so the policy can read profiles without recursing
-- through the very RLS policy it is being evaluated for.

create or replace function public.is_admin()
returns boolean
language sql
security definer
stable
set search_path = public
as $$
  select exists (
    select 1 from public.profiles
    where id = auth.uid() and role = 'admin'
  );
$$;

-- ───────────────────────── RLS ─────────────────────────

alter table public.profiles           enable row level security;
alter table public.equipment_progress enable row level security;
alter table public.trip_data          enable row level security;

-- profiles ------------------------------------------------
-- Previously readable by anon, which exposed every member's email
-- to anyone holding the public anon key. Logged-in users only now.
drop policy if exists "profiles read"        on public.profiles;
drop policy if exists "profiles insert self" on public.profiles;
drop policy if exists "profiles update self" on public.profiles;
drop policy if exists "profiles admin write" on public.profiles;

create policy "profiles read"
  on public.profiles for select
  to authenticated
  using (true);

create policy "profiles insert self"
  on public.profiles for insert
  to authenticated
  with check (id = auth.uid());

-- A member may edit their own row but may NOT promote themselves to admin.
create policy "profiles update self"
  on public.profiles for update
  to authenticated
  using (id = auth.uid())
  with check (
    id = auth.uid()
    and role = (select role from public.profiles where id = auth.uid())
  );

create policy "profiles admin write"
  on public.profiles for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- equipment_progress --------------------------------------
-- Everyone sees group progress; you may only write your own rows.
drop policy if exists "equip read all"    on public.equipment_progress;
drop policy if exists "equip write own"   on public.equipment_progress;
drop policy if exists "equip update own"  on public.equipment_progress;
drop policy if exists "equip delete own"  on public.equipment_progress;

create policy "equip read all"
  on public.equipment_progress for select
  to authenticated
  using (true);

create policy "equip write own"
  on public.equipment_progress for insert
  to authenticated
  with check (user_id = auth.uid());

create policy "equip update own"
  on public.equipment_progress for update
  to authenticated
  using (user_id = auth.uid())
  with check (user_id = auth.uid());

create policy "equip delete own"
  on public.equipment_progress for delete
  to authenticated
  using (user_id = auth.uid() or public.is_admin());

-- trip_data -----------------------------------------------
-- Everyone reads the itinerary; only admins change it.
drop policy if exists "trip read"         on public.trip_data;
drop policy if exists "trip admin insert" on public.trip_data;
drop policy if exists "trip admin update" on public.trip_data;

create policy "trip read"
  on public.trip_data for select
  to authenticated
  using (true);

create policy "trip admin insert"
  on public.trip_data for insert
  to authenticated
  with check (public.is_admin());

create policy "trip admin update"
  on public.trip_data for update
  to authenticated
  using (public.is_admin())
  with check (public.is_admin());

-- ───────────────────── REALTIME ─────────────────────
-- Required for the live sync the app subscribes to.

alter table public.profiles           replica identity full;
alter table public.equipment_progress replica identity full;
alter table public.trip_data          replica identity full;

do $$
begin
  begin
    alter publication supabase_realtime add table public.profiles;
  exception when duplicate_object then null;
  end;
  begin
    alter publication supabase_realtime add table public.equipment_progress;
  exception when duplicate_object then null;
  end;
  begin
    alter publication supabase_realtime add table public.trip_data;
  exception when duplicate_object then null;
  end;
end $$;

-- ───────────────────── MAKE YOURSELF ADMIN ─────────────────────
-- Change the address if needed, then this row can manage the trip.

update public.profiles set role = 'admin' where email = 'nivsha11@gmail.com';

-- ───────────────────── VERIFY ─────────────────────
select id, email, display_name, role from public.profiles order by created_at;
select count(*) as equipment_rows from public.equipment_progress;
select id, jsonb_array_length(huts) as huts, jsonb_array_length(segments) as segments from public.trip_data;
