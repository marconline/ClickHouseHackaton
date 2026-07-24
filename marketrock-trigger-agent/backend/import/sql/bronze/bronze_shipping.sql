CREATE TABLE bronze_shipping
(
    CustomerId UInt32,
    ShippingId UInt64,
    OrderId Nullable(UInt32),
    IsReturnShipping Bool,
    ShippingConfigurationId Nullable(UInt32),
    ShippingConfigurationName Nullable(String),
    CarrierName Nullable(String),
    CarrierCost Nullable(Decimal(18,2)),
    Currency Nullable(FixedString(3)),
    CurrentStatusId Nullable(UInt32),
    PackageCount Nullable(UInt16),
    TotalWeightKg Nullable(Decimal(18,3)),
    UnknownWeightUnits UInt16,
	AddressFromId Nullable(UInt64),
	AddressToId Nullable(UInt64),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingId
);