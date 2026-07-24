CREATE TABLE silver_shipping_order
(
    CustomerId UInt32,
    ShippingId UInt64,
    OrderId UInt32,
    IsPrimary Bool,
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY (CustomerId, ShippingId, OrderId);