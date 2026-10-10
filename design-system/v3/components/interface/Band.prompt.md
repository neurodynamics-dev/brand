Highlight band for the page's main call to action. Never in formal documents.
```jsx
<Band eyebrow="Chamada" title="A banda verde é para o que importa." action={<Button>Ação principal</Button>}>Reserve este bloco.</Band>
```
```jsx
<Band family="retina" icon="calendar" eyebrow="Agenda" title="Simpósio de neuroengenharia" action={<Button family="retina">Inscrever-se</Button>}>Vagas até 12 de novembro.</Band>
```
- Family bands are complementary: only on surfaces where the primary set (Cortex, Synapse) is not in use.
- One family per band, and the button takes the same family. Never Synapse on a family band.
- Icon is decoration (aria-hidden): large, faint, at the right edge, always behind the text. One per band.
