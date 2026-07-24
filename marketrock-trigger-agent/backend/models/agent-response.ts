export type AgentResponse = {

    title:string;

    summary:string;

    widgets:
    Widget[];

};


export type Widget =
    | KpiWidget
    | BarChartWidget
    | TableWidget;


export type KpiWidget = {

    type:"kpi";

    title:string;

    value:number;

    currency:string;

};


export type BarChartWidget = {

    type:"bar_chart";

    title:string;

    data:any[];

};


export type TableWidget = {

    type:"table";

    title:string;

    columns:string[];

    rows:any[];

};