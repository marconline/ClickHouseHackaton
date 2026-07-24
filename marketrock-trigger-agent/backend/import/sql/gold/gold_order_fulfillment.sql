CREATE TABLE gold_order_fulfillment
(
    CustomerId UInt32,

    OrderId UInt64,

    OrderDate DateTime,

    MarketplaceId UInt32,
    MarketplaceName String,

    ShippingAttempts UInt32,

    ValidShippingCount UInt32,

    FirstShippingDate Nullable(DateTime),

    PreparationHours Nullable(Float64),

    DeliveredShipments UInt32,

    FulfillmentStatus Enum8
    (
        'WAITING_FULFILLMENT' = 0,
        'IN_PROGRESS' = 1,
        'DELIVERED' = 2
    ),

    InsertedAt DateTime
)
ENGINE = ReplacingMergeTree(InsertedAt)
ORDER BY
(
    CustomerId,
    OrderDate,
    OrderId
);