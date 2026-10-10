Primary action control; use `solid` (Synapse) for the single main action per screen, `ghost` for secondary.
```jsx
<Button variant="solid">Gerar asset →</Button>
<Button variant="ghost" size="mini">Cancelar</Button>
```
- Variants: solid, claro (ink), ghost, formal (Cortex, 2px radius), formal-outline.
- Sizes: md 44px, mini 34px (inside cards/tables/toolbars).
- Label with a verb ("Baixar PNG"), never bare "OK".