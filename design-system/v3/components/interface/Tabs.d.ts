import * as React from 'react';
/** Level 2 selector: the cuts inside one section. Synapse underline marks the active tab. */
export interface TabsProps{ items:string[]; active?:number; onChange?:(i:number)=>void; }
export declare function Tabs(props:TabsProps):JSX.Element;
