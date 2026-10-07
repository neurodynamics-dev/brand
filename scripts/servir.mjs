import http from 'node:http';import {readFile,stat} from 'node:fs/promises';import path from 'node:path';import {fileURLToPath} from 'node:url';
const root=path.resolve(fileURLToPath(new URL('..',import.meta.url)));
const mime={'.html':'text/html; charset=utf-8','.css':'text/css','.js':'application/javascript','.png':'image/png','.jpg':'image/jpeg','.svg':'image/svg+xml','.json':'application/json','.woff2':'font/woff2','.woff':'font/woff'};
http.createServer(async(req,res)=>{
 try{let pathname=decodeURIComponent(new URL(req.url,'http://localhost').pathname);let file=path.resolve(root,'.'+pathname);if(!file.startsWith(root+path.sep)&&file!==root){res.writeHead(403);res.end();return;}
 try{if((await stat(file)).isDirectory())file=path.join(file,'index.html');}catch{if(!path.extname(file))file+='.html';}
 let data,status=200;try{data=await readFile(file);}catch{file=path.join(root,'404.html');data=await readFile(file);status=404;}
 res.writeHead(status,{'Content-Type':mime[path.extname(file)]||'application/octet-stream','Cache-Control':'no-cache'});res.end(data);
 }catch{res.writeHead(400);res.end('Requisição inválida.');}
}).listen(Number(process.env.PORT||8766),'127.0.0.1',()=>console.log('Manual da marca: servidor iniciado.'));
