import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export async function getRevenueTrend(
    request: AnalyticsRequest
) {

    const sql = await loadSql(
        "revenue_trend.sql"
    );


    return executeQuery(
        sql,
        {
            ...request,
            currency: request.currency ?? ""
        }
    );

}