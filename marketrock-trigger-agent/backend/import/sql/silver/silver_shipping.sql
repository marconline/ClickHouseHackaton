CREATE TABLE silver_shipping
(
    CustomerId UInt32,

    ShippingId UInt64,
    OrderId Nullable(UInt32),

    IsReturnShipping Bool,

    MarketplaceId Nullable(UInt32),
    MarketplaceName Nullable(String),
    AccountId Nullable(UInt32),

    CarrierCost Nullable(Decimal(18,2)),
    Currency Nullable(FixedString(3)),

    ShippingConfigurationId Nullable(UInt32),
    ShippingConfigurationName Nullable(String),
    CarrierName Nullable(String),

    PackageCount Nullable(UInt16),
    TotalWeightKg Nullable(Decimal(18,3)),
    UnknownWeightUnits UInt16,

    CurrentStatusId Nullable(UInt32),

    -- Origin
    OriginCountryCode Nullable(FixedString(2)),
    OriginProvince Nullable(String),
    OriginCity Nullable(String),
    OriginPostalCode Nullable(String),

    -- Destination
    DestinationCountryCode Nullable(FixedString(2)),
    DestinationProvince Nullable(String),
    DestinationCity Nullable(String),
    DestinationPostalCode Nullable(String),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingId
);