import KPIWidget from "./widgets/KPIWidget";
import BarChartWidget from "./widgets/BarChartWidget";
import LineChartWidget from "./widgets/LineChartWidget";
import PieChartWidget from "./widgets/PieChartWidget";
import TableWidget from "./widgets/TableWidget";
import InsightWidget from "./widgets/InsightWidget";
import MetricWidget from "./widgets/MetricWidget";
import NumberCardWidget from "./widgets/NumberCardWidget";
import MapWidget from "./widgets/MapWidget";

export type Widget =

    | {
        type:"kpi";

        items:{
            label:string;
            value:number;
            currency?:string;
        }[];
    }


    | {
        type:"bar_chart";

        title:string;

        data:{
            name:string;
            value:number;
        }[];
    }


    | {
        type:"line_chart";

        title:string;

        data:{
            name:string;
            value:number;
        }[];
    }


    | {
        type:"pie_chart";

        title:string;

        data:{
            name:string;
            value:number;
        }[];
    }


    | {
        type:"table";

        title:string;

        columns:string[];

        rows:Record<string, any>[];
    }


    | {
        type:"insight";

        title:string;

        text:string;

        severity?:
            | "positive"
            | "negative"
            | "neutral";
    }

    | {
    type:"metric";

    label:string;

    value:number;

    unit?:string;

    currency?:string;

    trend:number;

    trendLabel?:string;
}

| {
    type:"number_card";

    label:string;

    value:number;

    unit?:string;

    currency?:string;
}

| {
 type:"map";
 title:string;
 markers:{
    lat:number;
    lng:number;
    label:string;
    value:number;
 }[];
};


interface Props {

    widgets:Widget[];

}


export default function WidgetRenderer(
    {
        widgets
    }:Props
){

    return (

        <div
            style={{
                display:"flex",
                flexDirection:"column",
                gap:"24px"
            }}
        >

{
widgets.map(
    (widget,index)=>{

        console.log(
            "WIDGET",
            widget
        );


        return (
            <div key={index}>
                            {
                                widget.type==="kpi" &&
                                <KPIWidget
                                    {...widget}
                                />
                            }


                            {
                                widget.type==="bar_chart" &&
                                <BarChartWidget
                                    {...widget}
                                />
                            }

                            {
                                widget.type==="line_chart" &&
                                <LineChartWidget
                                    {...widget}
                                />
                            }


                            {
                                widget.type==="pie_chart" &&
                                <PieChartWidget
                                    {...widget}
                                />
                            }


                            {
                                widget.type==="table" &&
                                <TableWidget
                                    {...widget}
                                />
                            }


                            {
                                widget.type==="insight" &&
                                <InsightWidget
                                    {...widget}
                                />
                            }

                            {
                                widget.type==="metric" &&
                                <MetricWidget
                                    {...widget}
                                />
                            }

                            {
                                widget.type==="number_card" &&
                                <NumberCardWidget
                                    {...widget}
                                />
                            }

                            {
                                widget.type==="map" &&
                                <MapWidget
                                    {...widget}
                                />
                            }

            </div>
        )

    }
)
}

        </div>

    );
}