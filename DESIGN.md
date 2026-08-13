---
name: Mont Blanc Trek
description: A dark, near-flat RTL instrument panel for planning and walking one alpine trek.
colors:
  ink-black: "#0c0c0c"
  slate-panel: "#161616"
  slate-raised: "#1e1e1e"
  hairline: "#272727"
  hairline-strong: "#333"
  bone: "#e6e3dc"
  stone-muted: "#6b6660"
  stone-faint: "#4a4745"
  summit-brass: "#c9a84c"
  summit-brass-wash: "rgba(201,168,76,.12)"
  summit-brass-edge: "rgba(201,168,76,.3)"
  lichen-ok: "#4a9e6e"
  lichen-ok-wash: "rgba(74,158,110,.12)"
  ember-warn: "#d4883a"
  ember-warn-wash: "rgba(212,136,58,.12)"
  rockfall-danger: "#d95757"
  rockfall-danger-wash: "rgba(217,87,87,.12)"
typography:
  display:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "28px"
    fontWeight: 700
    lineHeight: 1
    letterSpacing: "normal"
  headline:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "18px"
    fontWeight: 700
    lineHeight: 1.5
    letterSpacing: "normal"
  title:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "13px"
    fontWeight: 600
    lineHeight: 1.3
    letterSpacing: "normal"
  body:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "14px"
    fontWeight: 400
    lineHeight: 1.5
    letterSpacing: "normal"
  label:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "11px"
    fontWeight: 600
    lineHeight: 1.5
    letterSpacing: "0.1em"
  data:
    fontFamily: "-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif"
    fontSize: "22px"
    fontWeight: 800
    lineHeight: 1
    letterSpacing: "normal"
rounded:
  edge: "2px"
  chip: "3px"
  control: "4px"
  floating: "8px"
  round: "50%"
spacing:
  hairline-gap: "2px"
  tight: "6px"
  snug: "10px"
  panel-y: "14px"
  panel-x: "18px"
  section: "24px"
  body-x: "32px"
components:
  button-primary:
    backgroundColor: "{colors.summit-brass}"
    textColor: "#000000"
    typography: "{typography.title}"
    rounded: "{rounded.edge}"
    padding: "10px"
  button-primary-hover:
    backgroundColor: "{colors.summit-brass}"
    textColor: "#000000"
  button-ghost:
    backgroundColor: "transparent"
    textColor: "{colors.stone-muted}"
    rounded: "{rounded.edge}"
    padding: "7px 14px"
  button-ghost-hover:
    backgroundColor: "transparent"
    textColor: "{colors.summit-brass}"
  button-danger:
    backgroundColor: "transparent"
    textColor: "{colors.rockfall-danger}"
    rounded: "{rounded.edge}"
    padding: "7px 14px"
  chip-filter:
    backgroundColor: "transparent"
    textColor: "{colors.stone-muted}"
    rounded: "{rounded.edge}"
    padding: "5px 12px"
  chip-filter-selected:
    backgroundColor: "{colors.summit-brass-wash}"
    textColor: "{colors.summit-brass}"
    rounded: "{rounded.edge}"
    padding: "5px 12px"
  input-field:
    backgroundColor: "{colors.ink-black}"
    textColor: "{colors.bone}"
    rounded: "{rounded.edge}"
    padding: "8px 11px"
  input-field-focus:
    backgroundColor: "{colors.ink-black}"
    textColor: "{colors.bone}"
  card-list-item:
    backgroundColor: "{colors.slate-panel}"
    textColor: "{colors.bone}"
    rounded: "{rounded.edge}"
    padding: "14px 18px"
  card-stat:
    backgroundColor: "{colors.slate-raised}"
    textColor: "{colors.bone}"
    typography: "{typography.data}"
    rounded: "{rounded.edge}"
    padding: "14px 16px"
  nav-tab:
    backgroundColor: "transparent"
    textColor: "{colors.stone-muted}"
    rounded: "{rounded.edge}"
    padding: "6px 14px"
  nav-tab-selected:
    backgroundColor: "{colors.ink-black}"
    textColor: "{colors.bone}"
    rounded: "{rounded.edge}"
    padding: "6px 14px"
  badge-status:
    backgroundColor: "{colors.lichen-ok-wash}"
    textColor: "{colors.lichen-ok}"
    rounded: "{rounded.edge}"
    padding: "2px 7px"
---

# Design System: Mont Blanc Trek

## Overview

**Creative North Star: "The Alpine Instrument Panel"**

This is not an app that wants to be admired; it is a panel of instruments read in bad light by someone who is tired. The ground is near-black (`#0c0c0c`), surfaces step up in almost imperceptible increments of grey, and every division is a single 1px hairline. Corners are 2px — effectively square. Nothing glows, nothing gradients, nothing floats unless it is physically above the map. The one non-neutral colour, a muted brass, is used the way a machined bezel is used: to mark the live control and nothing else.

The reason the restraint works is the map. Behind and beside every panel sits a 3D satellite render of the Mont Blanc massif with eight saturated route lines drawn across it. The chrome has to recede or the terrain becomes unreadable. So the interface deliberately spends its colour budget on data — one bright hue per hiking day, three status hues for booked / pending / unbooked — and keeps the frame monochrome. Where the interface does raise its voice it is always about a fact: a 28px number, a status pill, an ⚠️ payment still owed at Rifugio Elisabetta.

The language is Hebrew and the direction is right-to-left, natively — labels, drawers, active-state bars and the route sidebar all begin at the right edge. Latin place names sit inside that RTL flow untranslated, and the wordmark is wide-tracked uppercase Latin. That collision — Hebrew task language around French and Italian mountain names — is the system's actual signature and should not be smoothed away.

**Key Characteristics:**
- Near-black ground with three barely-separated surface steps; depth by tone, not shadow
- 2px corners everywhere; the interface reads as machined, not soft
- One brass accent, reserved for live state; all other colour is data or status
- Dense uppercase micro-labels (10–11px, `0.1em` tracking) over full-size headings
- System font stack only — no webfont, no display face
- RTL-first: leading edge is the right edge
- Colour saturation belongs to the map, not the chrome

## Colors

A monochrome instrument case with one brass control and a three-state status vocabulary; every saturated colour on screen is carrying information.

### Primary
- **Summit Brass** (`#c9a84c`): the single accent. Marks the live control and nothing decorative — the active nav tab's underline, the focused input's border, the selected filter chip, the active admin section's edge bar, the primary submit button, the countdown to departure. Also used as `#000` text on a brass fill for the one primary action per screen. Its 12%-alpha wash (`rgba(201,168,76,.12)`) is the "selected row" background across day cards, member rows, admin nav and geocoder results; its 30% edge (`rgba(201,168,76,.3)`) is the hover border on ghost controls.

### Secondary
- **Lichen** (`#4a9e6e`): confirmed and complete. Booked accommodation, equipment progress fills, "saved" states.
- **Ember** (`#d4883a`): in progress, or a fact that needs a human. Pending bookings, the ⚠️ warning block, warning toasts.
- **Rockfall** (`#d95757`): absent or destructive. Unbooked nights, delete actions, logout hover, auth errors.

Each status colour appears in two registers: full strength for text and icon strokes, and a 12%-alpha wash for the pill or block behind it. They are never used as decoration.

### Neutral
- **Ink Black** (`#0c0c0c`): the page ground, and also the *recessed* colour — inset fields, the day-hut strip inside a card, the selected nav tab. Recession, not elevation, is how this system marks "inside".
- **Slate Panel** (`#161616`): every chrome surface — topbar, sidebars, drawers, forms, list items, toast, map controls, map popups.
- **Slate Raised** (`#1e1e1e`): the one step above panel, for stat tiles and passive metadata pills.
- **Hairline** (`#272727`) / **Hairline Strong** (`#333`): all division. There is no other divider mechanism.
- **Bone** (`#e6e3dc`): primary text. Warm off-white, never pure `#fff` in chrome — pure white is reserved for elements sitting on top of the satellite map.
- **Stone Muted** (`#6b6660`): secondary text and every uppercase micro-label.
- **Stone Faint** (`#4a4745`): the quietest tier — permission descriptions, "view only" badges, quoted trip notes.

### Named Rules
**The Colour-Belongs-To-Data Rule.** If a saturated colour on screen is not (a) the brass on the one live control, (b) a booked/pending/unbooked status, or (c) a per-day route identity, it is wrong. Chrome is grey.

**The Two-Register Rule.** A status colour never appears as a bare tint. It appears as full-strength text or stroke on its own 12%-alpha wash, or not at all.

**The Warm-White Rule.** `#e6e3dc` in the interface; `#fff` only for marks drawn over the satellite map, where it is a casing colour against terrain.

## Typography

**Display Font:** none — the system UI stack (`-apple-system, BlinkMacSystemFont, 'Segoe UI', system-ui, sans-serif`)
**Body Font:** the same stack
**Label/Mono Font:** the same stack, differentiated by size, weight and tracking rather than family

**Character:** One family, working entirely through weight (400 → 800) and tracking. Hebrew body copy at native size and rhythm; Latin micro-labels squeezed to 10–11px and stretched to `0.1em` uppercase so they read as engraved plate text rather than prose. The contrast in the system is between *speaking* and *labelling*, not between two typefaces.

### Hierarchy
- **Display** (700, 28px, 1.0): admin stat-card figures only. One per tile, brass-coloured, the loudest thing on an admin screen.
- **Data** (800, 22px, 1.0): overview stat-card figures — nights, walking days, total km, metres of ascent. Colour-coded to what they mean, not decorated.
- **Headline** (700, 18px): the checklist owner's name ("הציוד שלי"); 16px/700 for admin section titles.
- **Title** (600, 13px, 1.3): the workhorse — day routes, hut names, member names, list-item names, primary buttons. Most of the interface lives here.
- **Body** (400, 13–14px, 1.5): descriptions, notes, equipment item names. `14px` is the document base.
- **Label** (600, 10–11px, `0.06em`–`0.12em`, uppercase): section headings, field labels, day numbers, status pills, role tags, the wordmark. The most characteristic type in the system.

Sizes step in 1px increments across roughly thirteen discrete values (10, 11, 12, 13, 14, 15, 16, 18, 19, 20, 22, 26, 28). This is a hand-tuned ladder, not a ratio scale, and it is not currently expressed as tokens.

### Named Rules
**The Engraved-Label Rule.** Any label that names a region, field, state or unit is 10–11px, weight 600, uppercase where Latin, tracked `0.1em`, in Stone Muted. Never sentence-case, never body weight.

**The Fixed-Scale Rule.** No `clamp()`, no `vw` type. Users read this at a consistent DPI on a phone or a laptop; a heading that shrinks inside a 240px sidebar looks broken, not responsive. Mobile raises specific sizes explicitly (equipment names 13 → 16px, form inputs → 16px to stop iOS zoom) rather than fluidly.

**The Hebrew-Is-Not-Uppercased Rule.** `text-transform: uppercase` is a no-op on Hebrew and is applied for the Latin labels and the wordmark. Do not add tracking to Hebrew body copy in imitation of it.

## Layout

A fixed, non-scrolling app shell. `html, body` are locked at `height: 100%; overflow: hidden`; only designated regions scroll. Structure is a 48px topbar over a `flex: 1` content row, with exactly one panel visible at a time (`.panel.on`).

Every panel is the same shape: a fixed-width sidebar pinned to the **right** (the leading edge), separated by a 1px `border-left`, with the flexible body on the left. Sidebar widths are literal and per-panel: 300px for the day list, 240px for the info panel, 190px for admin nav. Bodies get `28px 32px` padding; sidebars get `14px 18px`. The map is the one exception: it is absolutely positioned inside its flex wrapper so MapLibre can own its box.

Density is deliberate. Sidebar rows are 9–14px tall with hairline separators and no gaps; the interface stacks facts rather than spacing them.

**Responsive behaviour is structural, at exactly one real breakpoint (768px), with a 480px touch-up.** At mobile the topbar is removed entirely and replaced by a floating hamburger and a right-edge drawer; the map's day sidebar rotates from a vertical 300px column into a 210px-tall horizontal scroller of 170px cards; the info sidebar collapses to just its tab strip; the admin sidebar becomes a second left-edge drawer behind a title bar. Filter bars become horizontal scrollers with hidden scrollbars rather than wrapping. Bottom padding uses `max(32px, env(safe-area-inset-bottom))` for notched phones.

Spacing values are chosen per component rather than drawn from a scale; `14px / 18px` (panel) and `24px / 32px` (body) are the two recurring pairs.

## Elevation & Depth

**This system is flat.** There is no elevation ladder, no ambient shadow, no hover lift. Depth is communicated by three tonal steps (`#0c0c0c` → `#161616` → `#1e1e1e`) and 1px hairlines — and, distinctively, *downward*: an inset field or a selected tab drops to the darkest tone rather than rising.

Shadows exist for exactly one reason: an element is physically above the satellite map or above the app. That is the whole vocabulary.

### Shadow Vocabulary
- **Over-map float** (`box-shadow: 0 8px 24px rgba(0,0,0,.6)`): the toast, and MapLibre popups. Says "this is above the terrain".
- **Marker lift** (`box-shadow: 0 2px 8px rgba(0,0,0,.7)`, and `filter: drop-shadow(0 2px 6px rgba(0,0,0,.7))` on hut markers): separates a mark from aerial imagery it would otherwise disappear into.
- **Floating control** (`box-shadow: 0 2px 12px rgba(0,0,0,.5)`): the mobile hamburger, which sits over live content.
- **Scrim** (`background: rgba(0,0,0,.65)`): drawer overlays. Not a shadow — an occlusion layer.

### Named Rules
**The Flat-Until-You-Float Rule.** A shadow is permitted only on an element physically above the map canvas or above the app shell. Cards, panels, tiles, list items, forms, drawers and buttons stay flat forever; they separate by tone and hairline. No hover lift, no `translateY(-2px)`, no glow.

**The Recess Rule.** "Inside" and "selected" go *darker* (to Ink Black), not lighter. Elevation in this system points down.

## Shapes

Sharply machined. `--radius: 2px` is the global corner and it reads as square at every size; it is applied to buttons, inputs, chips, cards, pills, tiles, panels and the toast alike. Only four exceptions exist, each earned: `3px` on map marker labels, `4px` on the hamburger's bars, `8px` on the floating mobile hamburger (a physically separate object), and `50%` on things that are genuinely circular — avatars, day-number bubbles, legend dots, hut markers.

Borders do the work radius doesn't: every surface is defined by a 1px `--border` hairline, and state is expressed by changing a border's colour rather than its weight. Active states use a 2–3px coloured edge bar on **one side** of the element, and in this RTL layout that bar belongs on the **right** (leading) edge. The mountain-pass markers on the map use `clip-path: polygon(50% 0%, 0% 100%, 100% 100%)` — a triangle for a col, a circle for a refuge — the only non-rectilinear form language in the system.

## Components

### Buttons
- **Shape:** effectively square (2px radius), no shadow, ever.
- **Primary:** brass fill (`#c9a84c`) with `#000` text at 600 weight, 13px, `0.04em` tracking. Full-width `10px` padding in auth; `7px 14px` as `.btn-sm.primary` in admin. One per form.
- **Ghost (the default):** transparent on a hairline border, Stone Muted text. Hover swaps the border to `summit-brass-edge` and the text to brass — no fill, no movement.
- **Danger:** Rockfall text on a danger-wash border; hover fills with the 12% wash. Never a solid red button.
- **Hover / Focus:** `transition: all .15s` on colour properties only; primary buttons drop to `opacity: .85`; disabled drops to `.4` with `cursor: not-allowed`. Global `:focus-visible` is a 2px brass outline at `2px` offset.

### Chips
- **Style:** two near-identical families — `.filter-btn` (equipment categories) and `.map-ctrl` (3D / route / huts toggles). Both are ghost buttons at chip scale: hairline border, Stone Muted text, 2px corners.
- **State:** selected is brass text on `summit-brass-wash` with a `summit-brass-edge` border. Selected and hover are rendered identically — deliberate on a toggle, so the control previews its own on-state.
- **Status pills** (`.status-badge`, `.member-role`, `.country-flag`, `.user-tag`): 10px, `0.06em`, `2px 7px`, no border, status colour on its own wash. These are read-outs, not controls.

### Cards / Containers
- **Corner Style:** 2px.
- **Background:** Slate Panel for list items, forms and side panels; Slate Raised for stat tiles.
- **Shadow Strategy:** none — see Elevation.
- **Border:** 1px hairline. `.list-item` brightens its border to `--border2` on hover; that is the entire hover treatment.
- **Internal Padding:** `14px 18px` for rows, `18–20px` for forms and tiles.
- **Row cards** (`.day-card`, `.member-card`, `.member-progress`) are borderless full-bleed rows separated by a single `border-bottom` hairline, with a `rgba(255,255,255,.02)` hover — a 2% lift, at the threshold of perception, and correct for this system.

### Inputs / Fields
- **Style:** recessed — Ink Black fill inside a hairline border, Bone text, 2px corners, `8px 11px` (`9px 12px` in auth). Labels sit above at 11px uppercase Stone Muted.
- **Focus:** border colour shifts to brass. No glow, no ring, no size change.
- **Checkbox:** a fully custom 16px `appearance: none` box (24px on mobile) that fills brass when checked and draws a black tick from a rotated bordered pseudo-element. It carries an explicit `:focus` outline of its own.
- **Select:** identical to the text input; `option` elements are painted Slate Panel so the native dropdown does not flash white.
- **Autocomplete:** results drop from the field as an absolutely positioned Slate Raised list with a `--border2` border and no top border, so it reads as an extension of the input rather than a floating menu.

### Navigation
Three coordinated layers, all label-only — no icons anywhere in this system.
- **Desktop topbar tabs** (`.nav-btn`): 12px uppercase `0.06em` Stone Muted; active goes *darker* (Ink Black fill) with Bone text.
- **Desktop side nav** (`.admin-nav-item`, `.info-tab`): full-width right-aligned rows; active state is a brass edge bar plus `summit-brass-wash`. The info tabs instead use a 2px brass **bottom** border — the one place the active indicator is horizontal, because they are a tab strip rather than a list.
- **Mobile drawers**: the primary drawer slides in from the **right** (`right: -300px → 0`, 280px, `.25s cubic-bezier(.4,0,.2,1)`) behind a 65% scrim, at 15px/500 with 14px 20px rows — deliberately larger than the desktop equivalents. The admin sub-drawer is the same object at 260px sliding from the left.

### Signature Component: the map mark set
The system's most product-specific work, and the place the palette inverts — pure white, full saturation, real shadows, because these sit on aerial imagery.
- **Hut marker:** a 34px circle in that day's route colour, 3px `rgba(255,255,255,.9)` border, day number inside, a CSS triangle tip below drawn from `currentColor`, a truncated name plate under it (`rgba(0,0,0,.82)`, 9px), and `scale(1.25)` on hover. Booked and pending add an outer `box-shadow` ring in green or amber.
- **Day-number bubble:** a 28px circle at 40% along each day's line, `scale(1.3)` on hover, click-linked to the matching day card.
- **Pass marker:** 18px brass-to-day-colour triangle for a col, 12px circle for a refuge.
- **Route line:** three stacked strokes per day — a 14px black shadow at 0.35, a 10px white casing at 0.9, and a 6px day-colour line — so a saturated trail stays readable over snow, rock and forest alike. Selecting a day drops the others to 0.15 opacity and 2px.

### Toast
The system's only global feedback channel: bottom-centred, Slate Panel, 2px corners, `10px 18px`, 12px text, over-map shadow, `opacity` fade over `.25s`, auto-dismissed at 2200ms. Its border colour carries the semantic (ok / warn / err); the text takes the matching status colour.

## Do's and Don'ts

### Do:
- **Do** keep chrome monochrome and spend colour on data. Brass = live control; green/amber/red = booking status; the eight bright hues = hiking days.
- **Do** use 2px corners for everything rectangular. Reserve `50%` for genuinely circular objects and `8px` only for something floating free of the layout.
- **Do** separate with a 1px `--border` hairline and a tonal step. That is the whole depth system.
- **Do** put the active-state edge bar on the **right** (leading) edge, and keep it 2–3px.
- **Do** write region, field and unit labels at 10–11px, weight 600, `0.1em` tracking, Stone Muted.
- **Do** keep transitions at `.15s` on colour and border only, and `.25s` for drawers and the toast.
- **Do** use pure `#fff` and real shadows on marks drawn over the satellite map — that is where the palette legitimately inverts.
- **Do** make responsive changes structural (column becomes horizontal scroller, sidebar becomes drawer) and bump specific font sizes explicitly at 768px.
- **Do** keep form inputs at `16px` on mobile so iOS does not zoom on focus.

### Don't:
- **Don't** add a box-shadow to anything that is not physically above the map or the app shell. No card shadows, no hover lift, no glow.
- **Don't** make "selected" lighter. Selected and inset go darker, to Ink Black.
- **Don't** introduce a webfont or a display face. One system stack, differentiated by weight and tracking.
- **Don't** use `clamp()` or viewport-relative type. The ladder is fixed and hand-tuned.
- **Don't** use brass for decoration, large fills, or inactive states. If it is not the live control, it is grey.
- **Don't** introduce a second radius, a second divider mechanism, or a fourth surface tone.
- **Don't** add icons to navigation. This system is label-only, and its labels are its character.
- **Don't** apply `letter-spacing` or `text-transform: uppercase` to Hebrew body copy.
- **Don't** put a saturated status colour on screen without its 12%-alpha wash behind it.
- **Don't** reach for a modal. The existing system has none: it uses panel switching, inline drawers, inline forms and native `confirm()` for destruction.
