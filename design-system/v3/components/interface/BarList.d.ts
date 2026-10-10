import * as React from 'react';
/** Horizontal comparison bars drawn as discrete ticks: a tick of width x followed by a 3x gap (default x = 1.5px), square ends, so short values never turn into rounded blobs. Filled ticks in the family primary tone, empty ticks at 8%. One family per chart. */
export interface BarListItem{ label:string; value:number; label2?:string; }
export interface BarListProps{ items:BarListItem[]; tick?:number; family?:'cortex'|'ion'|'neuron'|'retina'|'nexo'|'dendrito'; }
export declare function BarList(props:BarListProps):JSX.Element;
