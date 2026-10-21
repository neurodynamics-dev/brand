import * as React from 'react';
/** Passing confirmation at the bottom of the screen, 4.2s, never carries a decision. Indicator from the Functional set. */
export interface ToastProps{ status?:'nominal'|'caution'|'critical'|'signal'|'idle'; children?:React.ReactNode; action?:string; onAction?:()=>void; }
export declare function Toast(props:ToastProps):JSX.Element;
