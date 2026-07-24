SELECT
    ItemId,
    SKU,
    ProductName,

    UnitsSold,
    Revenue,
    NetRevenue,
    Orders

FROM
(
    SELECT

        ItemId,
        SKU,
        ProductName,

        sum(Quantity) AS UnitsSold,

        sum(GrossRevenue) AS Revenue,

        sum(NetRevenue) AS NetRevenue,

        countDistinct(OrderId) AS Orders

    FROM gold_fact_sale

    WHERE
        OrderDate >= {from:DateTime}
        AND OrderDate < {to:DateTime}

    GROUP BY
        ItemId,
        SKU,
        ProductName
)

ORDER BY Revenue DESC

LIMIT {limit:UInt32}