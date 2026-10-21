Filters that combine several selected options (AND across groups, OR within a group).
```jsx
<FilterBar count="24" filters={[{label:'Situação',options:['Publicado','Em revisão','Rascunho'],selected:['Publicado','Em revisão']},{label:'Formato',options:['Feed','Story','Banner']}]}/>
```
- Use Segmented for a single exclusive filter; FilterBar when more than one option can be active.
