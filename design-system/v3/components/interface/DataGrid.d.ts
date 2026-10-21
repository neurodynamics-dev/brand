import * as React from 'react';
/** Interface data table. Numbers in Plex Mono, right-aligned; text left. 8% row lines, 16% header line, no zebra. */
export interface DataGridColumn{ key:string; label:string; num?:boolean; }
export interface DataGridProps{ columns:DataGridColumn[]; rows:Record<string,React.ReactNode>[]; }
export declare function DataGrid(props:DataGridProps):JSX.Element;
