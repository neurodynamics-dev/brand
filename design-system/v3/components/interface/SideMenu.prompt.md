App side menu for the Portal do Membro, ERP and internal tools (sites use SiteHeader).
```jsx
<SideMenu app="ERP" active="Projetos" activeChild="Fase III" user={{name:'Ana Ribeiro',role:'Diretora científica'}} notifications={3}
  sections={[{label:'Início',icon:'home'},{label:'Projetos',icon:'grid',children:[{label:'Fase II',code:'NRO-PRO-010'},{label:'Fase III',code:'NRO-PRO-011'}]},{divider:'Gestão'},{label:'Pessoas',icon:'users'}]}/>
```
- Bottom, top to bottom: Avisos, a row of tiny icon buttons (collapse, light/dark, report bug on this page; collapsed shows only expand, between Avisos and the avatar), then the user profile always last. Collapsed search is a plain icon item like the rest.
- Collapsing narrows the menu, nothing jumps. Below 1280px it starts collapsed unless the person chose otherwise.
- Divider labels in Archivo uppercase; codes in Plex Mono.
