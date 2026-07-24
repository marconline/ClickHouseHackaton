INSERT INTO silver_shipping_status_history
(
    CustomerId,
    ShippingId,
    StatusId,
    StatusName,
    StatusType,
    StatusDate,
    InsertedAt,
    UpdatedAt
)
SELECT

    CustomerId,

    ShippingId,

    StatusId,

    multiIf(
        StatusId = 0,  'INSERTED',
        StatusId = 1,  'SENT_TO_CARRIER',
        StatusId = 2,  'CONFIRMED',
        StatusId = 3,  'CANCELED',
        StatusId = 4,  'FAILED',
        StatusId = 5,  'CONSIGNED_TO_CARRIER',
        StatusId = 6,  'CARRIER_PROCESSING',
        StatusId = 7,  'IN_TRANSIT',
        StatusId = 8,  'OUT_FOR_DELIVERY',
        StatusId = 9,  'MISSED_DELIVERY',
        StatusId = 10, 'EXCEPTION',
        StatusId = 11, 'DELIVERED',
        'INSERTED'
    ) AS StatusName,

    multiIf(
        StatusId = 0,  'INSERTED',
        StatusId = 1,  'SENT_TO_CARRIER',
        StatusId = 2,  'CONFIRMED',
        StatusId = 3,  'CANCELED',
        StatusId = 4,  'FAILED',
        StatusId = 5,  'CONSIGNED_TO_CARRIER',
        StatusId = 6,  'CARRIER_PROCESSING',
        StatusId = 7,  'IN_TRANSIT',
        StatusId = 8,  'OUT_FOR_DELIVERY',
        StatusId = 9,  'MISSED_DELIVERY',
        StatusId = 10, 'EXCEPTION',
        StatusId = 11, 'DELIVERED',
        'INSERTED'
    ) AS StatusType,

    StatusDate,

    InsertedAt,

    UpdatedAt

FROM bronze_shipping_status_history;