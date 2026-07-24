CREATE TABLE bronze_account
(
    CustomerId UInt32,
    MarketplaceId UInt32,
    AccountId UInt32,
    Name String,
    IsDisabled Bool,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    MarketplaceId,
    AccountId
);