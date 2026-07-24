SELECT

    SKU,

    ProductName,

    Brand,

    CategoryName,

    Currency,

    Orders,

    Quantity,

    Revenue


FROM
(
    SELECT

        SKU,

        any(ProductName) AS ProductName,

        any(Brand) AS Brand,

        any(CategoryName) AS CategoryName,

        Currency,

        countDistinct(OrderId) AS Orders,

        sum(Quantity) AS Quantity,

        sum(GrossRevenue) AS Revenue


    FROM gold_fact_sale


    WHERE

        OrderDate >= {from:DateTime}

    AND

        OrderDate < {to:DateTime}

    AND
    (
        {currency:String} = ''

        OR

        Currency = {currency:String}
    )


    GROUP BY

        SKU,

        Currency
)


ORDER BY

    CASE

        WHEN {orderBy:String} = 'quantity'
            THEN Quantity

        WHEN {orderBy:String} = 'orders'
            THEN Orders

        ELSE Revenue

    END DESC


LIMIT {limit:UInt32}