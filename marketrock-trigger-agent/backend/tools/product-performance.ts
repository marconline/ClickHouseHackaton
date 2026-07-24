import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";

export interface ProductPerformanceRequest extends AnalyticsRequest {

    limit?: number;

}



export async function getProductPerformance(
    request: ProductPerformanceRequest
) {

    const sql = await loadSql(
            "product_performance.sql"
        );
    
    
        return executeQuery(
            sql,
            request
        );

}