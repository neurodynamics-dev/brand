import {renderer,root} from './render.mjs';import path from 'node:path';import {writeFile} from 'node:fs/promises';
const r=await renderer(),index=[];
try{for(const[style,nome]of [['mesh','rede'],['waves','ondas'],['circuit','circuito'],['pulse','pulso']])for(const[format,label,w,h]of [['desktop','desktop',2560,1440],['phone','celular',1179,2556],['tablet','tablet',2048,2732],['video','videochamada',1920,1080]]){
 await r.open('templates/wallpapers/Wallpapers.html');const selector=`[data-screen-label="${style}-${format}"]`;
 await r.page.locator(selector).evaluate((el,{w,h})=>{const width=parseFloat(el.style.width);el.style.height=(width*h/w)+'px';},{w,h});
 const file=`wallpapers/${nome}-${label}.jpg`;const size=await r.shot(selector,path.join(root,'downloads',file),w);index.push({file,...size});console.log(file);
}await r.open('templates/social/Social.html');const file='linkedin/capa.jpg';index.push({file,...await r.shot('[data-screen-label="04 Banner LinkedIn"]',path.join(root,'downloads',file),1584)});await writeFile(path.join(root,'downloads/index.json'),JSON.stringify(index,null,2)+'\n');}finally{await r.browser.close();}
