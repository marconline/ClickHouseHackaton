INSERT INTO silver_shipping
SELECT

    s.CustomerId,
    s.ShippingId,
    s.OrderId,

    s.IsReturnShipping,

    o.MarketplaceId,
    o.MarketplaceName,
    o.AccountId,

    s.CarrierCost,
    s.Currency,

    s.ShippingConfigurationId,
    s.ShippingConfigurationName,
    s.CarrierName,

    s.PackageCount,
    s.TotalWeightKg,
    s.UnknownWeightUnits,

    s.CurrentStatusId,

    -- Origin
    aFrom.CountryCode,
    aFrom.Province,
    aFrom.City,
    aFrom.PostalCode,

    -- Destination
    aTo.CountryCode,
    aTo.Province,
    aTo.City,
    aTo.PostalCode,

    s.InsertedAt,
    s.UpdatedAt

FROM bronze_shipping s

LEFT JOIN silver_order o
    ON s.CustomerId = o.CustomerId
    AND s.OrderId = o.OrderId

LEFT JOIN bronze_shipping_address aFrom
    ON s.CustomerId = aFrom.CustomerId
    AND s.AddressFromId = aFrom.ShippingAddressId

LEFT JOIN bronze_shipping_address aTo
    ON s.CustomerId = aTo.CustomerId
    AND s.AddressToId = aTo.ShippingAddressId;