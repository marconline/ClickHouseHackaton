CREATE TABLE bronze_order_billing_info
(
    CustomerId UInt32,

    OrderId UInt32,

    BillingInfoId UInt32,

    -- Indirizzo fatturazione
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
    OrderId
);