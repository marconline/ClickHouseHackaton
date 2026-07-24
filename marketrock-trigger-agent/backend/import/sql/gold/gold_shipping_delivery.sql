CREATE TABLE gold_shipping_delivery
(
    CustomerId UInt32,

    ShippingId UInt64,
    OrderId Nullable(UInt32),

    IsReturnShipping Bool,

    CarrierName Nullable(String),

    OriginCountryCode Nullable(FixedString(2)),
    DestinationCountryCode Nullable(FixedString(2)),

    CreatedAt DateTime,

    InTransitAt Nullable(DateTime),
    OutForDeliveryAt Nullable(DateTime),
    DeliveredAt Nullable(DateTime),

    CreatedToTransitHours Nullable(UInt32),
    TransitToOutForDeliveryHours Nullable(UInt32),
    OutForDeliveryToDeliveredHours Nullable(UInt32),
    TotalDeliveryHours Nullable(UInt32),

    CurrentStatus Nullable(String),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingId
);