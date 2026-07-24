import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";
import type { ToolResult } from "./types.js";

export async function getSalesOverview(
    args:{
        from:string;
        to:string;
        currency?:string;
    }
){

    const rows =
        await executeQuery(
            await loadSql("sales_overview.sql"),
            {
                from:`${args.from} 00:00:00`,
                to:`${args.to} 00:00:00`,
                currency:args.currency ?? ""
            }
        );


    return {

        type:"sales_overview",


        title:
            "Business Overview",


        widgets:[

            {
                type:"kpi",

                items:[
                    {
                        label:"Gross Revenue",
                        value:
                            rows
                            .reduce(
                                (sum,r)=>
                                    sum+r.GrossRevenue,
                                0
                            ),

                        currency:"MULTI"
                    },


                    {
                        label:"Orders",

                        value:
                            rows
                            .reduce(
                                (sum,r)=>
                                    sum+r.Orders,
                                0
                            )
                    }
                ]
            },


            {
                type:"bar_chart",

                title:
                    "Revenue by currency",


                data:
                    rows.map(r=>({

                        name:r.Currency,

                        value:r.GrossRevenue

                    }))

            }

        ]

    };

}