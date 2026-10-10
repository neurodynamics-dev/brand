/* Carimba o cabeçalho e o rodapé da casca (design-system/casca.js) em
   cada página da raiz, entre <!-- cabecalho --> e <!-- rodape -->, com o
   capítulo atual marcado. Rode depois de mudar a casca ou os capítulos. */
import {readFile,writeFile,readdir} from 'node:fs/promises';import {fileURLToPath} from 'node:url';import {createRequire} from 'node:module';import path from 'node:path';
const root=fileURLToPath(new URL('..',import.meta.url));
const NDCasca=createRequire(import.meta.url)(path.join(root,'design-system/casca.js'));
const CAPITULOS=[['/marca','Marca'],['/cores','Cores'],['/tipografia','Tipografia'],['/escrita','Escrita'],['/elementos','Elementos'],['/aplicacoes','Aplicações'],['/galeria','Galeria']];
const base={site:'brand',lang:'pt',tag:'Brand',inicio:'/',logo:'/design-system/marca/imagotipo-branco.webp',ano:new Date().getFullYear()};
for(const name of await readdir(root)){if(!name.endsWith('.html'))continue;const file=path.join(root,name);let html=await readFile(file,'utf8');
 const rota=name==='index.html'?'/':'/'+name.slice(0,-5);
 const links=CAPITULOS.map(([href,rotulo])=>({href,rotulo,atual:href===rota}));
 const partes={cabecalho:NDCasca.cabecalho({...base,links}),rodape:NDCasca.rodape({...base,links})};
 for(const [k,parte] of Object.entries(partes))html=html.replace(new RegExp(`<!-- ${k} -->[\\s\\S]*?<!-- /${k} -->`),`<!-- ${k} -->\n${parte}\n<!-- /${k} -->`);
 html=html.replace('<link rel="stylesheet" href="/design-system/neuro.css">','<link rel="stylesheet" href="/design-system/neuro.css"><link rel="stylesheet" href="/design-system/casca.css">');
 html=html.replace('<script defer src="/site/site.js"></script>','<script defer src="/design-system/casca.js"></script><script defer src="/site/site.js"></script>');
 html=html.replaceAll('<link rel="stylesheet" href="/design-system/casca.css"><link rel="stylesheet" href="/design-system/casca.css">','<link rel="stylesheet" href="/design-system/casca.css">');
 html=html.replaceAll('<script defer src="/design-system/casca.js"></script><script defer src="/design-system/casca.js"></script>','<script defer src="/design-system/casca.js"></script>');
 await writeFile(file,html);
}
