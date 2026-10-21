import * as React from 'react';
/** App navigation (Portal do Membro, ERP, internal tools). Open 252px with expandable sub-items, or collapsed 68px rail with fly-out. Imagotipo when open; solid square icon when collapsed (the logo does not fit). Synapse marks the active section icon and the active child. Icons are a thin-stroke substitution (no brand icon set). */
export interface SideMenuChild{ label:string; code?:string; }
export interface SideMenuSection{ label?:string; icon?:'home'|'grid'|'users'|'file'|'calendar'|'chart'|'settings'|'box'; children?:SideMenuChild[]; divider?:string; }
export interface SideMenuProps{ app?:string; sections:SideMenuSection[]; active?:string; activeChild?:string; collapsed?:boolean; user?:{name:string;role:string}; notifications?:number; height?:number|string; dark?:boolean; onTheme?:(dark:boolean)=>void; onBug?:()=>void; }
export declare function SideMenu(props:SideMenuProps):JSX.Element;
