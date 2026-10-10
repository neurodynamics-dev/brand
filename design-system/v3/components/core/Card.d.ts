/** Content container. 1px line, 18px radius, glass fill; `paper` tone for formal docs. */
export interface CardProps{ title?:string; tone?:'dark'|'paper'; style?:React.CSSProperties; children?:React.ReactNode; }
export declare function Card(props:CardProps):JSX.Element;