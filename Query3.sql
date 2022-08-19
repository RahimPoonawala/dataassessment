SELECT 
	count(*)/SUM(count(*)) OVER() as CityDealPercentage,
	CASE
		WHEN (UPPER(property_city) like '%BROOKLYN%' OR UPPER(property_city) like '%BRONX%' OR UPPER(property_city) like '%STATEN ISLAND%' OR UPPER(property_city) like '%LONG ISLAND CITY%' OR UPPER(property_city) like '%MANHATTAN%' OR UPPER(property_city) like '%FLUSHING%' OR UPPER(property_city) like '%JACKSON HEIGHTS%' OR UPPER(property_city) like '%FOREST HILLS%') THEN 'NEW YORK'
		WHEN property_city IS NULL THEN 'CITY NAME NOT PROVIDED'
		ELSE UPPER(property_city)
	END as City
FROM
	deal D
LEFT JOIN
	deal_contact DC ON D.deal_id = DC.deal_id
LEFT JOIN
	contact C on DC.contact_id = C.contact_id
LEFT JOIN
	block_user U ON C.user_id = U.user_id
LEFT JOIN
	email E on U.user_id = E.user_id
WHERE 
	deal_value_usd IS NOT NULL
AND
	LOWER(hashed_email)  NOT LIKE '%@blockrenovation.com%'
AND
	(LOWER(first_name) NOT LIKE '%test%' OR LOWER(first_name) IS NULL)
AND
	(LOWER(last_name) NOT LIKE '%test%' OR last_name IS NULL)
GROUP BY
	2
ORDER BY CityDealPercentage desc;