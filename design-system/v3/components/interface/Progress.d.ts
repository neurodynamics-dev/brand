import * as React from 'react';
/** Progress bar (value 0 to 100, Axon to Synapse gradient, primary set) or spinner when value is omitted. */
export interface ProgressProps{ value?:number; label?:string; }
export declare function Progress(props:ProgressProps):JSX.Element;
