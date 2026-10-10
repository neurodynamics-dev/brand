import {renderer} from './render.mjs';
const r=await renderer();let falhas=0;const ok=(s,b)=>{console.log(`${b?'ok':'FALHA'} ${s}`);if(!b)falhas++;};
try{for(const w of [1440,390])for(const route of ['','fundamentos','fundamentos/cor','fundamentos/tipografia','fundamentos/assinaturas','aplicacoes','aplicacoes/papel-timbrado','interface','interface/componentes','interface/padroes','imprensa','downloads','marca','nao-existe']){
 await r.page.setViewportSize({width:w,height:900});const errors=[];const handler=e=>errors.push(e.message);r.page.on('pageerror',handler);
 await r.open(route);await r.page.evaluate(async()=>{for(const im of document.images){im.loading='eager';await im.decode().catch(()=>{});}document.querySelectorAll('.reveal').forEach(e=>e.classList.add('seen'));});
 ok(`${route||'início'} ${w}: largura, imagens e JS`,await r.page.evaluate(()=>document.documentElement.scrollWidth<=innerWidth+1&&[...document.images].every(im=>im.complete&&im.naturalWidth>0))&&!errors.length);
 if(!route&&w===1440)await r.page.screenshot({path:'/workspace/setup-logs/brand-home.png',fullPage:true});
 r.page.off('pageerror',handler);
}await r.open('fundamentos/cor');const links=await r.page.locator('a[href^="/"]').evaluateAll(a=>[...new Set(a.map(x=>x.getAttribute('href')))]);for(const href of links){const response=await r.page.request.get('http://127.0.0.1:8766'+href);ok('link '+href,response.status()===200);}}finally{await r.browser.close();}process.exitCode=falhas?1:0;
