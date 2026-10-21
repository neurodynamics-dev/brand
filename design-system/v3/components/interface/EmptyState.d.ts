import * as React from 'react';
/** Empty state, always with a way out (an action that resolves the emptiness). Left-aligned. */
export interface EmptyStateProps{ title:string; children?:React.ReactNode; action?:React.ReactNode; }
export declare function EmptyState(props:EmptyStateProps):JSX.Element;
