CREATE MATERIALIZED VIEW mv_sales_daily
TO gold_sales_daily
AS
SELECT
    CustomerId,

    toDate(OrderDate) AS Date,

    Currency,

    ifNull(MarketplaceId, 0) AS MarketplaceId,

    ifNull(MarketplaceName, '') AS MarketplaceName,

    uniqExact(OrderId) AS OrdersCount,

    sum(Quantity) AS ItemsCount,

    sum(GrossRevenue) AS GrossRevenue,

    sum(NetRevenue) AS NetRevenue,

    sum(SellerDiscount) AS SellerDiscount,

    sum(MarketplaceDiscount) AS MarketplaceDiscount,

    sum(CommissionAmount) AS CommissionAmount,

    sum(ShippingCost) AS ShippingCost,

    sum(VATAmount) AS VATAmount,

    sum(ifNull(ProductCost, 0)) AS ProductCost,

    sum(ifNull(GrossMargin, 0)) AS GrossMargin,

    uniqExactIf(OrderId, IsPaid) AS PaidOrdersCount,

    uniqExactIf(OrderId, IsB2B) AS B2BOrdersCount,

    now() AS InsertedAt

FROM gold_fact_sale

GROUP BY
    CustomerId,
    Date,
    Currency,
    MarketplaceId,
    MarketplaceName;