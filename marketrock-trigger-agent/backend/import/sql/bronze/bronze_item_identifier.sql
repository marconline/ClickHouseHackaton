CREATE TABLE bronze_item_identifier
(
    CustomerId UInt32,
    ItemProductIdentifierId UInt64,
    ItemId UInt32,
    IdentifierType String,
    IdentifierValue String,
    MarketplaceId Nullable(UInt32),
    MarketplaceCountry Nullable(String),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ItemProductIdentifierId
);