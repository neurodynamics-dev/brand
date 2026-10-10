Text, select or textarea field for interfaces (dark, primary set).
```jsx
<Field id="mail" label="E-mail" placeholder="ana@neurodynamics.dev"/>
<Field id="m2" label="E-mail" defaultValue="ana@gmail.com" state="error" hint="Use o e-mail institucional (@neurodynamics.dev)."/>
<Field id="fmt" label="Formato" type="select" options={['Feed','Story']}/>
<Field id="key" label="Chave da API" defaultValue="nd_live_8f2c…" actions={['copy']}/>
<Field id="pw" label="Senha" type="password" actions={['reveal']}/>
<Field id="news" label="Receber novidades" type="email" placeholder="ana@neurodynamics.dev" submit={{label:'Inscrever',onSubmit:v=>{}}}/>
```
- Label always visible (Archivo 600 uppercase); placeholder is an example, never the label.
- Error hint says how to fix it. Border is mandatory, never a borderless field.
- Inline actions sit inside the border, ghost, Névoa; never a filled or Synapse button. Max two actions, separated by a 4px gap. Icon-only by default (icons first); the action name goes to aria-label and tooltip.
- submit: single-field forms only (newsletter, invite code, search-and-go). The button is Synapse because sending is the final action; icon-only, label goes to aria-label. Don't combine with actions.
