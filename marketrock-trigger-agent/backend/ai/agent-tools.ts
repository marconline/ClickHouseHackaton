import { chat } from "@trigger.dev/sdk/ai";
import { streamText, stepCountIs, tool } from "ai";
import { z } from "zod";

import { getSalesOverview } from "../tools/sales.js";
import { getRevenueTrend } from "../tools/revenue.js";
import { getTopProducts } from "../tools/products.js";
import { getMarketplacePerformance } from "../tools/marketplace.js";
import { getFulfillmentOverview } from "../tools/fulfillment.js";
import { getMarketplaceFulfillmentPerformance } 
    from "../tools/marketplace-fulfillment.js";
import { getCustomerHealthSummary }
    from "../tools/customer-health.js";



export const analyticsTools = {
    getSalesOverview:

        tool({
            description: "Returns general sales KPIs: revenue, orders, quantity per period.",
            inputSchema:z.object({
                from:z.string(),
                to:z.string(),
                currency:z.string().optional()
            }),
            execute:
                async(args)=>{
                    console.log("🔥 analyticsTools tool");
                    return await getSalesOverview(args);
                }
        }),

    getRevenueTrend: 

        tool({
            description: "Returns the trend of turnover over time.",
            inputSchema:z.object({
                from:z.string(),
                to:z.string(),
                currency:z.string().optional()
            }),
            execute:
                async(args)=>{
                    console.log("🔥 getRevenueTrend tool");
                    return await getRevenueTrend(args);
                }
        }),

    getTopProducts: 
        tool({
                description: "Returns products with the highest turnover or quantity sold.",
                inputSchema:z.object({
                    from:z.string(),
                    to:z.string(),
                    limit:z.number().optional()
                }),
                execute:
                    async(args)=>{
                        console.log("🔥 getTopProducts tool");
                        return await getTopProducts(args);
                    }
            }),

    getMarketplacePerformance:
            tool({
                description: "Analyze marketplace performance.",
                inputSchema:z.object({
                    from:z.string(),
                    to:z.string(),
                }),
                execute:
                    async(args)=>{
                        console.log("🔥 getMarketplacePerformance tool");
                        return await getMarketplacePerformance(args);
                    }
            }),

    getFulfillmentOverview:
            tool({
                description: "Analyze marketplace performance.",
                inputSchema:z.object({
                    from:z.string(),
                    to:z.string(),
                }),
                execute:
                    async(args)=>{
                        console.log("🔥 getFulfillmentOverview tool");
                        return await getFulfillmentOverview(args);
                    }
            }),

    getMarketplaceFulfillmentPerformance:
            tool({
                description: "Compare fulfillment performance across marketplaces.",
                inputSchema:z.object({
                    from:z.string(),
                    to:z.string(),
                }),
                execute:
                    async(args)=>{
                        console.log("🔥 getMarketplaceFulfillmentPerformance tool");
                        return await getMarketplaceFulfillmentPerformance(args);
                    }
            }),

    getCustomerHealthSummary:
            tool({
                description: "Returns indicators on customer health.",
                inputSchema:z.object({
                    from:z.string(),
                    to:z.string(),
                }),
                execute:
                    async(args)=>{
                        console.log("🔥 getCustomerHealthSummary tool");
                        return await getCustomerHealthSummary(args);
                    }
            }),

};