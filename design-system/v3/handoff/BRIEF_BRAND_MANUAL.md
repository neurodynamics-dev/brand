# Brief: NeuroDynamics brand manual

## Goal
Produce the official brand manual: a document a designer, supplier or new team member can follow without having been in the design conversations. Source of truth: `readme.md`. Visual references: `guidelines/*.html`, `templates/`, `components/*/*.card.html` (paths from the project root).

## Format
- Digital PDF, 16:9 pages (1920×1080), on the **brand deck** layouts (`templates/brand-deck/`). The manual is a brand piece: **operational mode** (Archivo + Instrument Sans). The executive mode is excluded from brand guidelines by rule.
- Optional web version on brand.neurodynamics.dev with the same chapters.
- Brazilian Portuguese, sentence case. Every copy rule applies: no middle dots, no em dashes as separators, no emoji, never justified.
- Every rule is shown as a **do / don't pair** with a real example, not only described.

## Chapters

### 1. A marca
- Who NeuroDynamics is: technology tools for health; LABBIO, Escola de Engenharia, UFMG.
- Tone: calm, professional, caring; direct, no ornament.
- The neural naming idea: colours named after the nervous system (Cortex, Axon, Synapse, Sulco, Pia, Medula, Ion, Neuron, Glia, Retina, Nexo, Dendrito, Lúmen, Ritmo, Impulso, Plexo, Íris). Synapse is the spark, used sparingly.

### 2. Marcas
Sources: `guidelines/brand-logo.html`, `brand-seal.html`, `brand-icons.html`.
- Imagotipo: versions, clear space, minimum size, recolouring (black, white, or tones of one family; never Synapse; never stretched; the white file is its own drawing, never invert the black).
- Square icon: when it replaces the imagotipo; never large, centred, contrasting or repeated.
- Symbol: original green, round frames only, never in presentations.
- White wave: internal systems only.
- Solemn seal: certificates and official acts; Axon on paper or white on Cortex.
- Placement: not on every page; in presentations covers and back cover only.
- Don'ts page: stretched, Synapse-coloured, two families, inverted, on a busy photo, symbol in a square frame.

### 3. Cor
Sources: `guidelines/colors-1-primary.html` … `colors-6-contrast.html`.
- The four sets in order: primary (Cortex, five tones, Synapse as accent), neutral (Sulco, Pia, Medula), secondary (cool then warm, merged in harmony), functional (interfaces only).
- Composition bar: primary + neutral is the main composition; Synapse a tiny share.
- Rules: one family per surface; plain use for non-Cortex families; only Cortex in glows, gradients, glass; pairing rule; purple families always in more than one tone.
- Contrast table (`colors-6-contrast.html`).
- Hex, RGB, CMYK per tone. **CMYK and Pantone are still to be defined with a print supplier**: flag as pending.

### 4. Tipografia
Sources: `guidelines/type-operational.html`, `type-executive.html`, `type-kickers.html`.
- Operational: Archivo titles and labels, Instrument Sans text, IBM Plex Mono for status, codes and data; scale and tracking.
- Executive: Instrument Serif headlines, names, quotes (never bold), Archivo Light text 10.5pt. Allowed (certificates, formal reports, invitations, formal decks, business cards) and forbidden (brand guidelines, product UI, digital channels).
- Hierarchy without bold: secondary text one tone lighter in the same family.
- Plex Mono only for codes and data, never labels, titles or dates; codes never break.
- Licences: Google Fonts, SIL Open Font License.

### 5. Elementos gráficos
Sources: `guidelines/brand-expressive.html`, `brand-band.html`, `surfaces.html`, `radii.html`, `spacing-scale.html`.
- Expressive background (grid + Cortex/Axon blob), primary-set surfaces only.
- Family band treatment.
- Wave field (badges, wallpapers), blueprint register (posters).
- Radii scale; no pill shapes.
- Imagery: photos only if supplied, rectangular, no filters in formal pieces.

### 6. Aplicações: documentos
One spread per template (template, when to use, specific rules): letterhead and memo (both modes, controlled-document header with type + code top right); formal report; certificate (classic, Axon seal) and primary-set certificate; invitation; business card; formal deck; brand deck.

### 7. Aplicações: digital e ambientes
Social (feed 1080×1350, story 1080×1920, LinkedIn 1584×396); e-mail (header blocks, Boletim, Comunicado, family variants, logo recoloured per family, date in the header, titles never bold); badges (CR80, three proposals, visitor); wallpapers (mesh, waves, circuit, pulse in four formats); posters (four quotes, four blueprint drawings).

### 8. Interface (summary)
Short chapter pointing to the front-end system: Synapse as focus colour, functional set for states, navigation hierarchy, data rules, widgets. Use the `components/interface/*.card.html` captures.

### 9. Redação
Brazilian Portuguese first; sentence case; uppercase only for labels; 1.284 and 0,94; document code format `NRO-REL-2026-014`; no middle dots; em dash only to attribute a quote; allowed glyphs.

### 10. Arquivos e contato
Where to download assets, who approves new pieces, manual version and date.

## Pending decisions for the brand owner
- CMYK and Pantone conversions.
- Minimum logo sizes (mm and px).
- Clear-space unit for the imagotipo (suggestion: the square icon's height).
- Approval workflow and contact.
- Icon set (brand defines none; Lucide 1.5px is the interim substitution).
