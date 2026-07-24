CREATE TABLE gold_product_performance
(
    CustomerId UInt32,

    ItemId UInt32,

    Currency FixedString(3),

    SKU Nullable(String),

    ProductName Nullable(String),

    Brand Nullable(String),

    CategoryName Nullable(String),

    Quantity Decimal(18,3),

    Revenue Decimal(18,2),

    OrdersCount UInt64
)
ENGINE = SummingMergeTree
ORDER BY
(
    CustomerId,
    ItemId,
    Currency
);