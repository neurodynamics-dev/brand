/** Inline alert. Uses the Functional set only; plain fills and lines, no glow. */
export interface AlertProps{ status?:'nominal'|'caution'|'critical'|'signal'|'idle'; title:string; children?:any; }
export declare function Alert(props:AlertProps):JSX.Element;
