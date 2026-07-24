CREATE MATERIALIZED VIEW mv_shipping_bottleneck_geo
TO gold_shipping_bottleneck_geo
AS
SELECT
    CustomerId,
    toDate(CreatedAt) AS Date,
    DestinationCountryCode AS CountryCode,

    count() AS Shipments,

    avg(TotalDeliveryHours) AS AverageDeliveryHours,

    countIf(TotalDeliveryHours > 72) AS LateShipments

FROM gold_shipping_delivery

WHERE
    DeliveredAt IS NOT NULL

GROUP BY
    CustomerId,
    Date,
    DestinationCountryCode;