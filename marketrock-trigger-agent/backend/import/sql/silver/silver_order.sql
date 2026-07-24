CREATE TABLE silver_order
(
    CustomerId UInt32,

    OrderId UInt64,

    OrderDate DateTime,

    -- Marketplace / Account
    MarketplaceId Nullable(UInt32),
    MarketplaceName String,

    AccountId Nullable(UInt32),

    -- Stato ordine
    OrderStatusId UInt32,
    OrderStatusName Nullable(String),

    IsPaid Bool,
    IsB2B Bool,
	IsCancelled Bool,

    Currency FixedString(3),

    -- Billing
    BillingCountryCode Nullable(FixedString(2)),
    BillingProvince Nullable(String),
    BillingCity Nullable(String),
    BillingPostalCode Nullable(String),

    -- Shipping
    ShippingCountryCode Nullable(FixedString(2)),
    ShippingProvince Nullable(String),
    ShippingCity Nullable(String),
    ShippingPostalCode Nullable(String),

    -- Quantità
    LinesCount UInt32,
    ItemsCount Decimal(18,3),

    -- Valori prodotto
    ProductAmount Decimal(18,2),

    -- Shipping
    ShippingCost Decimal(18,2),
    ShippingDiscount Decimal(18,2),
    ShippingVAT Decimal(18,2),
    ShippingDiscountVAT Decimal(18,2),

    -- Sconti ordine
    OrderSellerDiscount Decimal(18,2),
    OrderMarketplaceDiscount Decimal(18,2),

    OrderSellerDiscountVAT Decimal(18,2),
    OrderMarketplaceDiscountVAT Decimal(18,2),

    -- Commissioni
    CommissionAmount Decimal(18,2),
    CommissionCurrency Nullable(FixedString(3)),

    -- Totale ordine
    OrderGrandTotalAmount Decimal(18,2),
    CalculatedOrderGrandTotalAmount Decimal(18,2),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderDate,
    OrderId
);