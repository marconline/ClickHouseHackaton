import {
    LineChart,
    Line,
    XAxis,
    YAxis,
    CartesianGrid,
    Tooltip,
    ResponsiveContainer
}
from "recharts";


export default function LineChartWidget(
{
    title,
    data
}:any
){

    return (

        <div>

            <h3>
                {title}
            </h3>


            <ResponsiveContainer
                width="100%"
                height={300}
            >

                <LineChart
                    data={data}
                >

                    <CartesianGrid />

                    <XAxis
                        dataKey="name"
                    />

                    <YAxis />

                    <Tooltip
        contentStyle={{
            borderRadius:12,
            border:"none",
            boxShadow:"0 10px 30px rgba(0,0,0,.1)"
        }}
    />

<Line

    type="monotone"

    dataKey="value"

    stroke="#2563EB"

    strokeWidth={3}

    dot={{
        r:5,
        fill:"#2563EB"
    }}

/>

                </LineChart>


            </ResponsiveContainer>


        </div>

    );

}