SELECT 
	COUNT(DISTINCT BU.user_id) as c ,
	CONCAT(EXTRACT(month from create_date),'-',EXTRACT(year from create_date))
FROM
	block_user BU 
LEFT JOIN
	email E on BU.user_id = E.user_id
LEFT JOIN
	contact C on E.user_id = C.user_id
WHERE 
	LOWER(hashed_email)  NOT LIKE '%@blockrenovation.com%'
AND
	(LOWER(first_name) NOT LIKE '%test%' OR LOWER(first_name) IS NULL)
AND
	(LOWER(last_name) NOT LIKE '%test%' OR last_name IS NULL)
GROUP BY
	2 ORDER BY c DESC;

#March of 2021 1,493