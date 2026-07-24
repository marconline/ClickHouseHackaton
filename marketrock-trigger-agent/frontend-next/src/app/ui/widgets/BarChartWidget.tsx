import {
    BarChart,
    Bar,
    XAxis,
    YAxis,
    Tooltip,
    ResponsiveContainer
} from "recharts";


interface Props {

    title:string;

    data:{
        name:string;
        value:number;
    }[];

}


export default function BarChartWidget(
    {
        title,
        data
    }:Props
){

    return (

       <div
            style={{
                height:350
            }}
        >

            <h2>
                {title}
            </h2>


            <ResponsiveContainer
                width="100%"
                height="100%"
            >

                <BarChart
                    data={data}
                >

                    <XAxis
                        dataKey="name"
                    />

                    <YAxis/>


                    <Tooltip/>


                    <Bar
                        dataKey="value"
                        fill="#2563EB"
                        radius={[8,8,0,0]}
                    />

                </BarChart>

            </ResponsiveContainer>

        </div>

    );

}