import React from 'react';
export function Letterhead({reference,date,classification,family='cortex'}){
  const base=(typeof window!=='undefined'&&window.NRO_ASSET_BASE)||'';
  const dark=`var(--${family}-dark)`;
  const m=`url(${base}assets/logo-imagotipo-black.png) left/contain no-repeat`;
  return <header style={{display:'flex',flexDirection:'column',gap:14}}><div style={{display:'flex',justifyContent:'space-between',alignItems:'flex-end'}}><div role="img" aria-label="NeuroDynamics" style={{width:118,height:20,background:dark,WebkitMask:m,mask:m}}></div><div style={{textAlign:'right',fontFamily:'var(--fd)',fontWeight:300,fontSize:11,color:'var(--formal-ink-2)',lineHeight:1.5}}>{reference&&<div>{reference}</div>}{date&&<div>{date}</div>}</div></div><div style={{height:1,background:dark}}></div>{classification&&<div style={{fontFamily:'var(--fs-formal)',fontStyle:'italic',fontSize:14,color:dark}}>{classification}</div>}</header>;
}