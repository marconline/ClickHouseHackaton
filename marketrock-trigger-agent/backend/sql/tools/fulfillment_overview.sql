SELECT

    FulfillmentStatus,

    Orders,

    AvgPreparationHours,

    DeliveredShipments,

    ShippingAttempts


FROM
(
    SELECT

        FulfillmentStatus,

        countDistinct(OrderId) AS Orders,

        avgIf(
            PreparationHours,
            PreparationHours IS NOT NULL
        ) AS AvgPreparationHours,

        sum(DeliveredShipments) AS DeliveredShipments,

        sum(ShippingAttempts) AS ShippingAttempts


    FROM gold_order_fulfillment


    WHERE

        OrderDate >= {from:DateTime}

    AND

        OrderDate < {to:DateTime}


    GROUP BY

        FulfillmentStatus
)

ORDER BY

    Orders DESC