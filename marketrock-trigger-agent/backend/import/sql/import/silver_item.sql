INSERT INTO silver_item
SELECT

    i.CustomerId,

    i.ItemId,

    i.Disabled,

    i.SKU,
    i.ItemName,
    i.BrandName,
    i.EAN,

    i.CategoryId,

    c.CategoryName,
    c.CategoryPath,
    c.Level,

    i.InsertedAt,
    i.UpdatedAt

FROM bronze_item i

LEFT JOIN bronze_category c
    ON i.CustomerId = c.CustomerId
    AND i.CategoryId = c.CategoryId;