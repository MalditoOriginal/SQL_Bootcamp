SET enable_seqscan TO OFF;
EXPLAIN ANALYZE
SELECT m.pizza_name, p.name AS pizzeria_name
FROM menu m
INNER JOIN pizzeria p on m.pizzeria_id = p.id;