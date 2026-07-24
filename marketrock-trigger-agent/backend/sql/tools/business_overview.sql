WITH
sales AS
(
    SELECT

        sum(GrossRevenue) revenue,

        countDistinct(OrderId) orders

    FROM gold_fact_sale

    WHERE
        OrderDate >= {from:DateTime}
        AND OrderDate < {to:DateTime}
),

marketplaces AS
(
    SELECT

        MarketplaceName,

        sum(GrossRevenue) revenue

    FROM gold_fact_sale

    WHERE
        OrderDate >= {from:DateTime}
        AND OrderDate < {to:DateTime}

    GROUP BY
        MarketplaceName

)

SELECT *

FROM sales