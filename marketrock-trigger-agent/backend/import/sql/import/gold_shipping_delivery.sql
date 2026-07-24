INSERT INTO gold_shipping_delivery
(
    CustomerId,
    ShippingId,
    OrderId,
    IsReturnShipping,
    CarrierName,
    OriginCountryCode,
    DestinationCountryCode,
    CreatedAt,
    InTransitAt,
    OutForDeliveryAt,
    DeliveredAt,
    CreatedToTransitHours,
    TransitToOutForDeliveryHours,
    OutForDeliveryToDeliveredHours,
    TotalDeliveryHours,
    CurrentStatus,
    InsertedAt,
    UpdatedAt
)
WITH shipping_events AS
(
    SELECT

        s.CustomerId,
        s.ShippingId,
        s.OrderId,
        s.IsReturnShipping,
        s.CarrierName,

        s.OriginCountryCode,
        s.DestinationCountryCode,

        s.InsertedAt AS CreatedAt,

        NULLIF(
            minIf(
                h.StatusDate,
                h.StatusType = 'IN_TRANSIT'
            ),
            toDateTime('1970-01-01 00:00:00')
        ) AS InTransitAt,

        NULLIF(
            minIf(
                h.StatusDate,
                h.StatusType = 'OUT_FOR_DELIVERY'
            ),
            toDateTime('1970-01-01 00:00:00')
        ) AS OutForDeliveryAt,

        NULLIF(
            minIf(
                h.StatusDate,
                h.StatusType = 'DELIVERED'
            ),
            toDateTime('1970-01-01 00:00:00')
        ) AS DeliveredAt,

        argMax(
            toString(h.StatusType),
            h.StatusDate
        ) AS CurrentStatus

    FROM silver_shipping s

    LEFT JOIN silver_shipping_status_history h
        ON s.CustomerId = h.CustomerId
        AND s.ShippingId = h.ShippingId

    GROUP BY

        s.CustomerId,
        s.ShippingId,
        s.OrderId,
        s.IsReturnShipping,
        s.CarrierName,
        s.OriginCountryCode,
        s.DestinationCountryCode,
        s.InsertedAt
)

SELECT

    CustomerId,
    ShippingId,
    OrderId,
    IsReturnShipping,
    CarrierName,

    OriginCountryCode,
    DestinationCountryCode,

    CreatedAt,

    InTransitAt,
    OutForDeliveryAt,
    DeliveredAt,


    if(
        InTransitAt IS NULL,
        NULL,
        dateDiff(
            'hour',
            CreatedAt,
            InTransitAt
        )
    ) AS CreatedToTransitHours,


    if(
        InTransitAt IS NULL
        OR OutForDeliveryAt IS NULL,
        NULL,
        dateDiff(
            'hour',
            InTransitAt,
            OutForDeliveryAt
        )
    ) AS TransitToOutForDeliveryHours,


    if(
        OutForDeliveryAt IS NULL
        OR DeliveredAt IS NULL,
        NULL,
        dateDiff(
            'hour',
            OutForDeliveryAt,
            DeliveredAt
        )
    ) AS OutForDeliveryToDeliveredHours,


    if(
        DeliveredAt IS NULL,
        NULL,
        dateDiff(
            'hour',
            CreatedAt,
            DeliveredAt
        )
    ) AS TotalDeliveryHours,


    CurrentStatus,

    now() AS InsertedAt,
    now() AS UpdatedAt

FROM shipping_events;