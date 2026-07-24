CREATE TABLE bronze_order_shipping_info
(
    CustomerId UInt32,

    OrderId UInt32,

    ShippingInfoId UInt32,

    -- Valori addebitati al cliente
    ShippingCost Decimal(18,2),
    ShippingDiscount Decimal(18,2),

    -- IVA
    ShippingVAT Decimal(18,2),
    ShippingDiscountVAT Decimal(18,2),

    -- Indirizzo destinazione
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