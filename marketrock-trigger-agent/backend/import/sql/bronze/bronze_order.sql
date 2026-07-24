CREATE TABLE bronze_order
(
    CustomerId UInt32,
    OrderId UInt32,
    OrderGuid UUID,
    MarketplaceId Nullable(UInt32),
	Currency FixedString(3),
    BillingInfoId Nullable(UInt64),
    ShippingInfoId Nullable(UInt64),
    OrderDate DateTime,
    OrderStatusId UInt32,
    IsPaid Bool,
    IsB2B Bool,
	IsCancelled Bool,
    OrderSellerDiscount Decimal(18,2),
    OrderMarketplaceDiscount Decimal(18,2),
    OrderSellerDiscountVAT Decimal(18,2),
    OrderMarketplaceDiscountVAT Decimal(18,2),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderId
);