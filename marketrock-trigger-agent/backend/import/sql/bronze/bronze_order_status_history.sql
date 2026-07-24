CREATE TABLE bronze_order_status_history
(
    CustomerId UInt32,
    OrderId UInt32,
    StatusId UInt32,
    StatusDate DateTime,
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
	CustomerId,
    OrderId,
    StatusDate,
    StatusId
);