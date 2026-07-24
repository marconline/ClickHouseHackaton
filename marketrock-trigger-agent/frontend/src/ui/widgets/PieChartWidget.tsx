import {
    PieChart,
    Pie,
    Tooltip,
    ResponsiveContainer,
    Cell
}
from "recharts";
import { chartColors } from "../theme/chartTheme";

export default function PieChartWidget(
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

                <PieChart>

                    <Pie
                        data={data}
                        dataKey="value"
                        nameKey="name"
                        outerRadius={100}
                    >

                        {
                            data.map(
                                (_:any,index:number)=>
                                (
 <Cell

key={index}

fill={
    chartColors[index % chartColors.length]
}

/>
                                )
                            )
                        }

                    </Pie>


                    <Tooltip />

                </PieChart>


            </ResponsiveContainer>


        </div>

    );

}