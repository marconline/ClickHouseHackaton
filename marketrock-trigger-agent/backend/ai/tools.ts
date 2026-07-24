import { getSalesOverview } from "../tools/sales.js";
import { getRevenueTrend } from "../tools/revenue.js";
import { getTopProducts } from "../tools/products.js";
import { getMarketplacePerformance } from "../tools/marketplace.js";
import { getFulfillmentOverview } from "../tools/fulfillment.js";
import { getMarketplaceFulfillmentPerformance } 
    from "../tools/marketplace-fulfillment.js";
import { getCustomerHealthSummary }
    from "../tools/customer-health.js";


export const tools = {

    getSalesOverview,

    getRevenueTrend,

    getTopProducts,

    getMarketplacePerformance,

    getFulfillmentOverview,

    getMarketplaceFulfillmentPerformance,

    getCustomerHealthSummary

};