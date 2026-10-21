/** Signature line for letters, certificates and minutes. */
export interface SignatureBlockProps{ name:string; role?:string; org?:string; align?:'left'|'center'; }
export declare function SignatureBlock(props:SignatureBlockProps):JSX.Element;