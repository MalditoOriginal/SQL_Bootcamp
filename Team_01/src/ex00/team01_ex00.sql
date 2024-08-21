WITH cte_balance AS(
SELECT user_id,type,SUM(money) AS volume,currency_id,MAX(balance.updated)
FROM balance
GROUP BY user_id,type,currency_id
ORDER BY 1),
cte_currency AS(
    SELECT * FROM(
        SELECT *,MAX(updated) OVER (PARTITION BY name)
        FROM currency) t
    WHERE updated = max
)
SELECT COALESCE(u.name,'not defined') name,
    COALESCE(u.lastname,'not defined') lastname,
    type,
    volume,
    COALESCE(cte_currency.name,'not defined') currency_name,
    COALESCE(rate_to_usd,1) last_rate_to_usd,
    volume * COALESCE(rate_to_usd,1) total_volume_in_usd
FROM "user" u
FULL JOIN cte_balance ON u.id = cte_balance.user_id
FULL JOIN cte_currency ON cte_currency.id = currency_id
ORDER BY 1 DESC,2,4
-- SELECT * FROM cte_currency
