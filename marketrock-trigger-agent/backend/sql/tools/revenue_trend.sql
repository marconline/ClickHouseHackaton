SELECT

    Date,

    Currency,

    Orders,

    GrossRevenue,

    NetRevenue,

    Quantity


FROM
(
    SELECT

        toDate(OrderDate) AS Date,

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

        Date,

        Currency
)

ORDER BY

    Date