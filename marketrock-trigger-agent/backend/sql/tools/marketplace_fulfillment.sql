SELECT

    MarketplaceId,

    MarketplaceName,

    Orders,

    WaitingOrders,

    InProgressOrders,

    DeliveredOrders,

    AvgPreparationHours,

    DeliveryRate


FROM
(
    SELECT

        MarketplaceId,

        MarketplaceName,

        countDistinct(OrderId) AS Orders,


        countDistinctIf(
            OrderId,
            FulfillmentStatus = 'WAITING_FULFILLMENT'
        ) AS WaitingOrders,


        countDistinctIf(
            OrderId,
            FulfillmentStatus = 'IN_PROGRESS'
        ) AS InProgressOrders,


        countDistinctIf(
            OrderId,
            FulfillmentStatus = 'DELIVERED'
        ) AS DeliveredOrders,


        avgIf(
            PreparationHours,
            PreparationHours IS NOT NULL
        ) AS AvgPreparationHours,


        DeliveredOrders / Orders AS DeliveryRate


    FROM gold_order_fulfillment


    WHERE

        OrderDate >= {from:DateTime}

    AND

        OrderDate < {to:DateTime}


    GROUP BY

        MarketplaceId,

        MarketplaceName
)


ORDER BY

    AvgPreparationHours DESC