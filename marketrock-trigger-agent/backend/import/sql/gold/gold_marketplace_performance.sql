CREATE TABLE gold_marketplace_performance
(
    CustomerId UInt32,

    MarketplaceName String,

    Currency FixedString(3),

    OrdersCount UInt64,

    Revenue Decimal(18,2),

    Commission Decimal(18,2),

    ShippingCost Decimal(18,2),

    NetRevenue Decimal(18,2)
)
ENGINE = SummingMergeTree
ORDER BY
(
    CustomerId,
    MarketplaceName,
    Currency
);