SELECT
    ROUND(
        SUM(ecommerce.purchase_revenue_in_usd),
        2
    ) AS total_revenue_usd
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
WHERE
    event_name = 'purchase';