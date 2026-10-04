# Templates

Peças prontas da NeuroDynamics em HTML estático. Abra no navegador para ver;
para gerar PDF, use **Imprimir → Salvar como PDF** sem margens. Os nomes e
dados que aparecem nas peças são de exemplo.

Todas carregam `../../design-system/tokens.css` e as fontes do Google Fonts,
e apontam para os arquivos de marca em `../../assets/`. As regras de cada
peça estão em [`design-system/DIRETRIZES.md`](../design-system/DIRETRIZES.md).

## Registro formal (modo executivo)

Instrument Serif nos títulos e nomes, Archivo Light no texto, nunca Plex
Mono. Só cores do conjunto primário e do neutro, salvo onde indicado.

| Peça | Arquivo | Formato |
| --- | --- | --- |
| Relatório formal | [`formal-report/FormalReport.html`](formal-report/FormalReport.html) | A4, capa e página de texto, cabeçalho de documento controlado |
| Certificado | [`certificate/Certificate.html`](certificate/Certificate.html) | A4 paisagem, layout clássico centrado, selo Axon |
| Convite | [`invitation/Invitation.html`](invitation/Invitation.html) | Quatro faces (Cortex, Neuron, Retina, Dendrito) e verso |
| Cartão de visita | [`business-card/BusinessCard.html`](business-card/BusinessCard.html) | 85×55 mm, frente Cortex dark e verso branco |
| Apresentação formal | [`formal-deck/FormalDeck.html`](formal-deck/FormalDeck.html) | 16:9, 24 slides |

## Os dois modos

| Peça | Arquivo | Formato |
| --- | --- | --- |
| Papel timbrado | [`letterhead/Letterhead.html`](letterhead/Letterhead.html) | A4, carta e memorando, versões executiva e operacional |

## Conjunto primário (modo operacional)

| Peça | Arquivo | Formato |
| --- | --- | --- |
| Apresentação de marca | [`brand-deck/BrandDeck.html`](brand-deck/BrandDeck.html) | 16:9, 24 slides com a paleta expandida |
| Certificado de marca | [`certificate-brand/CertificateBrand.html`](certificate-brand/CertificateBrand.html) | A4 paisagem, faixa da família à esquerda (Cortex, Ion, Retina, Lúmen, Dendrito) |
| Redes sociais | [`social/Social.html`](social/Social.html) | Feed 1080×1350, story 1080×1920, banner LinkedIn 1584×396 |
| Crachás | [`badges/Badges.html`](badges/Badges.html) | CR80, três propostas (Sinal, Retrato, Ficha), frente, verso e visitante |
| Wallpapers | [`wallpapers/Wallpapers.html`](wallpapers/Wallpapers.html) | Quatro estilos em desktop, celular, tablet e videochamada |
| Pôsteres | [`posters/Posters.html`](posters/Posters.html) | Quatro frases e quatro pranchas técnicas do NeuroAmp-32 |
| E-mails | [`email/`](email/) | 600px, tabelas e estilos inline, prontos para envio |

### E-mails

- `email/Cabecalhos.html`: os sete blocos de cabeçalho.
- `email/Boletim.html` e `email/Comunicado.html`: boletim e comunicado interno em Cortex.
- `email/variantes/`: boletim e comunicado em cada família secundária, com o imagotipo recolorido.

As células de imagem trazem comentários `SWAP` indicando onde entra a URL
hospedada da foto. Antes de enviar, troque os caminhos `../../assets/` (ou
`../../../assets/` nas variantes) pelas URLs públicas dos arquivos.

## Fotos

Nas peças com foto (crachás, redes sociais, certificado de marca), a área da
foto é um `<div class="foto-slot">`. Coloque um `<img>` dentro dele; o CSS já
aplica `object-fit:cover`. Fotos só quando fornecidas, retangulares e sem
filtros.

## Como foram gerados

Os arquivos vieram do projeto do Claude Design: cada template foi renderizado
uma vez e salvo como HTML estático, sem o runtime da ferramenta. Para mudar
uma peça, edite o HTML aqui ou altere o template no Claude Design e exporte de
novo.
