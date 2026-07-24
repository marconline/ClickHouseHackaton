INSERT INTO gold_order_fulfillment
SELECT
    o.CustomerId,

    o.OrderId,

    o.OrderDate,

    ifNull(o.MarketplaceId, 0) AS MarketplaceId,

    o.MarketplaceName,

    ifNull(s.ShippingAttempts, 0) AS ShippingAttempts,

    ifNull(s.ValidShippingCount, 0) AS ValidShippingCount,

    s.FirstShippingDate,

    if(
        s.FirstShippingDate IS NULL,
        NULL,
        dateDiff(
            'hour',
            o.OrderDate,
            s.FirstShippingDate
        )
    ) AS PreparationHours,

    ifNull(d.DeliveredShipments, 0) AS DeliveredShipments,

    multiIf(
        ifNull(s.ValidShippingCount, 0) = 0,
        'WAITING_FULFILLMENT',

        ifNull(d.DeliveredShipments, 0) = s.ValidShippingCount,
        'DELIVERED',

        'IN_PROGRESS'
    ) AS FulfillmentStatus,

    now()

FROM silver_order AS o

LEFT JOIN
(
    SELECT
        sho.CustomerId AS CustomerId,

        sho.OrderId AS OrderId,

        countDistinct(sho.ShippingId) AS ShippingAttempts,

        countDistinctIf(
            sho.ShippingId,
            ss.CurrentStatusId != 4
        ) AS ValidShippingCount,

        nullIf(
            minIf(
                ss.InsertedAt,
                ss.CurrentStatusId != 4
            ),
            toDateTime('1970-01-01 00:00:00')
        ) AS FirstShippingDate

    FROM silver_shipping_order AS sho

    INNER JOIN silver_shipping AS ss

    ON
        sho.CustomerId = ss.CustomerId
        AND sho.ShippingId = ss.ShippingId

    GROUP BY
        sho.CustomerId,
        sho.OrderId

) AS s

ON
    o.CustomerId = s.CustomerId
    AND o.OrderId = s.OrderId


LEFT JOIN
(
    SELECT
        sho.CustomerId AS CustomerId,

        sho.OrderId AS OrderId,

        countDistinct(sho.ShippingId) AS DeliveredShipments

    FROM silver_shipping_order AS sho

    INNER JOIN silver_shipping AS ss

    ON
        sho.CustomerId = ss.CustomerId
        AND sho.ShippingId = ss.ShippingId

    INNER JOIN silver_shipping_status_history AS sh

    ON
        ss.CustomerId = sh.CustomerId
        AND ss.ShippingId = sh.ShippingId

    WHERE
        ss.CurrentStatusId != 4
        AND sh.StatusType = 'DELIVERED'

    GROUP BY
        sho.CustomerId,
        sho.OrderId

) AS d

ON
    o.CustomerId = d.CustomerId
    AND o.OrderId = d.OrderId


WHERE
    o.IsCancelled = 0;