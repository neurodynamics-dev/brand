/** Formal section label. Replaces mono uppercase eyebrows in documents, decks and invitations. */
export interface KickerProps{ variant?:'rule'|'folio'|'tint'; label:string; index?:string; family?:'cortex'|'sulco'|'pia'|'medula'|'ion'|'neuron'|'glia'|'retina'|'nexo'|'dendrito'|'lumen'|'ritmo'|'impulso'|'plexo'|'iris'; }
export declare function Kicker(props:KickerProps):JSX.Element;