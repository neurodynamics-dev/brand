import * as React from 'react';
/** Proportion bar in the four tones of one family (dark, primary, medium, light). */
export interface ProportionItem{ label:string; value:number; }
export interface ProportionBarProps{ items:ProportionItem[]; family?:'cortex'|'ion'|'neuron'|'retina'|'nexo'|'dendrito'; }
export declare function ProportionBar(props:ProportionBarProps):JSX.Element;
