export type AgentResponse = {

    summary: string;

    widgets: Widget[];

};


export type Widget =
    | KpiWidget
    | BarChartWidget
    | LineChartWidget
    | TableWidget;


export interface KpiWidget {

    type: "kpi";

    title: string;

    value: string;

    trend?: {
        value: number;
        direction: "up" | "down";
    };

}


export interface BarChartWidget {

    type: "bar_chart";

    title: string;

    data: {

        label: string;

        value: number;

    }[];

}


export interface LineChartWidget {

    type: "line_chart";

    title: string;

    data: {

        date: string;

        value: number;

    }[];

}


export interface TableWidget {

    type: "table";

    title: string;

    columns: string[];

    rows: any[];

}