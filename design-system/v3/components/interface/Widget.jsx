import React from 'react';
const IC={calendar:<><rect x="3.5" y="5" width="17" height="15" rx="2"/><path d="M3.5 10h17M8 3v4M16 3v4"/></>,mail:<><rect x="3" y="5.5" width="18" height="13" rx="2"/><path d="M3.5 7l8.5 6 8.5-6"/></>,chart:<><path d="M4 20V4M4 20h16"/><path d="M8 16v-4M12 16V8M16 16v-6"/></>,users:<><circle cx="9" cy="8.5" r="3.5"/><path d="M2.5 20c.8-3.6 3.4-5.5 6.5-5.5s5.7 1.9 6.5 5.5"/><path d="M15.5 5.2a3.5 3.5 0 0 1 0 6.6M18 14.8c1.8.8 3 2.5 3.5 5.2"/></>,doc:<><path d="M6 3h8l4 4v14H6z"/><path d="M14 3v4h4M9 12h6M9 16h6"/></>,pulse:<path d="M3 12h4l2-6 4 12 2-6h6"/>,trophy:<><path d="M8 4h8v5a4 4 0 0 1-8 0z"/><path d="M8 6H5v1a3 3 0 0 0 3 3M16 6h3v1a3 3 0 0 1-3 3M12 13v4M8.5 20h7M10 17h4"/></>,flame:<path d="M12 3c1 3 5 5 5 10a5 5 0 0 1-10 0c0-2.5 1.5-4 2.5-5 .3 1.6 1 2.6 2 3 0-3-.5-5.5.5-8z"/>,alert:<><path d="M12 3.5l9.5 16.5h-19z"/><path d="M12 10v4.5M12 17.2v.3"/></>};
const LAB={fontFamily:'var(--fd)',fontWeight:600,fontSize:11,letterSpacing:'.16em',textTransform:'uppercase',lineHeight:1,display:'inline-flex',alignItems:'center',gap:10};
export function Widget({label,meta,family,icon,slides,interval=12,children,pad=24,style}){
  const n=slides?slides.length:0;
  const [i,setI]=React.useState(0);const [p,setP]=React.useState(0);const [vis,setVis]=React.useState(true);
  React.useEffect(()=>{if(n<2)return;let t0=Date.now();const id=setInterval(()=>{const e=(Date.now()-t0)/1000;if(e>=interval){t0=Date.now();setP(0);setVis(false);setTimeout(()=>{setI(x=>(x+1)%n);setVis(true);},280);}else setP(e/interval);},100);return()=>clearInterval(id);},[n,interval]);
  const cur=n?slides[i%n]:null;
  const fam=(cur&&cur.family)||(!cur&&family)||null;const ic=(cur&&cur.icon)||(!cur&&icon)||null;
  const v=k=>'var(--'+fam+'-'+k+')';
  const lab=(cur&&cur.label)||label;const mt=(cur&&cur.meta)||meta;
  return <section style={{position:'relative',overflow:'hidden',borderRadius:18,background:'rgba(11,18,16,.78)',backdropFilter:'blur(18px)',WebkitBackdropFilter:'blur(18px)',border:'1px solid '+(fam?'color-mix(in srgb, '+v('primary')+' 24%, transparent)':'var(--line)'),padding:pad,display:'flex',flexDirection:'column',gap:18,minHeight:0,minWidth:0,boxSizing:'border-box',color:'var(--ink)',transition:'border-color .6s',...style}}>
    {fam&&<div aria-hidden="true" style={{position:'absolute',right:'-15%',bottom:'-55%',width:'75%',aspectRatio:'1',borderRadius:'50%',background:'radial-gradient(circle,color-mix(in srgb, '+v('primary')+' 40%, transparent),transparent 68%)',filter:'blur(40px)',pointerEvents:'none'}}></div>}
    {fam&&<div aria-hidden="true" style={{position:'absolute',inset:0,backgroundImage:'linear-gradient(rgba(255,255,255,.035) 1px,transparent 1px),linear-gradient(90deg,rgba(255,255,255,.035) 1px,transparent 1px)',backgroundSize:'28px 28px',WebkitMaskImage:'linear-gradient(90deg,transparent 35%,#000)',maskImage:'linear-gradient(90deg,transparent 35%,#000)',pointerEvents:'none'}}></div>}
    {ic&&IC[ic]&&<svg aria-hidden="true" viewBox="0 0 24 24" fill="none" stroke={fam?v('medium'):'var(--ink)'} strokeWidth="0.7" strokeLinecap="round" strokeLinejoin="round" style={{position:'absolute',right:'-6%',top:'50%',transform:'translateY(-50%)',width:'min(60%,340px)',opacity:.06,pointerEvents:'none'}}>{IC[ic]}</svg>}
    {(lab||mt||n>1)&&<header style={{position:'relative',display:'flex',alignItems:'center',gap:14,minHeight:14}}>
      {lab&&<span style={{...LAB,color:fam?v('medium'):'var(--nevoa)'}}><span style={{width:7,height:7,background:fam?v('primary'):'var(--cortex-medium)'}}></span>{lab}</span>}
      <span style={{flex:1}}></span>
      {mt&&<span style={{fontFamily:'var(--fm)',fontSize:12,color:'var(--nevoa)'}}>{mt}</span>}
      {n>1&&<span aria-hidden="true" style={{display:'flex',gap:4}}>{slides.map((_,k)=><span key={k} style={{width:18,height:3,background:'rgba(255,255,255,.12)',borderRadius:2,overflow:'hidden'}}><span style={{display:'block',height:'100%',width:(k<i?100:k===i?p*100:0)+'%',background:'var(--synapse)'}}></span></span>)}</span>}
    </header>}
    <div style={{position:'relative',flex:1,minHeight:0,display:'flex',flexDirection:'column',opacity:vis?1:0,transform:vis?'none':'translateY(6px)',transition:'opacity .28s,transform .28s'}}>{cur?cur.content:children}</div>
  </section>;
}
