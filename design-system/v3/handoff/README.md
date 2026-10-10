# Handoff: NeuroDynamics Design System

Three jobs in one package. Read this file first, then the brief for the job at hand:

1. **Front-end implementation** of the design system (this file).
2. **Brand manual**: `handoff/BRIEF_BRAND_MANUAL.md`.
3. **Team training** on the brand concepts: `handoff/BRIEF_TRAINING.md`.

All paths below are relative to the project root (the folder that contains `handoff/`). `readme.md` at the root is the single source of truth for every rule; when this file and `readme.md` disagree, `readme.md` wins. `screenshots/` (if present) holds captures of the cards and templates for quick reference.

## Overview
NeuroDynamics builds technology tools for health (neurotechnology, clinical signal analysis, internal research platforms), operating like a startup out of LABBIO, Escola de Engenharia, UFMG (Belo Horizonte). The system covers two domains: **Documents** (read, printed, presented) and **Interface** (site, Portal do Membro, ERP, internal tools, kiosk widgets).

## About the design files
Everything here is a **design reference built in HTML/JSX**: it shows intended look and behaviour; it is not production code to paste in. Recreate it in the target codebase with its own patterns (React, Vue, Svelte…). With no codebase yet, React + TypeScript + CSS variables is the natural fit: the references are already React components with `.d.ts` contracts.

Usable as-is:
- `tokens/*.css` and `styles.css`: plain CSS custom properties. Import directly, or translate to the codebase's token format (Tailwind theme, CSS-in-JS theme, Style Dictionary).
- `assets/`: final PNG/SVG marks.
- `templates/email/*.html`: final send-ready e-mails, for the e-mail tool, not the front-end.

Ignore: `_ds_bundle.js`, `_ds_manifest.json`, `_adherence.oxlintrc.json`, `support.js`, `ds-base.js` (tooling for the design environment), `uploads/`, `screenshots/` at the root (working captures).

## Fidelity
**High fidelity.** Colours, type, radii, spacing, states and motion are final. Recreate pixel-accurately.

## How to open the references
- Serve the project root with any static server (`npx serve .`).
- Foundation cards: `guidelines/*.html`. Component cards: `components/*/*.card.html` (they load `_ds_bundle.js` and `styles.css` by relative path).
- Templates: `templates/<name>/<Name>.dc.html`.
- Each component has three files: `Name.jsx` (reference implementation, inline styles), `Name.d.ts` (props contract; **the usage rule is in its doc comment, read it before implementing**), `Name.prompt.md` (examples, do/don't).

## Implementation order
1. **Tokens.** `styles.css` imports `tokens/fonts.css`, `palette.css`, `functional.css`, `colors.css`, `typography.css`, `spacing.css`, `base.css`, `formal.css`. Keep family-tone names (`--cortex-dark`, `--fn-critical-primary`); components consume semantic aliases (`--surface-page`, `--text-secondary`, `--accent`).
2. **Core** (`components/core/`): Button, IconButton, Switch, Pill, Tag, Chip, Eyebrow, Card, Alert.
3. **Interface** (`components/interface/`): Field, SectionNav, Tabs, Segmented, FilterBar, Breadcrumb, SiteHeader, SideMenu, Metric, DataGrid, BarList, ProportionBar, SpecList, Toast, Skeleton, Progress, EmptyState, Dialog, Band, Widget.
4. **Formal** (`components/formal/`): Letterhead, SignatureBlock, DataTable, Kicker. Only if the front-end generates documents (PDF reports, certificates).
5. **Shells**: site (floating glass SiteHeader on Void) and app (SideMenu 252px open, 68px collapsed rail with fly-out).

## Design tokens

### Colour (families, four tones: light, medium, primary, dark)
**Primary set, Cortex**, the only colours allowed in glows, blurs, gradients, glass:
- `--cortex-light` #E3EFEC, `--cortex-medium` #A9CCC4, `--cortex-primary` #00594F (**Axon**), `--cortex-dark` #00352F (**Cortex**, signature), `--cortex-accent` #CEDC00 (**Synapse**: focus and single CTA only).

**Neutral set**
- Sulco: #616C68 (Grafite, captions), #1D1D1F, #0B1210 (Painel, raised panels), #050807 (Void, page)
- Pia: #E8EDEB (ink, body text on dark), #C4CCC9 (rules), #9AA5A1 (Névoa, secondary text), #2E3533
- Medula (warm paper): #F7F4EE, #E6DFD3, #C9BFAF, #4A453E

**Secondary set** (flat only; one family per surface; in interfaces only where Cortex is not in use on that surface):
| family | light | medium | primary | dark |
|---|---|---|---|---|
| Ion | #D9F7F2 | #93E8DB | #5BBFB0 | #0B4F48 |
| Neuron | #E4F2E3 | #B3D9B0 | #5AA65E | #1F4A22 |
| Glia | #E9EFEA | #C3D3C7 | #8AA894 | #2E4636 |
| Retina | #E0E6FC | #A9B9F6 | #3456E3 | #142A75 |
| Nexo | #E7E5FA | #BAB4F0 | #5A4ED4 | #251C66 |
| Dendrito | #EEE8FE | #CDBEFC | #A78BFA | #3B2378 |
| Lúmen | #FFF9D6 | #FFEE8A | #FFD91A | #594A00 |
| Ritmo | #FFEDE0 | #FFCBA6 | #FF9B5E | #6B2E08 |
| Impulso | #FFE4E6 | #FFAEB5 | #FF4F61 | #6E0A1A |
| Plexo | #FFE6F0 | #FFB9D3 | #FF70A6 | #6B0F38 |
| Íris | #F8E7FC | #EBBAF5 | #D676EB | #4E0F5E |

**Functional set** (interface states only; never in documents or as identity):
| state | light | medium | primary | dark |
|---|---|---|---|---|
| Nominal (success) | #D6FFEE | #7DFFC8 | #00F59B | #00422A |
| Caution (warning) | #FFF1CC | #FFD470 | #FFAA00 | #4D3300 |
| Critical (error) | #FFE0DD | #FF948C | #FF2D20 | #5C0A05 |
| Signal (info, live) | #D4F5FF | #7FE0FF | #00C8FF | #003A4D |
| Idle (offline) | #E6E8EE | #B8BDCC | #7C8499 | #2A2F3D |
Dark UI: dark tone as ground, primary only for lines and indicators (never text), medium for labels, light for values.

**Roles**: `--line` rgba(245,245,247,.08); `--line2` rgba(245,245,247,.16); `--card` rgba(255,255,255,.03); `--glass` rgba(7,12,10,.62); `--blur-glass` blur(18px) saturate(1.5); `--shadow-cta` 0 8px 26px rgba(206,220,0,.22).

**Pairing**: light ground with the family dark; dark ground with white; primary ground with the family dark, except Cortex, Retina and Nexo primaries, which take white.

### Typography
Google Fonts (`tokens/fonts.css`): Archivo 300–700, Instrument Sans 400/500/600 + italic, Instrument Serif regular + italic, IBM Plex Mono 400/500.

**Operational mode** (default; all interfaces and digital channels):
- Titles: Archivo 500–700; tracking −.015em headings, −.025em display; display line-height 1.02.
- Labels: Archivo 600 uppercase, 10.5–11px, tracking .12–.18em.
- Running text: Instrument Sans 400/500, 15px / 1.65.
- Status, codes, data, table numbers: IBM Plex Mono, right-aligned in tables.
- Secondary text: same weight, one tone lighter (Névoa). Never bold for hierarchy.
- Scale: display clamp(40px,6.8vw,88px); h1 clamp(36px,6vw,72px); h2 clamp(26px,3.8vw,42px); h3 16; body 15; sm 13.5; xs 12.5; label 11; micro 10.

**Executive mode** (formal documents only: certificates, formal reports, invitations, formal decks, business cards; never product UI): Instrument Serif, never bold, for headlines, names, quotes; Archivo Light 300 text (10.5pt print). Never Plex Mono.

### Spacing, radii, motion
- Spacing 4, 8, 12, 16, 20, 24, 32, 40, 56, 80 (`--s1`…`--s10`). Gap 16. Max width 1240. Measure 640. Section padding clamp(80px,10vh,130px).
- Radii: 11 buttons and fields; 14; **18 base (cards)**; 20; 24 (bands, large panels). Chips 6 (about 26px tall, lower than buttons); status pills and tags 5; count badges 4; formal register 2. **No pill shapes.**
- Motion: .15s fast, .25s base, cubic-bezier(.2,.7,.2,1). No bounce. Respect `prefers-reduced-motion`.

## Interaction rules (implement exactly)
- **Synapse** only for: field focus (Synapse border + 4% veil), the single solid CTA per screen, final actions (Aplicar, Enviar), the short active bar under a tab or child menu item, count badges for pending items. Selection fills are **never** Synapse.
- Focus ring: 2px Synapse outline, 2px offset, `:focus-visible` only.
- Hover: solid button lifts 1px + `--shadow-cta`; ghost fill .03 → .07. Disabled opacity .4.
- Fields: label always visible (Archivo 600 uppercase 10.5px); placeholder is an example. 16% border. ok = Nominal, error = Critical; the error message says how to fix it.
- Selects: custom listbox on Painel, 16% border, radius 11, options 34px, hover 6% white, selected option ink 600 with a check; arrows, Enter, Escape.
- Field actions (copy, paste, clear, reveal): icon-only inside the border, 5.5% white veil, Névoa icon; copy/paste confirm in Nominal for 1.6s. Single-field forms: one Synapse icon-only submit inside the field.
- Navigation: SectionNav first; Tabs inside a section; Segmented for one exclusive filter; FilterBar for several (OR within a group, AND across groups), active values as removable tags.
- Switch: 2–3 options (language or state). As a state switch the current option shows its functional icon and colour on a 14% tint.
- Data: numbers Plex Mono right-aligned; row lines 8%, header line 16%, no zebra; one family per chart; comparison bars as discrete square ticks (1.5px tick, 4.5px gap), equal length, close to label and value; metric widgets align number + info to the bottom and label to the top.
- Feedback: toast 4.2s (never a decision); dialog for decisions; empty state always with an action; skeleton when shape is known, spinner otherwise.
- Glass, blur, background grid and blobs only on primary-set surfaces.
- Widgets (kiosk): Sulco panels, rotation 10–15s, max 4 slides, segmented Synapse progress; clock, check-in and presence never rotate.

## UI copy rules
Brazilian Portuguese first. Sentence case headings; uppercase only for labels. Separators 1.284 and 0,94. **No middle dots or em dashes as separators.** No emoji; allowed glyphs → ↓ ✓ ! × i. Left-aligned, never justified. Codes never break across lines.

## Assets (`assets/`)
- Imagotipo: `logo-imagotipo-black.png`, `-white.png` (1253×214), plus tints `logo-imagotipo-<family>-dark|light.png`. Recolour only within one family; never Synapse; never stretched; never invert the black file.
- Square icon `icon-square-solid-black|white.png`: only where the imagotipo does not fit (collapsed SideMenu).
- Symbol `icon-colored-*.png`: original green, round frames only (avatars).
- White wave `icon-monochromatic.png`: internal systems only.
- Seals `seal-*.png`: certificates and official acts.
- Icons: none defined by the brand; use a thin-stroke set (Lucide 1.5px) and flag it as a substitution.

## Files
- `readme.md` (all rules), `SKILL.md`, `github.md` (source repo).
- `tokens/`, `styles.css`.
- `components/{core,interface,formal}/`.
- `guidelines/` (colour sets, contrast, type modes, radii, spacing, surfaces, logo, seal, band, icons).
- `templates/` (decks, certificates, letterhead, report, invitation, business card, badges, social, e-mail, wallpapers, posters).
