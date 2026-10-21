import * as React from 'react';
/** Filter or choice that does not change section. Quiet selection like SectionNav (9% white, ink, 600); same 32px height and 8px radius as FilterBar triggers. Synapse never marks selection. */
export interface SegmentedProps{ items:string[]; active?:number; onChange?:(i:number)=>void; }
export declare function Segmented(props:SegmentedProps):JSX.Element;
