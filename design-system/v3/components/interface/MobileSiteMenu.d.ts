import * as React from 'react';
/** Mobile site menu (expressive). Floating glass header with logo, menu button (language switch appears only when open); opens into a full-height numbered list. Footer lines in Archivo uppercase. */
export interface MobileSiteMenuProps{ links?:string[]; active?:number; langs?:string[]; lang?:string; footer?:string[]; open?:boolean; eyebrow?:string; children?:React.ReactNode; }
export declare function MobileSiteMenu(props:MobileSiteMenuProps):JSX.Element;
