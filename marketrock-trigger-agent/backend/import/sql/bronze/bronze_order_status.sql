CREATE TABLE bronze_order_status
(
    CustomerId UInt32,
    StatusId UInt32,
    StatusName String,
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    StatusId
);