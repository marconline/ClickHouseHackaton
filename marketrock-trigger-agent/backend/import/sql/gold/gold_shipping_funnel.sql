CREATE TABLE gold_shipping_funnel
(
    CustomerId UInt32,

    Week Date,

    DestinationCountryCode FixedString(2),

    Shipments UInt64,

    AvgCreatedToTransitHours Nullable(Float64),
    AvgTransitToOutForDeliveryHours Nullable(Float64),
    AvgOutForDeliveryToDeliveredHours Nullable(Float64),
    AvgTotalDeliveryHours Nullable(Float64),

    InsertedAt DateTime
)
ENGINE = SummingMergeTree
ORDER BY
(
    CustomerId,
    Week,
    DestinationCountryCode
);