CREATE TABLE silver_order_line
(
    CustomerId UInt32,

    -- Chiavi
    OrderId UInt64,
    OrderLineId UInt64,

    -- Marketplace / account
    MarketplaceId Nullable(UInt32),
    MarketplaceName String,

    AccountId Nullable(UInt32),

    -- Prodotto
    ItemId Nullable(UInt64),

    SKU Nullable(String),
    ProductName Nullable(String),

    EAN Nullable(String),
    Brand Nullable(String),

    CategoryId Nullable(UInt64),
    CategoryName Nullable(String),

    -- Ordine
    OrderDate DateTime,
	IsCancelled Bool,
    OrderStatusId UInt32,
    OrderStatusName Nullable(String),

    IsPaid Bool,
    IsB2B Bool,

    Currency FixedString(3),

    -- Destinazione spedizione
    ShippingCountryCode Nullable(FixedString(2)),
    ShippingProvince Nullable(String),
    ShippingCity Nullable(String),
    ShippingPostalCode Nullable(String),

    -- Valori riga
    Quantity Decimal(18,3),

    UnitPrice Decimal(18,2),

    ProductAmount Decimal(18,2),

    SellerDiscount Decimal(18,2),
    MarketplaceDiscount Decimal(18,2),

    GiftWrapValue Decimal(18,2),
    GiftWrapDiscount Decimal(18,2),

    RowAmount Decimal(18,2),

    -- IVA riga
    ProductVat Decimal(18,2),
    GiftWrapVat Decimal(18,2),

    SellerDiscountVat Decimal(18,2),
    MarketplaceDiscountVat Decimal(18,2),

    -- Totale ordine prodotto
    OrderProductAmount Decimal(18,2),

    -- Sconti ordine allocati
    AllocatedOrderSellerDiscount Decimal(18,2),
    AllocatedOrderMarketplaceDiscount Decimal(18,2),

    AllocatedOrderSellerDiscountVAT Decimal(18,2),
    AllocatedOrderMarketplaceDiscountVAT Decimal(18,2),

    -- Commissione allocata
    AllocatedCommissionAmount Decimal(18,2),
    CommissionCurrency Nullable(FixedString(3)),

    -- Totale ordine
    OrderGrandTotalAmount Decimal(18,2),

    -- Audit
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderDate,
    OrderId,
    OrderLineId
);