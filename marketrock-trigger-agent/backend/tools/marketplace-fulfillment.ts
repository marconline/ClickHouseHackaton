import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export async function getMarketplaceFulfillmentPerformance(
    request: AnalyticsRequest
) {

    const sql = await loadSql(
        "marketplace_fulfillment.sql"
    );


    return executeQuery(
        sql,
        request
    );

}