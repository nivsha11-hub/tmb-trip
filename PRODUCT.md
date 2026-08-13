# Product

<!-- impeccable:product-schema 1 -->

## Platform

web

## Users

Hebrew-speaking members of one private hiking group planning and walking the Tour du Mont Blanc. Two confirmed roles:

- **מנהל (admin)** — owns trip truth: adds/edits accommodation, route segments, trip dates and notes, and promotes/demotes members. Works mostly at a desk during planning, on a phone during the trip.
- **מטייל (member)** — reads the route and booking status, and maintains their own equipment checklist. Can view (not edit) other members' checklists.

The job: know where we sleep each night, whether it is actually booked, what each day of walking costs in km and ascent, and whether every person has their gear.

## Product Purpose

A single shared source of truth for one multi-day alpine trek, replacing a scatter of WhatsApp messages, booking emails and spreadsheets. Success is that on any evening of the trip, any member can open the app on a phone and get the next day's route, the night's accommodation and its booking status, without asking anyone.

## Positioning

Combines three things a generic trip planner keeps apart: a 3D terrain route map with the actual traced TMB trail, per-night booking status, and per-person gear readiness — for one private group, in Hebrew RTL, with no accounts to sell or trips to browse.

## Operating Context

- **Planning phase** (current): desktop and phone, at home, admin entering huts and segments, members ticking gear.
- **On-trail phase**: phones only, often weak signal, outdoors in daylight, one-handed.
- Accommodation spans France, Italy and Switzerland; hut contact details are phone numbers and booking websites, not an API.
- Multiple devices edit concurrently; realtime sync plus a localStorage cache is the mechanism.
- Companion artifacts in the repo: `supabase-setup.sql`, `supabase-fix-policies.sql` (schema + RLS), `vercel.json` (deploy).

## Capabilities and Constraints

- **Single file.** The entire app is `index.html` — inline CSS and inline JS, no build step, no bundler, no framework. New work must not introduce one without the user's decision.
- **Stack** (existing, not up for re-decision): Supabase auth + Postgres + realtime, MapLibre GL 3.6.2, Esri World Imagery raster tiles, AWS `terrarium` DEM for terrain, Photon (Komoot) for OSM geocoding. All third-party services are keyless/free tiers except Supabase.
- **Data shape:** the whole trip lives as JSON in one row (`trip_data` id=1: `huts`, `segments`, `trip`). Equipment progress is one row per `(user_id, item_id)` in `equipment_progress`. Profiles carry `display_name`, `role`, `email`, `joined_at`.
- **The equipment list is code**, not data — the `EQUIPMENT` const. Adding a gear item is a code edit.
- Supabase email confirmation is **ON**; signup returns no session and the user must confirm by email before first login.
- Implicit auth flow on purpose (not PKCE), so the confirmation link works when opened on a different device.
- 30-minute inactivity auto-logout.
- **Hebrew RTL only.** `dir="rtl"`, `lang="he"`. No i18n layer and none planned.
- `DEFAULT_HUTS` / `DEFAULT_SEGMENTS` / `DEFAULT_TRIP` are seed defaults for a first run, overridden by whatever is in Postgres.

## Brand Commitments

- Name: **Mont Blanc Trek** — shown as an uppercase, wide-tracked Latin wordmark even inside the Hebrew UI.
- Interface language is Hebrew; place names, hut names and pass names stay in their original Latin/French/Italian spelling.

## Evidence on Hand

- **Real bookings**, with real phone numbers and booking URLs, in `DEFAULT_HUTS` — including a real outstanding payment note on Rifugio Elisabetta (~€35 due on arrival).
- **Real trail geometry**: per-day coordinate arrays in `TMB_DAYS` traced from the *Tour of Mont Blanc Anti-Clockwise* map, plus 22 named passes/waypoints with elevations in `TMB_PASSES`.
- No testimonials, no customers, no pricing, no benchmarks, no uptime or licensing claims exist. Future work must not invent any.

## Product Principles

1. **The database is the truth.** The UI may never say "saved" for something that is only in localStorage; a failed write is rolled back in memory, not hidden.
2. **One group now, reusable later.** The app serves this group's trip, but trip facts belong in the database and the admin panel — not newly hard-coded into the source.
3. **Hebrew RTL is the native direction**, not a retrofit. Leading edge is the right edge.
4. **Members read, admins write.** Anything a member cannot change should not look editable.
5. **It has to work on a phone with a bad signal**, outdoors, in one hand.

## Accessibility & Inclusion

No formal standard is required (private group, no compliance obligation). The working bar is "reasonable": text must stay legible on a phone in daylight, and every action must be reachable without a mouse.
