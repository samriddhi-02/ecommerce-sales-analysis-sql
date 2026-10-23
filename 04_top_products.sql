SELECT
    item.item_name AS product_name,
    ROUND(
        SUM(item.item_revenue_in_usd),
        2
    ) AS revenue_usd
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`,
    UNNEST(items) AS item
WHERE
    event_name = 'purchase'
    AND item.item_name IS NOT NULL
GROUP BY
    product_name
ORDER BY
    revenue_usd DESC
LIMIT 10;