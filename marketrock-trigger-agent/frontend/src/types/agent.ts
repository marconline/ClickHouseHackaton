export type AgentResponse = {

    title:string;

    widgets:AgentWidget[];

};


export type AgentWidget =

    | KPIWidget
    | BarChartWidget;



export type KPIWidget = {

    type:"kpi";

    items:{
        label:string;
        value:number;
        currency?:string;
    }[];

};



export type BarChartWidget = {

    type:"bar_chart";

    title:string;

    data:{
        name:string;
        value:number;
    }[];

};