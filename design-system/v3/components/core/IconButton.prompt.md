Quiet icon-only utility button for use outside forms.
```jsx
<span>ana@neurodynamics.dev <IconButton icon="copy" value="ana@neurodynamics.dev" size="sm"/></span>
<IconButton icon="download" label="Baixar PDF" onClick={dl}/>
```
- size="sm" (26px) beside running text; "md" (32px) beside data and headers.
- Always pass label when the icon is not copy/paste/clear; it becomes aria-label and tooltip.
- Never Synapse; final actions use Button solid.
