import * as React from 'react';
/** Decision dialog; leaves only with an answer. Destructive action uses Button variant="danger". */
export interface DialogProps{ title:string; children?:React.ReactNode; actions?:React.ReactNode; }
export declare function Dialog(props:DialogProps):JSX.Element;
