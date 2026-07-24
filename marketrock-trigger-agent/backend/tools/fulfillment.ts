import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export async function getFulfillmentOverview(
    request: AnalyticsRequest
) {

    const sql = await loadSql(
        "fulfillment_overview.sql"
    );


    return executeQuery(
        sql,
        request
    );

}