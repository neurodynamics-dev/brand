import React from 'react';
const K={nominal:'nominal',caution:'caution',critical:'critical',signal:'signal',idle:'idle',vital:'nominal',mielina:'caution',pulso:'critical',plasma:'signal',ion:'signal',dendrito:'idle'};
export function Pill({status,children}){
  const f=K[status], c=f?`var(--fn-${f}-primary)`:null;
  return <span style={{display:'inline-flex',flex:'none',whiteSpace:'nowrap',alignItems:'center',gap:7,fontFamily:'var(--fm)',fontWeight:500,fontSize:10.5,letterSpacing:'.06em',textTransform:'uppercase',border:'1px solid '+(c?`color-mix(in srgb, ${c} 45%, transparent)`:'var(--line2)'),borderRadius:5,padding:'3px 10px',color:c||'var(--nevoa)'}}>{c&&<span style={{width:6,height:6,borderRadius:1,background:c}}></span>}{children}</span>;
}