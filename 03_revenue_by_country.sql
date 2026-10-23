SELECT
    geo.country AS country,
    ROUND(
        SUM(ecommerce.purchase_revenue_in_usd),
        2
    ) AS revenue_usd
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    event_name = 'purchase'
    AND geo.country IS NOT NULL
GROUP BY
    country
ORDER BY
    revenue_usd DESC
LIMIT 10;