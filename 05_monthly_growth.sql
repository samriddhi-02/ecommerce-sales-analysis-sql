WITH monthly_sales AS (
    SELECT
        FORMAT_DATE(
            '%Y-%m',
            PARSE_DATE('%Y%m%d', event_date)
        ) AS sales_month,
        SUM(
            ecommerce.purchase_revenue_in_usd
        ) AS revenue_usd
    FROM
        `bigquery-public-data.ga4_obfuscated_sample_ecommerce.events_*`
    WHERE
        event_name = 'purchase'
    GROUP BY
        sales_month
),

monthly_growth AS (
    SELECT
        sales_month,
        revenue_usd,
        LAG(revenue_usd) OVER (
            ORDER BY sales_month
        ) AS previous_month_revenue
    FROM
        monthly_sales
)

SELECT
    sales_month,
    ROUND(revenue_usd, 2) AS revenue_usd,
    ROUND(previous_month_revenue, 2)
        AS previous_month_revenue,
    ROUND(
        SAFE_DIVIDE(
            revenue_usd - previous_month_revenue,
            previous_month_revenue
        ) * 100,
        2
    ) AS growth_percentage
FROM
    monthly_growth
ORDER BY
    sales_month;