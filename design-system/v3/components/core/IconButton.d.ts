import * as React from 'react';
/** Icon-only utility button, same quiet treatment as the in-field actions (5.5% white veil, Névoa icon, 11% on hover, Synapse outline on keyboard focus). Use beside running text or data, e.g. to copy an e-mail. With icon="copy"|"link" and a value, copies it and confirms in Nominal for 1.6s. Never Synapse fill: these are utilities, not final actions. */
export interface IconButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement>{ icon?:'copy'|'paste'|'clear'|'reveal'|'link'|'download'; value?:string; label?:string; size?:'sm'|'md'; }
export declare function IconButton(props:IconButtonProps):JSX.Element;
