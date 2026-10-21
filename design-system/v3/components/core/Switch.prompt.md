Switch for language, mode or state (max 3 options).
```jsx
<Switch label="Idioma" items={['EN','PT']} active={1}/>
<Switch label="Situação do equipamento" items={[{label:'Ativo',status:'nominal'},{label:'Pausa',status:'idle'},{label:'Falha',status:'critical'}]}/>
```
- Language: short codes (EN, PT, ES), header or footer only.
- State: the current option shows its functional icon and colour; the others stay Névoa. Icon-only items need a label (aria-label and tooltip).
- Filters use Segmented; final actions use Button.
