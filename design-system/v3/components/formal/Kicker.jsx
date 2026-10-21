import React from 'react';
export function Kicker({variant='rule',label,index,family='cortex'}){
  const dark=`var(--${family}-dark)`, prim=`var(--${family}-primary)`, light=`var(--${family}-light)`;
  if(variant==='folio') return <div style={{display:'flex',alignItems:'flex-start',gap:12}}><span style={{fontFamily:'var(--fs-formal)',fontSize:56,lineHeight:.8,color:family==='cortex'?'var(--cortex-primary)':dark}}>{index}</span><span style={{fontFamily:'var(--fd)',fontWeight:500,fontSize:14,lineHeight:1.3,color:'var(--formal-ink)',paddingTop:2,maxWidth:160}}>{label}</span></div>;
  if(variant==='tint') return <div style={{background:light,borderRadius:10,padding:'12px 14px',display:'inline-block'}}><span style={{fontFamily:'var(--fs-formal)',fontStyle:'italic',fontSize:19,color:dark}}>{label}</span></div>;
  return <div><div style={{height:1,background:dark}}></div><div style={{display:'flex',justifyContent:'space-between',alignItems:'baseline',marginTop:10}}><span style={{fontFamily:'var(--fd)',fontWeight:500,fontSize:14,color:dark}}>{label}</span>{index&&<span style={{fontFamily:'var(--fs-formal)',fontStyle:'italic',fontSize:18,color:dark}}>{index}</span>}</div></div>;
}