SELECT 
	SUM(deal_value_usd) as val ,
    CONCAT(EXTRACT(month from closed_won_date),'-',EXTRACT(year from closed_won_date))
FROM 
	deal 
WHERE 
	deal_value_usd IS NOT NULL 
GROUP BY 2
ORDER BY 
	val desc;

#April 2021 2,059,197 Rev