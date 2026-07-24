CREATE MATERIALIZED VIEW mv_shipping_funnel
TO gold_shipping_funnel
AS

SELECT

    CustomerId,

    toStartOfWeek(CreatedAt) AS Week,

    DestinationCountryCode,

    count() AS Shipments,

    avgIf(
        CreatedToTransitHours,
        CreatedToTransitHours IS NOT NULL
    ) AS AvgCreatedToTransitHours,

    avgIf(
        TransitToOutForDeliveryHours,
        TransitToOutForDeliveryHours IS NOT NULL
    ) AS AvgTransitToOutForDeliveryHours,

    avgIf(
        OutForDeliveryToDeliveredHours,
        OutForDeliveryToDeliveredHours IS NOT NULL
    ) AS AvgOutForDeliveryToDeliveredHours,

    avgIf(
        TotalDeliveryHours,
        TotalDeliveryHours IS NOT NULL
    ) AS AvgTotalDeliveryHours,

    now() AS InsertedAt

FROM gold_shipping_delivery

WHERE DestinationCountryCode IS NOT NULL

GROUP BY

    CustomerId,
    Week,
    DestinationCountryCode;