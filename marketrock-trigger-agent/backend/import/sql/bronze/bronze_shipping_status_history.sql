CREATE TABLE bronze_shipping_status_history
(
    CustomerId UInt32,
	
	ShippingStatusHistoryId UInt64,
    
	ShippingId UInt64,

    StatusId UInt32,

    StatusDate DateTime,

    InsertedAt DateTime,
	
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingId,
    StatusId,
    StatusDate
);