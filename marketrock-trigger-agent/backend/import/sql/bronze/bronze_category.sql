CREATE TABLE bronze_category
(
    CustomerId UInt32,
    CategoryId UInt32,
    ParentCategoryId Nullable(UInt32),
    CategoryName String,
	CategoryPath Array(UInt32),
	Level UInt16,
    InsertedAt DateTime,
    UpdatedAt DateTime
)
ENGINE = ReplacingMergeTree(UpdatedAt)
ORDER BY
(
    CustomerId,
    CategoryId
);