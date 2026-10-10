import * as React from 'react';
/** Level 1 selector: the sections of a screen, each with its own address. Always the first selector on a screen. */
export interface SectionNavItem{ label:string; count?:number; highlight?:boolean; }
export interface SectionNavProps{ items:(string|SectionNavItem)[]; active?:number; onChange?:(i:number)=>void; }
export declare function SectionNav(props:SectionNavProps):JSX.Element;
