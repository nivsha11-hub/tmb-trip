-- ══════════════════════════════════════════════════════════════
--  equipment_progress: let an admin maintain another member's gear
--
--  The app shows an admin an enabled checkbox on someone else's
--  checklist, and toggleEquip() permits the change -- but the write
--  was never sent, so the UI reported success for nothing. The client
--  now sends the write; these policies are what let it land.
--
--  Note the existing inconsistency this closes: DELETE already carried
--  `or public.is_admin()`, while INSERT and UPDATE did not. The app
--  upserts (POST + merge-duplicates), which needs BOTH.
--
--  Idempotent. Run in: Supabase Dashboard -> SQL Editor -> New query
-- ══════════════════════════════════════════════════════════════

-- ── 1. Current state (read this output) ──
select policyname, cmd, qual, with_check
from pg_policies
where schemaname = 'public' and tablename = 'equipment_progress'
order by policyname;

-- ── 2. Replace the two own-rows-only policies ──
drop policy if exists "equip write own"           on public.equipment_progress;
drop policy if exists "equip update own"          on public.equipment_progress;
drop policy if exists "equip write own or admin"  on public.equipment_progress;
drop policy if exists "equip update own or admin" on public.equipment_progress;

create policy "equip write own or admin" on public.equipment_progress
  for insert to authenticated
  with check (user_id = auth.uid() or public.is_admin());

create policy "equip update own or admin" on public.equipment_progress
  for update to authenticated
  using      (user_id = auth.uid() or public.is_admin())
  with check (user_id = auth.uid() or public.is_admin());

-- ── 3. Verify: expect read-all, insert/update own-or-admin, delete own-or-admin ──
select policyname, cmd, qual, with_check
from pg_policies
where schemaname = 'public' and tablename = 'equipment_progress'
order by policyname;
