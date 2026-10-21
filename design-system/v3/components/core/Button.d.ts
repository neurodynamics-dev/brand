import * as React from 'react';
/** Action button. One `solid` per screen. `danger` (Functional Critical) for destructive actions in dialogs. `formal`/`formal-outline` for paper documents. `family` paints the button in one Secondary-set family (medium fill, dark text, light on hover), overriding variant; use it inside family surfaces such as a family Band, never next to Synapse.
 * @startingPoint section="Core" subtitle="Solid, claro, ghost, formal" viewport="700x260" */
export interface ButtonProps extends React.ButtonHTMLAttributes<HTMLButtonElement>{
  variant?:'solid'|'danger'|'claro'|'ghost'|'formal'|'formal-outline';
  size?:'md'|'mini';
  family?:'cortex'|'ion'|'neuron'|'glia'|'retina'|'nexo'|'dendrito'|'lumen'|'ritmo'|'impulso'|'plexo'|'iris';
  disabled?:boolean;
  children?:React.ReactNode;
}
export declare function Button(props:ButtonProps):JSX.Element;