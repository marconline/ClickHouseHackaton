CREATE TABLE bronze_marketplace
(
    CustomerId UInt32,
    MarketplaceId UInt32,
    Name String,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    MarketplaceId
);