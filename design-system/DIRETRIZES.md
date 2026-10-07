# NeuroDynamics Design System

> Cópia do guia do projeto "NeuroDynamics Design System" no Claude Design,
> a fonte de verdade das regras. Os caminhos citados abaixo são os daquele
> projeto. Neste repositório: os tokens de `tokens/*.css` estão todos em
> `design-system/tokens.css`; os componentes de `components/` viram classes
> em `design-system/neuro.css` (interface) e `design-system/formal.css`
> (documentos); `templates/` e `assets/` ficam na raiz.

NeuroDynamics builds technology tools for health (neurotechnology, clinical signal analysis, internal research platforms). It operates like a startup out of **LABBIO, Escola de Engenharia, UFMG** (Belo Horizonte).

The manual has two domains, each with its own rules:
- **Documents**: pieces that are read, printed or presented (reports, certificates, invitations, presentations, social posts). Built in the **primary set** by default, or in the **formal set** for specific solemn applications.
- **Interface**: product screens (site, Portal do Membro, ERP and internal tools). Always the **primary set**, dark Void surfaces, with the **functional set** for states.

## Sources
- GitHub: https://github.com/neurodynamics-dev/brand (`design-system/tokens.css`, `neuro.css`, `previews/*.html`, `marca/LEIAME.md`). Interface components ported from previews 08, 10, 11, 12 and 17; calendar (18) pending.
- Public brand page: https://brand.neurodynamics.dev
- Logo PNGs in `assets/`. Brandfetch: https://brandfetch.com/neurodynamics.dev

## Type sets
Two modes, one card each (`guidelines/type-operational.html`, `guidelines/type-executive.html`).
- **Operational** (default; primary set; all palettes): **Archivo** 500–700 for titles (−.015em headings, −.025em display) and uppercase labels (600, tracking .12–.18em); **Instrument Sans** 400/500 for running text (15/1.65); **IBM Plex Mono** for status, codes and data. Secondary text and subtitles: same weight, Névoa (one tone lighter), never bold.
- **Executive** (formal set; specific applications only: certificates, formal reports, invitations, formal presentations): **Instrument Serif** regular and italic, never bold, for headlines, names, numerals and quotes; **Archivo Light 300** for running text, 10.5pt in print; Archivo 400/500 for small labels and codes. Secondary text and subtitles as in operational: same weight, one tone lighter in the same family (Cortex → Axon, ink → Sulco grey). Palette: the primary set with the neutral set is the main composition (white and Medula grounds, Cortex tones), Synapse only as a tiny accent; never mix families; secondary families only as auxiliaries; never the functional set. Never Plex Mono. Never for brand guidelines, product UI or digital channels.

## Colour
Four sets, families only, four tones each (light, medium, primary, dark). Brand and neutral families in `tokens/palette.css` as `--<family>-<tone>`; functional in `tokens/functional.css` as `--fn-<family>-<tone>`; `tokens/colors.css` holds role aliases only.
- **Primary set**: one family, **Cortex**, in five tones: light #E3EFEC, medium #A9CCC4, primary #00594F (**Axon**), dark #00352F (**Cortex**), accent #CEDC00 (**Synapse**, the spark for Axon, for highlights only). The only colours allowed in glows, blurs, gradients, glass or transparency.
- **Neutral set**: **Sulco** (#616C68, #1D1D1F, #0B1210, #050807: captions, ink, panels, void), **Pia** (cool greys), **Medula** (warm paper). Old names (`--void`, `--painel`, `--ink`, `--paper-warm`, `--formal-rule`...) are aliases into these families.
- **Secondary set**, named from the nervous system. Green and cool: Ion, Neuron, Glia lead; Retina, Nexo, Dendrito are the blue-violet counterpoint. Warm palette, spring register: Lúmen, Ritmo, Impulso, Plexo, Íris. Clear and luminous, never earthy. In interfaces the Secondary set is complementary: a family may tint a highlight surface (family Band: Sulco ground, family glow, medium-tone label and icon, family button) only where the primary set is not in use on that surface; never beside Synapse or a Cortex CTA.
- **Functional set** (interface design only; never in documents or brand pieces): interface states, named outside the brand vocabulary: **Nominal** (success), **Caution** (warning), **Critical** (error, destructive), **Signal** (info, live data), **Idle** (offline, disabled). Electric tones that never read as brand. Never identity, never a cover.
- **One family per surface.** A piece uses one family plus white or a neutral; never two hue families together. Purple families (Nexo, Dendrito) always appear in more than one tone.
- **Plain use.** Brand, neutral and functional families are flat only: fills, text, rules.
- Pairing: light ground with the dark of the family; dark ground with white; primary ground with the dark of the family, except Cortex, Retina and Nexo primaries, which take white.
- Approach studied from Abbott's corporate system (reference only): many flat colours in tonal sets, one signature colour. No Abbott asset or colour is reused.

## Marks
- **Imagotipo** (`logo-imagotipo-black.png`, `logo-imagotipo-white.png`): solid black or white, or recoloured in tones of one family. Never Synapse, never stretched. The white file is its own drawing (hollow stroke); never invert the black one.
- **Square icon** (`icon-square-solid-black.png`, `icon-square-solid-white.png`): solid, recolourable like the imagotipo. Used only when the imagotipo does not fit or the layout is too busy for it, in the same colour as the title, at a modest size. Never large, centred or in a contrasting colour, and never repeated when the imagotipo is on the page.
- **Symbol** (`icon-colored-*.png`): keeps its original green, never recoloured or reframed. Only for round frames such as profile pictures. Not used in presentations.
- **White wave** (`icon-monochromatic.png`): internal systems only (ERP icon and internal tools). Never public.
- **Solemn seal**: the wave inside a laurel crown, for certificates, diplomas and official acts. Axon on light paper (`seal-axon.png`) or white on Cortex (`seal-white.png`).
- The logo does not go on every page. In presentations it appears on covers and back cover only.

## Content fundamentals (both domains)
- Tone: calm, professional, caring. Direct, no ornament.
- Brazilian Portuguese first. Sentence case for headings. Uppercase only for labels, in Archivo 600 with open tracking.
- **IBM Plex Mono only for codes and data** (codes, readouts, numbers in tables and dashboards, hex values). Never for labels, titles or dates. Codes never break across lines.
- Text is left-aligned and never justified. Centred text only in specific pieces, such as the classic certificate.
- Brazilian separators: 1.284 and 0,94. Document codes: `NRO-PUB-002`, `NRO-REL-2026-014`.
- No middle dots or em dashes as separators; use commas, line breaks or layout. Em dashes only to attribute a quote.
- No emoji. Arrows (→ ↓) and ✓ ! × i are the only unicode glyphs.

## Documents
- **Controlled documents** (anything with a document code): at the top right, right-aligned, the document type in sentence case and the code below it, in the same font and size as the type (Archivo in the formal set, Instrument Sans in the primary set), even though it is a code. Example: "Relatório técnico" / "NRO-PRO-010-5".
- **Certificates**: the city and date follow the participation paragraph, in the same font and size. In primary-set certificates the document type in the header replaces any label in the body.
- **Formal grounds**: white, Medula light, Cortex light, or Cortex dark as a full flat field. Rules Pia medium or the family dark. Synapse never as a field.
- **Formal labels**: kickers (rule, folio, tint) or an Instrument Serif italic label; never mono uppercase.
- **Presentations**: full colour pages only in the primary and neutral sets; other families appear as panels on white, in several tones. Content slides carry the footer (presentation name, page number, "Proprietário e confidencial"), without the logo. The formal deck uses only primary and neutral colours.
- Formal print: A4, 22mm margins. Formal documents: photos only if supplied, rectangular, no filters.

## Interface
- Surfaces: Void page, Painel raised panels, cards with 1px `--line` border, 18px radius, rgba(255,255,255,.03) fill. No drop shadows for elevation.
- **Synapse is the focus colour**: field focus (Synapse border plus a 4% veil),  the single solid CTA per screen, and actions such as Aplicar. Selection fills (chips, Segmented, FilterBar values, SectionNav) are never Synapse. Small marks may be: the short active bar under a tab or a child menu item, and count badges that signal something pending for the user (new items, notifications to read). Counts that only describe a state the user already set, such as the number of applied filters, stay neutral in ink. Plain selection (choice chips) is quiet: 9% white fill and ink, like SectionNav. Focus ring: 2px Synapse outline, offset 2px.
- **States use the functional set**: field ok = Nominal, field error = Critical, destructive button = Critical, toast and pill indicators by state. Error messages always say how to fix it.
- Labels always visible (Archivo 600 uppercase, 10.5px); placeholder is an example, never the label. Fields always have a 16% border. Selects never use the native browser list: the custom listbox opens on a Painel surface with a 16% border, 11px radius and soft shadow; options are 34px, hover 6% white, the selected one in ink 600 with a check.
- **Navigation hierarchy**: SectionNav is always the first selector of a screen; Tabs inside a section; Segmented for a single exclusive filter; FilterBar when several options can be active (OR within a group, AND across groups), with active values shown as removable tags. Never the reverse. Sites use the floating glass SiteHeader; apps use SideMenu (252px open, 68px collapsed rail with fly-out; imagotipo when open, solid square icon in white when collapsed, since the logo does not fit).
- **Data**: numbers in Plex Mono, right-aligned; text left. Row lines 8%, header line 16%, no zebra. Charts use one family; proportion bars use its four tones. Small comparison bars are discrete ticks, a tick of width x then a 3x gap (1,5px and 4,5px by default), square ends, never rounded fills that collapse into ellipses.
- **Feedback**: toast for passing confirmation (4,2s, never a decision); dialog for decisions; empty state always with an action; skeleton when the shape is known, spinner when it is not; all motion respects prefers-reduced-motion.
- Radii 11 (buttons, fields), 14, 18 (base), 20, 24. **No pill shapes**: chips 6px (and visibly lower than buttons, about 26px tall, so a choice never reads as a confirm button), status pills and tags 5px, count badges 4px. `--r-pill` is retired and resolves to 7px. Motion .15s/.25s, no bounces. Hover: solid lifts 1px with the Synapse glow; ghost fill .03→.07. Disabled opacity .4.
- Glass and blur (header, dialog backdrop) and the background grid and blobs only on primary-set surfaces.
- **Widgets**: Sulco panels that may rotate glanceable content (10–15 s, max 4 slides) with a segmented Synapse progress; clock, check-in and presence never rotate. Kiosk screens sit on the expressive background (Cortex grid and Axon blob); a second blob and the sun arc shift very discreetly with the time of day (dawn Lúmen, day Synapse 5%, dusk Ritmo, night Retina). Notices and welcomes use the family band treatment. Presence gamification (Placar: days present as comparison ticks, streaks as chains of squares) use Lúmen, while the personal check-in moment glows in the primary set (Axon, Cortex); it is celebratory, never Synapse. Highlight slides may take one family.
- **Family bands**: one family per band, button in the same family (`Button family`), icon large and faint at the right edge behind the text.
- **Switch**: 2–3 exclusive options, for language (EN / PT) or state. As a state switch the current option shows its functional icon and colour on a 14% tint; the rest stay Névoa. Filters use Segmented.
- **Utility actions** (copy, paste, clear, reveal, link, download): quiet icon buttons on a 5.5% white veil, Névoa icon, never Synapse; inside fields via Field `actions`, beside running text via IconButton. Single-field forms may use Field `submit`: one Synapse icon-only send button inside the border, because sending is the final action.
- Icons: none defined by the brand. If needed, a thin-stroke set (e.g. Lucide 1.5px), flagged as a substitution.

## Components
Core (`components/core/`): Button, IconButton, Switch, Pill, Tag, Chip, Eyebrow, Card, Alert.
Interface (`components/interface/`): Widget, Band, SideMenu, Field, SectionNav, Tabs, Segmented, FilterBar, Breadcrumb, SiteHeader, Metric, DataGrid, BarList, ProportionBar, SpecList, Toast, Skeleton, Progress, EmptyState, Dialog.
Formal (`components/formal/`): Letterhead, SignatureBlock, DataTable, Kicker.

Intentional additions beyond the brand source: the formal components, the `formal`, `formal-outline` and `danger` Button variants.

## Templates
Formal set (specific applications only):
- `templates/business-card/`, 85×55 mm, Cortex dark flat front, white back with serif name. Business cards are executive mode only.
- `templates/formal-report/`, A4 cover and body page on white, controlled-document header.
- `templates/certificate/`, A4 landscape, classic centred layout with the Axon seal. The header carries the document type "Certificado de participação"; no title in the body.
- `templates/invitation/`, four colour faces (Cortex, Neuron, Retina, Dendrito) plus details back.
- `templates/formal-deck/`, 16:9, 7 covers and 17 layouts after the Abbott structure, primary and neutral colours only.

Both modes:
- `templates/letterhead/`, A4 letter and memo, executive and operational versions.

Primary set:
- `templates/social/`, feed 1080×1350 (Cortex expressive and family with photo), story 1080×1920, LinkedIn banner 1584×396.
- `templates/badges/`, CR80 badges in three proposals (A Sinal: wave field and Synapse role band; B Retrato: full-bleed photo with stepped panel; C Ficha: technical datasheet with registration marks), front, back and visitor.
- `templates/email/`, send-ready HTML e-mails (operational mode, 600px, tables and inline styles): seven header blocks, newsletter (Boletim) and internal notice (Comunicado) in Cortex, plus Boletim and Comunicado in each secondary family under `variantes/` (logo recoloured per family). Image cells carry SWAP comments for hosted URLs.
- `templates/wallpapers/`, four full-field styles (mesh, waves, circuit, pulse) at desktop 2560×1440, phone 1179×2556, tablet 2048×2732 and video call 1920×1080; `Wall.dc.html` renders one at full size.
- `templates/posters/`, four quote posters (signal, verify, simplicity, log) and four blueprint drawings of the NeuroAmp-32 system (PCB, block diagram, enclosure, SPI timing and firmware states), portrait and landscape, with real-style title and revision blocks.
- `templates/brand-deck/`, 16:9, 7 covers and 17 layouts with the expanded palette.
- `templates/certificate-brand/`, A4 landscape for simpler applications: family light ground, plain family dark band at the left (one fifth of the width, Cortex with glow). Cortex, Ion, Retina, Lúmen, Dendrito. `partner` prop adds the partner logo slot and a second signature.

## Index
- `styles.css` imports `tokens/` (fonts, colors, palette, functional, formal, typography, spacing, base)
- `guidelines/`, foundation cards; `components/*/*.card.html`, component cards
- `assets/`, imagotipo, square icons (solid), symbol, white wave, solemn seals (`seal-*.png`, laurel source `seal-laurel.svg`)
- `templates/`, `SKILL.md`, `github.md`

## SOMA: tema claro e navegação

O portal admite tema claro e escuro. `portal.css` documenta os aliases utilizados pela casca; carregar depois dos tokens e componentes. Claro: superfície Pia light, tinta Sulco, linhas Pia medium. Escuro: Void e Sulco. Estados funcionais usam marca ou ícone; o texto continua na cor de leitura. A área de destaque (`.sl-destaque`) preserva os aliases escuros nos dois temas.

O menu usa imagotipo branco no escuro e preto no claro, sem filtros. Recolhido, usa o ícone quadrado correspondente. Seleção permanece discreta (fundo neutro e peso 600); Synapse identifica a ação principal, não a opção selecionada. Marca fica entre Studio e Equipe. Selects usam realce progressivo: o elemento nativo permanece sincronizado com o controle acessível e continua disponível para automação.
