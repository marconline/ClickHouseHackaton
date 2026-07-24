INSERT INTO gold_fact_sale
WITH order_shipping AS
(
    SELECT
        CustomerId,
        OrderId,
        any(CarrierCost) AS CarrierCost
    FROM silver_shipping
    GROUP BY
        CustomerId,
        OrderId
),

order_amount AS
(
    SELECT
        CustomerId,
        OrderId,
        sum(RowAmount) AS TotalRowAmount
    FROM silver_order_line
    GROUP BY
        CustomerId,
        OrderId
)

SELECT

    l.CustomerId,

    l.OrderId,
    l.OrderLineId,

    l.OrderDate,

    l.MarketplaceId,
    l.MarketplaceName,
    l.AccountId,

    ifNull(l.ItemId, 0) AS ItemId,

    l.SKU,
    l.ProductName,

    i.BrandName,

    i.CategoryId,
    i.CategoryName,

    l.Currency,

    l.Quantity,

    l.ProductAmount,

    l.SellerDiscount,
    l.MarketplaceDiscount,

    l.AllocatedCommissionAmount,

    ifNull(
        s.CarrierCost * l.RowAmount / nullIf(a.TotalRowAmount,0),
        0
    ) AS ShippingCost,

    (
        l.ProductVat
        + l.GiftWrapVat
        + l.SellerDiscountVat
        + l.MarketplaceDiscountVat
    ) AS VATAmount,

    l.RowAmount AS GrossRevenue,

    (
        l.RowAmount
        - l.AllocatedCommissionAmount
        - ifNull(
            s.CarrierCost * l.RowAmount / nullIf(a.TotalRowAmount,0),
            0
        )
    ) AS NetRevenue,

    NULL,
    NULL,

    l.IsPaid,
    l.IsB2B,

    l.ShippingCountryCode,

    o.BillingCountryCode,

    now()

FROM silver_order_line l

LEFT JOIN silver_item i
    ON l.CustomerId = i.CustomerId
    AND l.ItemId = i.ItemId

LEFT JOIN order_shipping s
    ON l.CustomerId = s.CustomerId
    AND l.OrderId = s.OrderId

LEFT JOIN order_amount a
    ON l.CustomerId = a.CustomerId
    AND l.OrderId = a.OrderId

LEFT JOIN silver_order o
    ON l.CustomerId = o.CustomerId
    AND l.OrderId = o.OrderId

WHERE o.IsCancelled = 0;