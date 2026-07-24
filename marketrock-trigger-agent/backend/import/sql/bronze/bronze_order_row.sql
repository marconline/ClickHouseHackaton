CREATE TABLE bronze_order_row
(
    CustomerId UInt32,

    OrderId UInt32,
    OrderLineId UInt32,

    -- Riferimento articolo MarketRock (può essere NULL)
    ItemId Nullable(UInt32),

    -- Categoria al momento della vendita
    CategoryId Nullable(UInt32),

    -- Snapshot prodotto analitico
    ProductSKU Nullable(String),
    ProductName Nullable(String),

    -- Snapshot marketplace originale
    MarketplaceSKU Nullable(String),
    MarketplaceProductId Nullable(String),
    MarketplaceProductName Nullable(String),

    -- Valori riga
    Quantity Decimal(18,3),
    UnitPrice Decimal(18,2),

    -- Sconti riga
    SellerDiscount Decimal(18,2),
    MarketplaceDiscount Decimal(18,2),

    -- Gift wrap
    GiftWrapValue Decimal(18,2),
    GiftWrapDiscount Decimal(18,2),

    -- Totale netto riga
    RowAmount Decimal(18,2),

    -- IVA
    ProductVAT Decimal(18,2),
    GiftWrapVAT Decimal(18,2),
    GiftWrapDiscountVAT Decimal(18,2),
    SellerDiscountVAT Decimal(18,2),
    MarketplaceDiscountVAT Decimal(18,2),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderId,
    OrderLineId
);