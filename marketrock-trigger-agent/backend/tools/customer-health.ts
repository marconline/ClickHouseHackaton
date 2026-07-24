import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export async function getCustomerHealthSummary(
    request: AnalyticsRequest
) {

    const sql = await loadSql(
        "customer_health.sql"
    );


    return executeQuery(
        sql,
        {
            ...request,
            currency: request.currency ?? ""
        }
    );

}