CREATE TABLE bronze_order_fee
(
    CustomerId UInt32,
    OrderId UInt32,
    FeeId UInt32,
    Currency FixedString(3),
    Amount Decimal(18,2),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderId,
    FeeId
);