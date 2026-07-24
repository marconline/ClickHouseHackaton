SELECT

    MarketplaceId,

    MarketplaceName,

    Currency,

    Orders,

    Quantity,

    Revenue,

    NetRevenue,

    AverageOrderValue,

    Revenue / TotalRevenue AS RevenueShare


FROM
(
    SELECT

        MarketplaceId,

        MarketplaceName,

        Currency,

        Orders,

        Quantity,

        Revenue,

        NetRevenue,

        AverageOrderValue,

        sum(Revenue) OVER () AS TotalRevenue


    FROM
    (
        SELECT

            MarketplaceId,

            MarketplaceName,

            Currency,

            countDistinct(OrderId) AS Orders,

            sum(Quantity) AS Quantity,

            sum(GrossRevenue) AS Revenue,

            sum(NetRevenue) AS NetRevenue,

            sum(GrossRevenue)
                /
            countDistinct(OrderId)
                AS AverageOrderValue


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

            MarketplaceId,

            MarketplaceName,

            Currency
    )
)

ORDER BY

    Revenue DESC