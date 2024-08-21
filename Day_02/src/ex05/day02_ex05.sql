SELECT name
FROM
    (SELECT * FROM person WHERE age > 25 AND gender = 'female')
ORDER BY name