/** Choice chip. Default `quiet`: selection shown like the level 1 section selector (9% white fill, ink, 600), Synapse only on keyboard focus. `accent` fills with Synapse and is reserved for a choice that acts as the user's focus or main action. */
export interface ChipProps extends React.ButtonHTMLAttributes<HTMLButtonElement>{ on?:boolean; variant?:'quiet'|'accent'; children?:React.ReactNode; }
export declare function Chip(props:ChipProps):JSX.Element;
