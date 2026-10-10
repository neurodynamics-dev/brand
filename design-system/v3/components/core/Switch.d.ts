import * as React from 'react';
/** Compact switch for 2–3 exclusive options: language (EN / PT), mode or state. Archivo 600 uppercase, 30px tall, 8px radius; the selected option sits on a 9% white veil in ink. As a state switch, each item takes a functional status; the current one shows its icon and text in that functional colour on a 14% tint. Never more than 3 options (use Segmented for filters); never Synapse. */
export interface SwitchItem{ label:string; status?:'nominal'|'caution'|'critical'|'signal'|'idle'; iconOnly?:boolean; }
export interface SwitchProps{ items:(string|SwitchItem)[]; active?:number; onChange?:(i:number)=>void; label?:string; }
export declare function Switch(props:SwitchProps):JSX.Element;
