import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export async function getMarketplacePerformance(
    request: AnalyticsRequest
) {

    const sql = await loadSql(
        "marketplace_performance.sql"
    );


    return executeQuery(
        sql,
        {
            ...request,
            currency: request.currency ?? ""
        }
    );

}