-- ══════════════════════════════════════════════════════════════
--  Fix pass: the first script left legacy policies in place because
--  it dropped by guessed names. RLS policies are OR-ed, so one stale
--  permissive policy on profiles kept anon able to read every email.
--  This drops EVERY policy on the three tables by looking them up,
--  then recreates only the intended set.
--
--  Run in: Supabase Dashboard -> SQL Editor -> New query
-- ══════════════════════════════════════════════════════════════

-- ── 1. What is there right now (read this output) ──
select tablename, policyname, roles::text, cmd
from pg_policies
where schemaname = 'public'
  and tablename in ('profiles','equipment_progress','trip_data')
order by tablename, policyname;

-- ── 2. Drop every existing policy on those tables ──
do $$
declare r record;
begin
  for r in
    select schemaname, tablename, policyname
    from pg_policies
    where schemaname = 'public'
      and tablename in ('profiles','equipment_progress','trip_data')
  loop
    execute format('drop policy %I on %I.%I', r.policyname, r.schemaname, r.tablename);
  end loop;
end $$;

-- ── 3. Recreate the intended set ──

alter table public.profiles           enable row level security;
alter table public.equipment_progress enable row level security;
alter table public.trip_data          enable row level security;

-- profiles: logged-in users only. Anon gets nothing.
create policy "profiles read" on public.profiles
  for select to authenticated using (true);

create policy "profiles insert self" on public.profiles
  for insert to authenticated with check (id = auth.uid());

-- You may edit your own row but not promote yourself to admin.
create policy "profiles update self" on public.profiles
  for update to authenticated
  using (id = auth.uid())
  with check (id = auth.uid()
    and role = (select role from public.profiles where id = auth.uid()));

create policy "profiles admin write" on public.profiles
  for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- equipment_progress: everyone sees group progress, writes only own rows.
create policy "equip read all" on public.equipment_progress
  for select to authenticated using (true);

create policy "equip write own" on public.equipment_progress
  for insert to authenticated with check (user_id = auth.uid());

create policy "equip update own" on public.equipment_progress
  for update to authenticated
  using (user_id = auth.uid()) with check (user_id = auth.uid());

create policy "equip delete own" on public.equipment_progress
  for delete to authenticated
  using (user_id = auth.uid() or public.is_admin());

-- trip_data: everyone reads the itinerary, only admins change it.
create policy "trip read" on public.trip_data
  for select to authenticated using (true);

create policy "trip admin insert" on public.trip_data
  for insert to authenticated with check (public.is_admin());

create policy "trip admin update" on public.trip_data
  for update to authenticated
  using (public.is_admin()) with check (public.is_admin());

-- ── 4. Verify ──
select tablename, policyname, roles::text, cmd
from pg_policies
where schemaname = 'public'
  and tablename in ('profiles','equipment_progress','trip_data')
order by tablename, policyname;

-- trip_data row 1 must exist for the app to upsert against
select id, jsonb_array_length(huts) as huts, jsonb_array_length(segments) as segments
from public.trip_data;
