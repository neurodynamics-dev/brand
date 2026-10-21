Widget: the building block of dashboards and the check-in kiosk.
```jsx
<Widget label="Check-in" meta="gira a cada 40 s">…</Widget>
<Widget interval={12} slides={[
  {label:'Hoje no LABBIO', meta:'03/10', content:<Agenda/>},
  {label:'Avisos', family:'retina', icon:'mail', content:<Notice/>},
]}/>
```
- Rotate only content that is glanceable; 10–15 s per slide, max 4 slides. Fixed information (clock, check-in QR, presence list) never rotates.
- Family tint is for highlight slides (avisos, boas-vindas). One family per slide; neutral slides stay Sulco.
- Big numbers in Archivo Light; times and codes in Plex Mono; text in Instrument Sans.
- Kiosk layout: fixed check-in column on the right (420px), everything else fills the rest. No empty widgets: if a widget has nothing to show, its slide is skipped.
