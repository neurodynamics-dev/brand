import * as React from 'react';
/** Floating glass header for sites (expressive). 14px from the top, 16px radius, glass behind; scrolled adds a 16% border and deep shadow. Apps use the side menu instead. */
export interface SiteHeaderProps{ links?:string[]; active?:number; tag?:string; cta?:string|null; scrolled?:boolean; }
export declare function SiteHeader(props:SiteHeaderProps):JSX.Element;
