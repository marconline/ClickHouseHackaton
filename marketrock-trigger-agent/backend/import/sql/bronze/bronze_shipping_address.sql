CREATE TABLE bronze_shipping_address
(
	ShippingAddressId UInt64,
    CustomerId UInt32,
    CountryCode Nullable(FixedString(2)),
    Province Nullable(String),
    City Nullable(String),
    PostalCode Nullable(String),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ShippingAddressId
);