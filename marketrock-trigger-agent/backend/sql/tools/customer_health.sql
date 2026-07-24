SELECT

    Currency,

    TotalOrders,

    TotalRevenue,

    AverageOrderValue,

    DeliveredOrders,

    PendingOrders,

    DeliveryRate,

    AvgPreparationHours,

    MarketplaceCount


FROM
(
    SELECT

        Currency,


        countDistinct(OrderId) AS TotalOrders,


        sum(GrossRevenue) AS TotalRevenue,


        sum(GrossRevenue)
            /
        countDistinct(OrderId)
            AS AverageOrderValue,


        countDistinctIf(
            OrderId,
            FulfillmentStatus = 'DELIVERED'
        ) AS DeliveredOrders,


        countDistinctIf(
            OrderId,
            FulfillmentStatus != 'DELIVERED'
        ) AS PendingOrders,


        DeliveredOrders / TotalOrders
            AS DeliveryRate,


        avgIf(
            PreparationHours,
            PreparationHours IS NOT NULL
        ) AS AvgPreparationHours,


        countDistinct(MarketplaceId)
            AS MarketplaceCount


    FROM gold_fact_sale AS f


    LEFT JOIN gold_order_fulfillment AS o

    ON

        f.CustomerId = o.CustomerId

    AND

        f.OrderId = o.OrderId


    WHERE

        f.OrderDate >= {from:DateTime}

    AND

        f.OrderDate < {to:DateTime}

    AND
    (
        {currency:String} = ''

        OR

        f.Currency = {currency:String}
    )


    GROUP BY

        Currency
)