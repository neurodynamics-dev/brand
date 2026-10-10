import * as React from 'react';
/** Multi-select filters. Each group is a 32px trigger (label, count badge, chevron) that opens a listbox with checkboxes, Limpar and Aplicar. Active values appear below as removable 24px tags with "Limpar filtros". Synapse only on the Aplicar action (a user action), never on selection or the open trigger; checked boxes are ink. */
export interface FilterGroup{ label:string; options:string[]; selected?:string[]; }
export interface FilterBarProps{ filters:FilterGroup[]; count?:number|string; onChange?:(s:Record<string,string[]>)=>void; }
export declare function FilterBar(props:FilterBarProps):JSX.Element;
