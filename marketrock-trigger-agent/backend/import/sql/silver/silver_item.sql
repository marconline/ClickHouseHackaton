CREATE TABLE silver_item
(
    CustomerId UInt32,

    ItemId UInt32,

    Disabled Bool,

    SKU Nullable(String),
    ItemName Nullable(String),
    BrandName Nullable(String),
    EAN Nullable(String),

    CategoryId Nullable(UInt32),
    CategoryName Nullable(String),
    CategoryPath Array(UInt32),
    CategoryLevel Nullable(UInt16),

    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    ItemId
);