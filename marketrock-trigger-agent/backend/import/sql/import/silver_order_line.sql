INSERT INTO silver_order_line
WITH

OrderLineTotals AS
(
    SELECT
        CustomerId,
        OrderId,
        sum(RowAmount) AS OrderProductAmount
    FROM bronze_order_row
    GROUP BY
        CustomerId,
        OrderId
),

OrderFees AS
(
    SELECT
        CustomerId,
        OrderId,
        sum(Amount) AS TotalCommissionAmount,
        any(Currency) AS CommissionCurrency
    FROM bronze_order_fee
    GROUP BY
        CustomerId,
        OrderId
),

OrderAllocation AS
(
    SELECT
        r.CustomerId,
        r.OrderId,
        r.OrderLineId,

        if(
            t.OrderProductAmount = 0,
            0,
            r.RowAmount / t.OrderProductAmount
        ) AS AllocationFactor

    FROM bronze_order_row r

    INNER JOIN OrderLineTotals t
        ON r.CustomerId = t.CustomerId
        AND r.OrderId = t.OrderId
)

SELECT

    r.CustomerId,

    r.OrderId,
    r.OrderLineId,

    -- Marketplace
    o.MarketplaceId,
    mp.Name AS MarketplaceName,

    link.AccountId,

    -- Product
    r.ItemId,
    r.ProductSKU,
    r.ProductName,

    item.EAN,
    item.BrandName AS Brand,

    r.CategoryId,
    cat.CategoryName,

    -- Order
    o.OrderDate,
	o.IsCancelled,
    o.OrderStatusId,
    st.StatusName,

    o.IsPaid,
    o.IsB2B,

    o.Currency,

    -- Shipping address
    ship.CountryCode,
    ship.Province,
    ship.City,
    ship.PostalCode,

    -- Line values
    r.Quantity,

    r.UnitPrice AS UnitPrice,

    r.Quantity * r.UnitPrice AS ProductAmount,

    r.SellerDiscount,
    r.MarketplaceDiscount,

    r.GiftWrapValue,
    r.GiftWrapDiscount,

    r.RowAmount,

    -- VAT
    r.ProductVAT,
    r.GiftWrapVAT,

    r.SellerDiscountVAT,
    r.MarketplaceDiscountVAT,

    -- Order totals
    totals.OrderProductAmount,

    o.OrderSellerDiscount
        * alloc.AllocationFactor
        AS AllocatedOrderSellerDiscount,

    o.OrderMarketplaceDiscount
        * alloc.AllocationFactor
        AS AllocatedOrderMarketplaceDiscount,

	o.OrderSellerDiscountVAT
		* alloc.AllocationFactor
		AS AllocatedOrderSellerDiscountVAT,

	o.OrderMarketplaceDiscountVAT
		* alloc.AllocationFactor
		AS AllocatedOrderMarketplaceDiscountVAT,

    -- Commission allocation
    ifNull(fee.TotalCommissionAmount, 0)
        * alloc.AllocationFactor
        AS AllocatedCommissionAmount,

    fee.CommissionCurrency,

    -- Order total
    totals.OrderProductAmount
        + ifNull(ship.ShippingCost, 0)
        - ifNull(ship.ShippingDiscount, 0)
        - ifNull(o.OrderSellerDiscount, 0)
        - ifNull(o.OrderMarketplaceDiscount, 0)
        AS OrderGrandTotalAmount,

    now(),
    now()

FROM bronze_order_row r

INNER JOIN bronze_order o
    ON r.CustomerId = o.CustomerId
    AND r.OrderId = o.OrderId

INNER JOIN OrderLineTotals totals
    ON r.CustomerId = totals.CustomerId
    AND r.OrderId = totals.OrderId

INNER JOIN OrderAllocation alloc
    ON r.CustomerId = alloc.CustomerId
    AND r.OrderId = alloc.OrderId
    AND r.OrderLineId = alloc.OrderLineId

LEFT JOIN bronze_order_shipping_info ship
    ON o.CustomerId = ship.CustomerId
    AND o.OrderId = ship.OrderId

LEFT JOIN OrderFees fee
    ON o.CustomerId = fee.CustomerId
    AND o.OrderId = fee.OrderId

LEFT JOIN bronze_marketplace_order_link link
    ON o.CustomerId = link.CustomerId
    AND o.OrderId = link.OrderId

LEFT JOIN bronze_marketplace mp
    ON o.CustomerId = mp.CustomerId
    AND o.MarketplaceId = mp.MarketplaceId

LEFT JOIN bronze_item item
    ON r.CustomerId = item.CustomerId
    AND r.ItemId = item.ItemId

LEFT JOIN bronze_category cat
    ON r.CustomerId = cat.CustomerId
    AND r.CategoryId = cat.CategoryId

LEFT JOIN bronze_order_status st
    ON o.CustomerId = st.CustomerId
    AND o.OrderStatusId = st.StatusId;