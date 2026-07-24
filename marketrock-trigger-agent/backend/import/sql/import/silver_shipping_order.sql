INSERT INTO silver_shipping_order
SELECT
    CustomerId,
    ShippingId,
    OrderId,
    true AS IsPrimary,
    InsertedAt,
    UpdatedAt
FROM silver_shipping
WHERE OrderId IS NOT NULL

UNION ALL

SELECT
    CustomerId,
    ShippingId,
    OrderId,
    false AS IsPrimary,
    InsertedAt,
    UpdatedAt
FROM bronze_shipping_additional_order;