// Capas para outras plataformas, a partir de templates/social/Plataformas.html.
// Uso, da raiz do repositório: cd scripts && node gerar-plataformas.mjs
import {renderer,root} from './render.mjs';import path from 'node:path';import {writeFile} from 'node:fs/promises';
const r=await renderer(),index=[];
try{
 for(const [slug,label,w] of [['youtube','YouTube',2560],['facebook','Facebook',1640],['x','X',1500]]){
  await r.open('templates/social/Plataformas.html');
  const file=`plataformas/${slug}-tools-for-health.jpg`;
  const size=await r.shot(`[data-screen-label^="${label}"]`,path.join(root,'downloads',file),w);
  index.push({file,plataforma:label,...size});console.log(file,size);
 }
 await writeFile(path.join(root,'downloads/plataformas/index.json'),JSON.stringify({frase:'Tools for health.',idioma:'en',familia:'cortex',foto:{descricao:'Cérebro humano sobre fundo preto',autor:'Shawn Day',banco:'Unsplash',licenca:'Licença Unsplash',pagina:'https://unsplash.com/photos/ii6BOPjAtVY'},capas:index},null,1)+'\n');
}finally{await r.browser.close();}
