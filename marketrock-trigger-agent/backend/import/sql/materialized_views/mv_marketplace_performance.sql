CREATE MATERIALIZED VIEW mv_marketplace_performance
TO gold_marketplace_performance
AS
SELECT

    CustomerId,

    ifNull(MarketplaceName, '') AS MarketplaceName,

    Currency,

    uniqExact(OrderId) AS OrdersCount,

    sum(GrossRevenue) AS Revenue,

    sum(CommissionAmount) AS Commission,

    sum(ShippingCost) AS ShippingCost,

    sum(NetRevenue) AS NetRevenue

FROM gold_fact_sale

GROUP BY
    CustomerId,
    MarketplaceName,
    Currency;