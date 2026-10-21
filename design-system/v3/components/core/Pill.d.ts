/** Status pill. Uses the Functional set only. Legacy keys (vital, mielina, pulso, plasma, ion, dendrito) still map to functional families. */
export interface PillProps{ status?:'nominal'|'caution'|'critical'|'signal'|'idle'; children?:any; }
export declare function Pill(props:PillProps):JSX.Element;
