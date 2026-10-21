import * as React from 'react';
/** Mobile app menu (expressive). Side drawer at 74% width over a dimmed page: logo + app tag, search, accordion sections with sub-items, notifications and user row. For complex interfaces such as the Portal do Membro and ERP. */
export interface MobileAppMenuProps{ app?:string; sections?:{label?:string;icon?:string;children?:{label?:string;divider?:boolean}[]}[]; active?:string; activeChild?:string; user?:{name:string;role:string}; notifications?:number; open?:boolean; children?:React.ReactNode; }
export declare function MobileAppMenu(props:MobileAppMenuProps):JSX.Element;
