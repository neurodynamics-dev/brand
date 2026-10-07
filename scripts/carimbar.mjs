import {readFile,writeFile,readdir} from 'node:fs/promises';import {fileURLToPath} from 'node:url';import path from 'node:path';
const root=fileURLToPath(new URL('..',import.meta.url));
const parts=Object.fromEntries(await Promise.all(['cabecalho','rodape'].map(async k=>[k,await readFile(path.join(root,'site/partes',k+'.html'),'utf8')])));
for(const name of await readdir(root)){if(!name.endsWith('.html'))continue;const file=path.join(root,name);let html=await readFile(file,'utf8');
 for(const [k,source] of Object.entries(parts)){const route=name==='index.html'?'/':'/'+name.slice(0,-5);const part=source.replaceAll(`href="${route}"`,`href="${route}" aria-current="page"`);html=html.replace(new RegExp(`<!-- ${k} -->[\\s\\S]*?<!-- /${k} -->`),`<!-- ${k} -->\n${part}\n<!-- /${k} -->`);}
 await writeFile(file,html);
}
