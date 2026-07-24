CREATE TABLE bronze_shipping_additional_order
(
    CustomerId UInt32,
    ShippingId UInt64,
    OrderId UInt32,
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY (CustomerId, ShippingId, OrderId);