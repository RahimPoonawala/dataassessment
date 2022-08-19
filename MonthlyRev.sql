
WITH closeval as (SELECT 
	CONCAT(EXTRACT(month from closed_won_date ),'-',EXTRACT(year from closed_won_date)) as monyear,
	 SUM(.2 * deal_value_usd) as closedvalue
FROM 
	deal
WHERE 
	deal_value_usd IS NOT NULL
GROUP BY 1), 

midval as (SELECT 
	CONCAT(EXTRACT(month from closed_won_date  + interval '3 months'),'-',EXTRACT(year from closed_won_date + interval '3 months')) as monyear,
	SUM(.4 * deal_value_usd) as midvalue
FROM 
	deal 
WHERE 
	deal_value_usd IS NOT NULL 
GROUP BY 1),
endval as (
	SELECT 
	CONCAT(EXTRACT(month from closed_won_date  + interval '6 months'),'-',EXTRACT(year from closed_won_date + interval '6 months')) as monyear,
	SUM(.4 * deal_value_usd) as endvalue
FROM 
	deal 
WHERE 
	deal_value_usd IS NOT NULL 
GROUP BY 1)

SELECT 		
	CASE
		WHEN (closeval.monyear IS NULL AND midval.monyear IS NULL) THEN endval.monyear
		WHEN (midval.monyear IS NULL AND endval.monyear IS NULL) THEN closeval.monyear
		ELSE midval.monyear
	END as MonthYear,
	(COALESCE(closedvalue,0) + COALESCE(midvalue,0) + COALESCE(endvalue,0)) as monthlyrevenue
FROM
	closeval
FULL OUTER JOIN
	midval on closeval.monyear = midval.monyear
FULL OUTER JOIN
	endval on midval.monyear =endval.monyear;
	