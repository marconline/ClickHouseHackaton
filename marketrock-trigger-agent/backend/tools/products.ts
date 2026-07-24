import { executeQuery } from "./analytics.js";
import { loadSql } from "./sql.js";
import type { AnalyticsRequest } from "./types.js";


export interface TopProductsRequest extends AnalyticsRequest {

    limit?: number;

    orderBy?: "revenue" | "quantity" | "orders";

}


export async function getTopProducts(
    request: TopProductsRequest
) {

    const sql = await loadSql(
        "top_products.sql"
    );


    return executeQuery(
        sql,
        {
            ...request,
            currency: request.currency ?? "",
            limit: request.limit ?? 10,
            orderBy: request.orderBy ?? "revenue"
        }
    );

}