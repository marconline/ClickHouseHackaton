CREATE TABLE gold_shipping_bottleneck_geo
(
    CustomerId UInt32,

    Date Date,

    CountryCode FixedString(2),

    PostalCode String,

    CarrierName String,

    Shipments UInt64,

    AverageDeliveryHours Decimal(18,2),

    LateShipments UInt64
)
ENGINE = SummingMergeTree
ORDER BY
(
    CustomerId,
    Date,
    CountryCode,
    PostalCode,
    CarrierName
);