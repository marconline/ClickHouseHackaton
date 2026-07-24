export type AgentResponse = {

    title: string;

    summary: string;

    widgets: Widget[];

};


export type Widget =
    | KPIWidget
    | ChartWidget
    | TableWidget
    | AlertWidget
    | InsightWidget;



export type KPIWidget = {

    type: "kpi";

    label: string;

    value: number | string;

    currency?: string;

    trend?: {
        value: number;
        direction: "up" | "down";
    };

};



export type ChartWidget = {

    type: "chart";

    chartType:
        | "bar"
        | "line"
        | "pie";

    title: string;

    data: {
        label: string;
        value: number;
        currency?:string;
    }[];

};



export type TableWidget = {

    type: "table";

    columns: string[];

    rows: any[][];

};



export type AlertWidget = {

    type: "alert";

    severity?:
        | "info"
        | "warning"
        | "error";

    message: string;

};



export type InsightWidget = {

    type:"insight";

    text:string;

};