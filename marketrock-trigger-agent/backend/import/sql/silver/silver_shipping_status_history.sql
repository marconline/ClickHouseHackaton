CREATE TABLE silver_shipping_status_history
(
    CustomerId UInt32,

    ShippingId UInt64,

    StatusId Nullable(UInt32),

    StatusName Nullable(String),

    StatusType Enum8
    (
        'INSERTED' = 0,
        'SENT_TO_CARRIER' = 1,
        'CONFIRMED' = 2,
        'CANCELED' = 3,
        'FAILED' = 4,
        'CONSIGNED_TO_CARRIER' = 5,
        'CARRIER_PROCESSING' = 6,
		'IN_TRANSIT' = 7,
		'OUT_FOR_DELIVERY' = 8,
		'MISSED_DELIVERY' = 9,
		'EXCEPTION' = 10,
		'DELIVERED' = 11
    ),

    StatusDate DateTime,

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingId,
    StatusDate
);