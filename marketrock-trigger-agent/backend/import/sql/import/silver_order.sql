INSERT INTO silver_order
SELECT

    l.CustomerId,

    l.OrderId,

    any(l.OrderDate),

    -- Marketplace
    any(l.MarketplaceId),
    any(l.MarketplaceName),

    any(l.AccountId),

    -- Status
    any(l.OrderStatusId),
    any(l.OrderStatusName),

    any(l.IsPaid),
    any(l.IsB2B),
	any(l.IsCancelled),

    any(l.Currency),

    -- Billing
    any(b.CountryCode),
    any(b.Province),
    any(b.City),
    any(b.PostalCode),

    -- Shipping
    any(l.ShippingCountryCode),
    any(l.ShippingProvince),
    any(l.ShippingCity),
    any(l.ShippingPostalCode),

    -- Quantità
    count() AS LinesCount,

    sum(l.Quantity) AS ItemsCount,

    -- Product
    sum(l.RowAmount) AS ProductAmount,

    -- Shipping
    any(s.ShippingCost),

    any(s.ShippingDiscount),

    any(s.ShippingVAT),

    any(s.ShippingDiscountVAT),

    -- Order discounts
    sum(l.AllocatedOrderSellerDiscount)
        AS OrderSellerDiscount,

    sum(l.AllocatedOrderMarketplaceDiscount)
        AS OrderMarketplaceDiscount,

    sum(l.AllocatedOrderSellerDiscountVAT)
        AS OrderSellerDiscountVAT,

    sum(l.AllocatedOrderMarketplaceDiscountVAT)
        AS OrderMarketplaceDiscountVAT,

    -- Commission
    sum(l.AllocatedCommissionAmount)
        AS CommissionAmount,

    any(l.CommissionCurrency),

    -- Original total
    any(l.OrderGrandTotalAmount)
        AS OrderGrandTotalAmount,

    -- Recalculated total
    (
        sum(l.RowAmount)
        + any(s.ShippingCost)
        - any(s.ShippingDiscount)
        - sum(l.AllocatedOrderSellerDiscount)
        - sum(l.AllocatedOrderMarketplaceDiscount)
    )
        AS CalculatedOrderGrandTotalAmount,

    now(),
    now()

FROM silver_order_line l

LEFT JOIN bronze_order_billing_info b
    ON l.CustomerId = b.CustomerId
    AND l.OrderId = b.OrderId
	
LEFT JOIN bronze_order_shipping_info s
    ON l.CustomerId = s.CustomerId
    AND l.OrderId = s.OrderId

GROUP BY
    l.CustomerId,
    l.OrderId;