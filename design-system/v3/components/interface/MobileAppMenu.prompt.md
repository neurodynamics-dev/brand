Navigation drawer for complex interfaces on phones (sites use MobileSiteMenu).
```jsx
<MobileAppMenu app="Portal do membro" active="Studio" activeChild="Quadro" user={{name:'Ana Ribeiro',role:'Administração'}} notifications={3}
  sections={[{label:'Agenda',icon:'cal'},{label:'Studio',icon:'image',children:[{label:'Quadro'},{label:'Ideias'},{divider:true},{label:'Configurações'}]}]}>{/* page */}</MobileAppMenu>
```
- Closed: the bare symbol (no frame) is the home button, menu button on the right. Open: the full imagotipo takes the symbol place (same spot, one mark, never both), system tag below it, no home icon.
- Rows 44px or more; sub-items under a 1px rule, active one marked with a Synapse tick. Tag in Synapse outline, never filled.
- Icons: cal, board, target, box, folder, image, palette, users, cap, grid, file, chart, settings.
