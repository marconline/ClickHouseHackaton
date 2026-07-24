CREATE TABLE bronze_item
(
    CustomerId UInt32,
    ItemId UInt32,
	Disabled Bool,
    SKU Nullable(String),
    ItemName Nullable(String),
    BrandName Nullable(String),
    EAN Nullable(String),
    CategoryId Nullable(UInt32),
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ItemId
);