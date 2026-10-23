SELECT
    event_date,
    event_name,
    geo.country
FROM
    `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
LIMIT 10;
