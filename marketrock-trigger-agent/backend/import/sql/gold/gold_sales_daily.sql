CREATE TABLE gold_sales_daily
(
    CustomerId UInt32,

    Date Date,

    Currency FixedString(3),

    MarketplaceId UInt32,
    MarketplaceName String,

    OrdersCount UInt64,
    ItemsCount Decimal(18,3),

    GrossRevenue Decimal(18,2),
    NetRevenue Decimal(18,2),

    SellerDiscount Decimal(18,2),
    MarketplaceDiscount Decimal(18,2),

    CommissionAmount Decimal(18,2),
    ShippingCost Decimal(18,2),

    VATAmount Decimal(18,2),

    ProductCost Decimal(18,2),
    GrossMargin Decimal(18,2),

    PaidOrdersCount UInt64,
    B2BOrdersCount UInt64,

    InsertedAt DateTime
)
ENGINE = SummingMergeTree
ORDER BY
(
    CustomerId,
    Date,
    Currency,
    MarketplaceId
);