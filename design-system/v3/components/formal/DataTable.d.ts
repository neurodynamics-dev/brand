/** Print-style booktabs table for reports. */
export interface DataTableProps{ columns:string[]; rows:(string|number)[][]; caption?:string; }
export declare function DataTable(props:DataTableProps):JSX.Element;