CREATE MATERIALIZED VIEW mv_product_performance
TO gold_product_performance
AS
SELECT

    CustomerId,

    ItemId,

    Currency,

    any(SKU) AS SKU,

    any(ProductName) AS ProductName,

    any(Brand) AS Brand,

    any(CategoryName) AS CategoryName,

    sum(Quantity) AS Quantity,

    sum(GrossRevenue) AS Revenue,

    uniqExact(OrderId) AS OrdersCount

FROM gold_fact_sale

GROUP BY
    CustomerId,
    ItemId,
    Currency;