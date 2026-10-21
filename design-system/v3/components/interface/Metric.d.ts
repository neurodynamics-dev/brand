import * as React from 'react';
/** Label pinned to the top; value and delta pinned together to the bottom, so a label that wraps never shifts the number out of line with sibling tiles in the same row (tiles stretch to the row height). KPI tile. Value in Archivo 600; delta is data, in Plex Mono, coloured with the Functional set (up Nominal, down Critical). */
export interface MetricProps{ label:string; value:string; unit?:string; delta?:string; trend?:'up'|'down'|'flat'; }
export declare function Metric(props:MetricProps):JSX.Element;
