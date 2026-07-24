CREATE TABLE gold_fact_sale
(
    CustomerId UInt32,

    OrderId UInt64,
    OrderLineId UInt64,

    OrderDate DateTime,

    MarketplaceId Nullable(UInt32),
    MarketplaceName Nullable(String),
    AccountId Nullable(UInt32),

    ItemId Nullable(UInt32),

    SKU Nullable(String),
    ProductName Nullable(String),

    Brand Nullable(String),

    CategoryId Nullable(UInt32),
    CategoryName Nullable(String),

    Currency FixedString(3),

    Quantity Decimal(18,3),

    ProductAmount Decimal(18,2),

    SellerDiscount Decimal(18,2),
    MarketplaceDiscount Decimal(18,2),

    CommissionAmount Decimal(18,2),

    ShippingCost Decimal(18,2),

    VATAmount Decimal(18,2),

    GrossRevenue Decimal(18,2),

    NetRevenue Decimal(18,2),

    ProductCost Nullable(Decimal(18,2)),
    GrossMargin Nullable(Decimal(18,2)),

    IsPaid Bool,
    IsB2B Bool,

    ShippingCountryCode Nullable(FixedString(2)),
    BillingCountryCode Nullable(FixedString(2)),

    InsertedAt DateTime
)
ENGINE = MergeTree
ORDER BY
(
    CustomerId,
    OrderDate,
    OrderId
);