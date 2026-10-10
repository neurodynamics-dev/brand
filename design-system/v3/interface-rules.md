# Interface rules for NeuroDynamics

Read this file first when building or correcting any screen (site, Portal do Membro, ERP, internal tools, kiosk, mobile). It is the contract. Reference implementations live in the card templates listed in section 12; open the matching card before writing a component and copy its structure, spacing and states. The foundation (palette, type, radii) is in `readme.md` and `tokens/`; where the two disagree, this file wins for interfaces.

## 1. How to work

**Building a screen**
1. Pick the register: interfaces are always the expressive register, primary set, dark Void ground. Formal (serif, paper) is for documents only and never appears in product UI.
2. Name the screen's one main action. It gets the only solid Synapse button.
3. Lay out with the navigation hierarchy (section 6), then content in cards, then states.
4. Use components from `components/core` and `components/interface` through `window.NeuroDynamicsDesignSystem_10bbff`. Never restyle them; compose them. Never invent a component that a card already shows.
5. Run the checklist in section 13 before delivering.

**Correcting a screen**
1. Audit against section 13 and list each violation with its rule number.
2. Fix with tokens and components, not new CSS values. Replace hard-coded hex, px radii and font names with variables.
3. Change only what violates a rule. Do not redesign, rename or re-space what is already right.

## 2. Non-negotiables (the short list)
- Dark: Void `--void` page, Painel `--painel` raised panels, cards with 1px `--line` border, 18px radius, 3% white fill. No drop shadows for elevation.
- **Synapse is rare**: focus, the single solid CTA, and tiny marks (active tab bar, active child tick, unread badge). It is never a selection fill, never a status, never a large area, never a family band colour.
- Primary set only for glow, blur, gradient, glass and transparency: Cortex, Axon, Synapse. Every other family is flat (fills, text, rules).
- Functional colours (Nominal, Caution, Critical, Signal, Idle) only for states. Never for identity or decoration.
- Archivo for titles and labels, Instrument Sans for running text, IBM Plex Mono only for codes and data.
- No pill shapes. No emoji. No middle dots. No em dashes as separators. Titles and subtitles are never bold beyond the weights below.
- Icon-only for utility actions; labels always visible on fields.
- Touch targets 44px or more on mobile. Respect `prefers-reduced-motion`.

## 3. Type
| Role | Font | Spec |
|---|---|---|
| Display, titles | Archivo 600 | tracking -.025em display, -.015em headings; line-height 1.02 on display |
| Labels, eyebrows, footer lines | Archivo 600 uppercase | 9.5 to 11.5px, tracking .12 to .18em (.14em default) |
| Running text | Instrument Sans 400/500 | 15px / 1.65; secondary text same weight in Névoa |
| Data, codes, indices | IBM Plex Mono 400/500 | numbers in tables, readouts, hex, document codes, list indices (01, 02) |
| Big glanceable numbers | Archivo 300 | widgets and kiosks |

- Plex Mono never for labels, titles, dates, footer lines, eyebrows or nav text. A time or a count used as data (10:29, 128,4 ms) may be mono; a heading like "Hoje" never is.
- Secondary text is the same weight one tone lighter (Névoa, or Grafite for the quietest), never lighter weight, never italic for emphasis.
- Sentence case for headings. Uppercase only for labels. Text left-aligned, never justified.
- Brazilian Portuguese first. Separators 1.284 and 0,94. No middle dots: separate with commas, line breaks, gaps or layout.

## 4. Colour in interfaces
- Text on Void: Ink (full), Névoa (secondary), Grafite (quiet, labels only, never body). Check WCAG on the contrast card; body text at least 4.5:1.
- Synapse text or fills on Void are fine; Synapse text on light surfaces is not (use Axon).
- Selection (chips, Segmented, FilterBar values, SectionNav) is quiet: 9% white fill and ink. Never Synapse. Counts that describe a state the user already set (applied filters) stay neutral; counts of something pending (notifications, new items) may be Synapse.
- States use the functional set: field ok Nominal, error Critical, destructive button Critical, info and live data Signal, offline or disabled Idle. An error message always says how to fix it.
- Secondary families (Ion, Neuron, Glia, Retina, Nexo, Dendrito, Íris, Plexo, Impulso, Ritmo, Lúmen) are complements in isolated contexts: a family Band, a highlight widget slide, a data chart. One family per surface. Never beside Synapse or a Cortex CTA. Purple families (Nexo, Dendrito) always in more than one tone.
- Light ambient (when a screen needs it) swaps ground, ink and lines through the variables and uses Axon instead of Synapse for accents. Logos invert accordingly.

## 5. Shape, space, motion
- Radii: 11 (buttons, fields), 14, 18 (cards, base), 20, 24. Chips 6px and visibly shorter than buttons (about 26px). Status pills and tags 5px. Count badges 4px. `--r-pill` is retired. Avatars and glow blobs may be circles; nothing interactive is a pill.
- Spacing on the 4px scale (`--s1` to `--s10`). Gaps with flex or grid `gap`, not margin chains.
- Motion .15s and .25s, `--ease`, no bounces. Hover: solid button lifts 1px with the Synapse glow; ghost fill .03 to .07. Disabled opacity .4. Focus ring 2px Synapse, offset 2px, always visible on keyboard focus.
- Glass, blur, the background grid and blobs only on primary-set surfaces (header, dialog backdrop, kiosk, hero).

## 6. Navigation
Hierarchy, always in this order, never reversed:
1. **SectionNav**: first selector on any screen.
2. **Tabs**: inside a section.
3. **Segmented**: one exclusive filter.
4. **FilterBar**: several options active at once (OR within a group, AND across groups); active values appear as removable tags.

Containers:
- **Sites**, desktop: floating glass `SiteHeader` (14px from top, 16px radius). Mobile: `MobileSiteMenu`.
- **Apps**, desktop: `SideMenu` (252px open, 68px rail with fly-out). Mobile: `MobileAppMenu` drawer.
- `Breadcrumb` for depth of three or more levels.

SideMenu details: imagotipo when open, solid square icon (white) when collapsed. Collapsed search is a plain icon item like the others. Bottom block, top to bottom: Avisos, a row of tiny icon buttons (collapse, light/dark, report a bug on this page), then the user profile, always last. When collapsed only the expand button remains of that row, between Avisos and the avatar. Starts collapsed below 1280px unless the person chose otherwise.

### Mobile navigation (phones)
- **Site, closed**: floating glass header with the imagotipo on the left and a 46px menu button on the right. Nothing else. The language switch is not shown.
- **Site, open**: the header stays; the button becomes close; a small language switch (EN PT FR, about 24px) appears beside it. Below: a numbered list (index in Plex Mono, link in Archivo 600 at 32px, 76px rows, 1px lines), active link in ink with a Synapse square, others Névoa. Footer lines at the bottom in Archivo 600 uppercase, tracking .14em, never mono.
- **Page eyebrow** on mobile: Synapse square plus Archivo 600 uppercase label, never mono.
- **App, closed**: the bare symbol (`icon-square-solid`, no frame) is the home button at the left; a menu button at the right.
- **App, open**: a drawer at 84% width over a dimmed page. The full imagotipo takes the place of the symbol, in the same spot, so the mark is never duplicated; the system tag (for example "Portal do membro", Synapse text, no fill) sits below it without moving the logo. No home icon. Search, then accordion sections (44px or taller rows, chevron, sub-items under a 1px rule with a Synapse tick on the active one), then Notificações and the user row at the bottom.

## 7. Forms
- Label always visible above the field (Archivo 600 uppercase 10.5px). Placeholder is an example, never the label.
- Border always present, 16% line. Focus: Synapse border plus a 4% veil. Error: Critical border and a hint that says how to fix it.
- Selects never use the native list: custom listbox on Painel, 16% border, 11px radius, 34px options, hover 6% white, selected in ink 600 with a check.
- In-field utility actions (copy, paste, clear, reveal) are icon-only, quiet (5.5% white veil, Névoa icon, never Synapse), max two, via `Field actions`. A single-field form may use `Field submit`: one icon-only Synapse send button inside the border.
- Buttons: one solid Synapse per screen; ghost for secondary; `danger` (Critical) for destructive. Labels with a verb ("Baixar PNG"), never a bare "OK". Sizes md 44px, mini 34px.
- A Switch is for 2 or 3 exclusive options (language, state). Filters use Segmented; final actions use Button.

## 8. Data
- Numbers in Plex Mono, right-aligned; text left. Row lines 8%, header line 16%, no zebra.
- One family per chart. Proportion bars use the four tones of that family. Small comparison bars are discrete ticks: a tick of width x then a 3x gap (1,5px and 4,5px by default), square ends, never rounded fills that collapse into ellipses.
- `Metric` for a headline number with delta; `DataGrid` for tables (DataTable is for paper documents only); `SpecList` for key and value pairs; `BarList` for ranked bars.

## 9. Feedback
- Toast for passing confirmation (4,2s), never a decision. Dialog for decisions. Alert inline.
- Empty state always has an action. Skeleton when the shape is known; spinner or Progress when it is not.
- Status colour always has a text label or icon; colour alone never carries meaning.

## 10. Widgets and kiosks
- A Widget is a Sulco panel. It may rotate glanceable content (10 to 15 s, at most 4 slides) with a segmented progress; clock, check-in, QR and presence never rotate. A widget with nothing to show skips its slide.
- Notices, welcomes and presence gamification may take one secondary family per slide (Lúmen for streaks and the Placar). The personal check-in moment glows in the primary set (Axon, Cortex), is celebratory and never Synapse.
- Kiosk: fixed check-in column on the right (420px), the rest fills. Expressive background (Cortex grid, Axon blob); a second blob and the sun arc shift discreetly with the time of day (dawn Lúmen, day Synapse 5%, dusk Ritmo, night Retina).
- Family bands: one family per band, the button in the same family, a large faint icon at the right edge behind the text (6% opacity), never Synapse.

## 11. Marks and imagery
- Imagotipo: solid black or white (or one family tone). Never Synapse, never stretched, never inverted from the black file (the white file is its own drawing).
- Square icon: when the imagotipo does not fit (collapsed menu, favicon, small avatar). Never repeated beside the imagotipo.
- Symbol (green, `icon-colored-*`): round frames and profile pictures only. White wave: internal systems only (ERP icon).
- Icons: no brand set exists. Use a thin-stroke set (1.5 to 1.8px) and flag it as a substitution. Unicode glyphs allowed: arrows, check, !, x, i.
- Photos: rectangular or 18px radius, no filters. Use placeholders until real material is supplied; do not draw imagery in SVG.

## 12. Card templates (the visual source of truth)
Open the card, then copy its structure. Each is a runnable HTML file.

| Need | Card template |
|---|---|
| Colour roles, contrast, usage | `guidelines/colors-1-primary.html` to `colors-6-contrast.html` |
| Type modes and kickers | `guidelines/type-operational.html`, `type-executive.html`, `type-kickers.html` |
| Surfaces, radii, spacing | `guidelines/surfaces.html`, `radii.html`, `spacing-scale.html` |
| Logo, icons, seal, bands, expressive background | `guidelines/brand-logo.html`, `brand-icons.html`, `brand-seal.html`, `brand-band.html`, `brand-expressive.html` |
| Core controls (Button, IconButton, Chip, Tag, Pill, Switch, Alert, Card, Eyebrow) | `components/core/core.card.html` |
| Forms and fields | `components/interface/forms.card.html` |
| SectionNav, Tabs, Segmented, FilterBar, Breadcrumb, SiteHeader | `components/interface/navigation.card.html` |
| App side menu | `components/interface/sidemenu.card.html` |
| Mobile menus (site and app) | `components/interface/mobile-navigation.card.html` |
| Tables, charts, metrics | `components/interface/data.card.html` |
| Toast, dialog, empty, skeleton, progress | `components/interface/feedback.card.html` |
| Functional states | `components/interface/functional-set.card.html`, `functional-compositions.card.html` |
| Widgets, kiosk, bands | `components/interface/widgets.card.html` |

Prop-level usage for every component is in the sibling `<Name>.prompt.md` and `<Name>.d.ts`.

## 13. Delivery checklist (audit table)
| Violation | Fix |
|---|---|
| Synapse as a selection fill, status, large area or family band | Quiet selection (9% white and ink); functional colour for status; family colour for bands |
| Plex Mono on a label, eyebrow, footer line, nav item or title | Archivo 600 uppercase for labels; Instrument Sans for text |
| Middle dot, em dash or "|" used as a separator | Comma, line break, gap, or separate elements |
| Pill-shaped chip, tag or button (radius 999 or 50%) | 6px chip, 5px tag, 11px button |
| Glow, blur or gradient in a secondary or functional colour | Primary set only; secondary and functional stay flat |
| Two hue families on one surface | One family plus neutrals |
| Hard-coded hex, px radius or font name | Token (`--axon`, `--r`, `--fd`) |
| Field without visible label or border | Add the label (uppercase 10.5px) and 16% border |
| Native select list | Custom listbox |
| Two solid Synapse buttons on a screen | Keep one; demote the rest to ghost |
| Navigation hierarchy reversed (Tabs above SectionNav) | SectionNav, then Tabs, then Segmented or FilterBar |
| Logo repeated, or square icon beside the imagotipo | One mark per place |
| Touch target under 44px on mobile | Enlarge the hit area (the glyph can stay small) |
| Colour as the only status signal | Add text or icon |
| Drop shadow for elevation | Border and surface tone |
| Language switch visible in a closed mobile header | Show it only when the menu is open |
| Emoji or decorative unicode | Remove; use the allowed glyphs |
| Motion without a reduced-motion fallback | Wrap in `prefers-reduced-motion` |

Also verify: copy in Brazilian Portuguese, sentence case, Brazilian number format, document codes in the `NRO-XXX-000` pattern, no console errors, and that every interactive element has a hover, focus and disabled state.

## 14. Prompt starters for a model
- Build: "Read `interface-rules.md`. Build [screen] for [Portal do Membro | ERP | site] using the existing components. Main action: [verb]. Start from the matching card in section 12. Deliver a runnable HTML file and the section 13 checklist result."
- Correct: "Read `interface-rules.md`. Audit [file] against section 13, list violations with section numbers, then fix only those. Keep layout and copy unchanged."
