#!/usr/bin/env node
/* ============================================================
   gerar-artes.mjs · NeuroDynamics Design System

   Deriva as artes de preview (.webp) a partir dos PNGs oficiais
   em ../../assets/. Roda só quando a marca muda — o `build.mjs`
   do dia a dia não depende deste script nem de nada instalado.

   Por que existe:
     · os PNGs oficiais têm 1500px e muita margem transparente;
     · cada preview embute a arte como data URI, então peso importa;
     · as artes têm gradiente, que o PNG comprime mal — o ícone
       escuro sai de 363KB em PNG para 4KB em WebP.

   O que faz, por arquivo: recorta na caixa do conteúdo (alpha > 8),
   reduz em etapas de metade para não serrilhar e grava em WebP.

   Uso:
     npm i playwright-core          # única dependência, não versionada
     node gerar-artes.mjs

   Se preferir outra ferramenta (ImageMagick, sharp, Squoosh), o
   resultado só precisa bater com a tabela ARTES abaixo.
   ============================================================ */
import { readFileSync, writeFileSync } from 'node:fs';
import { dirname, join } from 'node:path';
import { fileURLToPath } from 'node:url';

const aqui = dirname(fileURLToPath(import.meta.url));
const ASSETS = join(aqui, '..', '..', 'assets');

const ARTES = [
  { origem: 'imagotipo preto.png',                              destino: 'imagotipo.webp',        largura: 600, recortar: true  },
  { origem: 'imagotipo branco.png',                             destino: 'imagotipo-branco.webp', largura: 600, recortar: true  },
  { origem: 'NRO ICON (COLORED TRANSPARENT BACKGOUND).png',     destino: 'simbolo.webp',          largura: 288, recortar: true  },
  { origem: 'NRO ICON MONOCHROMATIC.png',                       destino: 'icone-escuro.webp',     largura: 288, recortar: false },
  { origem: 'NRO SQUARE ICON (COLORED TRANSPARENT BACKGOUND).png', destino: 'icone-verde.webp',   largura: 288, recortar: true  },
];

const QUALIDADE = 0.92;

let chromium;
try {
  ({ chromium } = await import('playwright-core'));
} catch {
  console.error('✗ playwright-core não encontrado. Rode: npm i playwright-core');
  process.exit(1);
}

const executablePath = process.env.CHROMIUM_PATH
  || '/opt/pw-browsers/chromium-1194/chrome-linux/chrome';
const browser = await chromium.launch({ executablePath }).catch(() => chromium.launch());
const page = await browser.newPage();
await page.goto('about:blank');

for (const arte of ARTES) {
  const b64 = readFileSync(join(ASSETS, arte.origem)).toString('base64');

  const r = await page.evaluate(async ({ b64, largura, recortar, qualidade }) => {
    const img = new Image();
    img.src = 'data:image/png;base64,' + b64;
    await img.decode();
    const W = img.naturalWidth, H = img.naturalHeight;

    const base = new OffscreenCanvas(W, H);
    const bx = base.getContext('2d');
    bx.drawImage(img, 0, 0);

    /* caixa do conteúdo */
    let x0 = 0, y0 = 0, x1 = W, y1 = H;
    if (recortar) {
      const d = bx.getImageData(0, 0, W, H).data;
      x0 = W; y0 = H; x1 = 0; y1 = 0;
      for (let py = 0; py < H; py++) for (let px = 0; px < W; px++) {
        if (d[(py * W + px) * 4 + 3] > 8) {
          if (px < x0) x0 = px; if (px > x1) x1 = px;
          if (py < y0) y0 = py; if (py > y1) y1 = py;
        }
      }
      x1++; y1++;
      if (x1 <= x0 || y1 <= y0) { x0 = 0; y0 = 0; x1 = W; y1 = H; }
    }
    const cw = x1 - x0, ch = y1 - y0;
    const alvoW = Math.min(largura, cw);
    const alvoH = Math.round(ch * (alvoW / cw));

    /* redução em etapas de metade */
    let cur = new OffscreenCanvas(cw, ch);
    cur.getContext('2d').drawImage(base, x0, y0, cw, ch, 0, 0, cw, ch);
    let curW = cw, curH = ch;
    while (curW / 2 > alvoW) {
      const nw = Math.round(curW / 2), nh = Math.round(curH / 2);
      const n = new OffscreenCanvas(nw, nh);
      const nx = n.getContext('2d');
      nx.imageSmoothingEnabled = true; nx.imageSmoothingQuality = 'high';
      nx.drawImage(cur, 0, 0, nw, nh);
      cur = n; curW = nw; curH = nh;
    }
    const fim = new OffscreenCanvas(alvoW, alvoH);
    const fx = fim.getContext('2d');
    fx.imageSmoothingEnabled = true; fx.imageSmoothingQuality = 'high';
    fx.drawImage(cur, 0, 0, alvoW, alvoH);

    const blob = await fim.convertToBlob({ type: 'image/webp', quality: qualidade });
    const buf = new Uint8Array(await blob.arrayBuffer());
    let s = ''; for (const v of buf) s += String.fromCharCode(v);
    return { b64: btoa(s), origem: `${W}×${H}`, final: `${alvoW}×${alvoH}` };
  }, { b64, largura: arte.largura, recortar: arte.recortar, qualidade: QUALIDADE });

  const bytes = Buffer.from(r.b64, 'base64');
  writeFileSync(join(aqui, arte.destino), bytes);
  const antes = readFileSync(join(ASSETS, arte.origem)).length;
  console.log(
    `${arte.destino.padEnd(21)} ${r.origem.padStart(9)} → ${r.final.padStart(9)}  ` +
    `${(antes / 1024).toFixed(0)}KB → ${(bytes.length / 1024).toFixed(0)}KB`
  );
}

await browser.close();
console.log('\n✓ artes geradas. Agora rode: node ../build.mjs');
