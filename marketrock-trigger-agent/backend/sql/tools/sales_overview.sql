SELECT

    Currency,

    Orders,

    GrossRevenue,

    NetRevenue,

    Quantity,

    GrossRevenue / Orders AS AverageOrderValue,

    Quantity / Orders AS AverageItemsPerOrder


FROM
(
    SELECT

        Currency,

        countDistinct(OrderId) AS Orders,

        sum(GrossRevenue) AS GrossRevenue,

        sum(NetRevenue) AS NetRevenue,

        sum(Quantity) AS Quantity


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

        Currency
)