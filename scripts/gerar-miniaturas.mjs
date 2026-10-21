import {renderer,root} from './render.mjs';import path from 'node:path';import {writeFile} from 'node:fs/promises';
const items=[
['business-card/BusinessCard','01 Frente','cartao-frente'],['business-card/BusinessCard','02 Verso','cartao-verso'],
['certificate/Certificate','01 Clássico','certificado'],['certificate-brand/CertificateBrand','02 Ion','certificado-marca-ion'],
['invitation/Invitation','Front, Cortex','convite-cortex'],['invitation/Invitation','Front, Retina','convite-retina'],
['badges/Badges','C1 Ficha frente','cracha-ficha'],['badges/Badges','B1 Retrato escuro','cracha-retrato'],['badges/Badges','A1 Sinal frente','cracha-sinal'],
['formal-deck/FormalDeck','01 Capa, Cortex','deck-formal-capa'],['formal-deck/FormalDeck','16 Big numbers','deck-formal-numeros'],
['brand-deck/BrandDeck','01 Capa, Cortex com brilho','deck-marca-capa'],['brand-deck/BrandDeck','19 Bar chart','deck-marca-grafico'],['brand-deck/BrandDeck','14 Content, three panels','deck-marca-paineis'],
['posters/Posters','06 Diagrama de blocos','poster-blocos'],['posters/Posters','05 PCB NeuroAmp-32','poster-pcb'],['posters/Posters','03 Simplicidade','poster-simplicidade'],['posters/Posters','01 Every signal has noise','poster-sinal'],
['formal-report/FormalReport','01 Cover','relatorio-capa'],['formal-report/FormalReport','02 Body','relatorio-texto'],
['social/Social','01 Feed Cortex','social-feed-cortex'],['social/Social','02 Feed Retina','social-feed-retina'],['social/Social','03 Story','social-story'],['social/Social','04 Banner LinkedIn','social-linkedin'],
['letterhead/Letterhead','01 Carta executiva','timbre-executivo'],['letterhead/Letterhead','03 Carta operacional','timbre-operacional'],
...['mesh','waves','circuit','pulse'].map(x=>['wallpapers/Wallpapers',x+'-desktop','wall-'+x]),
['email/Boletim',null,'email-boletim'],['email/variantes/Comunicado-retina',null,'email-comunicado-retina']];
const r=await renderer(),index=[];
try{for(const [template,label,name]of items){await r.open('templates/'+template+'.html');const selector=label?`[data-screen-label=${JSON.stringify(label)}]`:'body > table';const size=await r.shot(selector,path.join(root,'assets/manual',name+'.jpg'),800);index.push({file:name+'.jpg',template:'templates/'+template+'.html',label,...size});console.log(name);}
await writeFile(path.join(root,'assets/manual/index.json'),JSON.stringify(index,null,2)+'\n');}finally{await r.browser.close();}
