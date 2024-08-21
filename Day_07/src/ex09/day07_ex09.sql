WITH cte_aggregated_data AS (
    SELECT
        address,
        ROUND(MAX(age::numeric) - (MIN(age::numeric) / NULLIF(MAX(age::numeric), 0)), 2) AS formula,
        ROUND(AVG(age::numeric), 2) AS average
    FROM person
    GROUP BY address
)
SELECT
    address,
    formula,
    average,
    formula > average AS comparison
FROM cte_aggregated_data
ORDER BY address;