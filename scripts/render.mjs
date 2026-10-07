import {chromium} from 'playwright';
import {mkdir,readFile} from 'node:fs/promises';
import path from 'node:path';
import {fileURLToPath} from 'node:url';
export const root=fileURLToPath(new URL('..',import.meta.url));
export async function renderer(){
 const browser=await chromium.launch({executablePath:process.env.CHROMIUM_PATH||'/usr/bin/chromium',headless:true});
 const page=await browser.newPage({viewport:{width:2400,height:1600},deviceScaleFactor:1});
 let css='';
 for(const [slug,family] of [['archivo','Archivo'],['instrument-sans','Instrument Sans'],['instrument-serif','Instrument Serif'],['ibm-plex-mono','IBM Plex Mono']])for(const weight of (slug==='instrument-serif'?[400]:[300,400,500,600,700]))for(const style of ['normal','italic']){
  const file=`${slug}-latin-${weight}-${style}.woff2`;
  try{const bytes=await readFile(path.join(root,'scripts/node_modules/@fontsource',slug,'files',file));css+=`@font-face{font-family:'${family}';font-style:${style};font-weight:${weight};src:url(data:font/woff2;base64,${bytes.toString('base64')}) format('woff2');}\n`;}catch{}
 }
 await page.route('https://fonts.googleapis.com/**',r=>r.fulfill({contentType:'text/css',body:css}));
 return {browser,page,async open(file){await page.goto('http://127.0.0.1:8766/'+file);await page.addStyleTag({content:css});await page.evaluate(()=>document.fonts.ready);},async shot(selector,file,width){
  const element=page.locator(selector).first();
  await element.evaluate(el=>{const clone=el.cloneNode(true);document.body.replaceChildren(clone);document.body.style.cssText='margin:0;padding:0;display:block;background:white';clone.style.margin='0';clone.style.transform='none';clone.style.borderRadius='0';clone.style.position='relative';clone.id='export-screen';});
  const target=page.locator('#export-screen');const box=await target.boundingBox();const scale=width/box.width;
  await page.setViewportSize({width:Math.ceil(width),height:Math.ceil(box.height*scale)});
  await target.evaluate((el,s)=>{el.style.transformOrigin='top left';el.style.transform=`scale(${s})`;},scale);
  await mkdir(path.dirname(file),{recursive:true});
  await page.screenshot({path:file,type:'jpeg',quality:92,clip:{x:0,y:0,width:Math.round(width),height:Math.round(box.height*scale)}});
  return {width:Math.round(width),height:Math.round(box.height*scale)};
 }};
}
