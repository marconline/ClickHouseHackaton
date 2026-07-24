CREATE TABLE bronze_marketplace_order_link
(
    CustomerId UInt32,

    OrderId UInt32,

    MarketplaceId UInt32,

    AccountId Nullable(UInt32),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    OrderId
);