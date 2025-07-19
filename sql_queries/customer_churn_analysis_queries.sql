-- question 1: Which membership group has the highest proportion of high churn risk customers?
-- tip: use count, group by, join
-- tables = customers and churn
SELECT DISTINCT membership_category FROM customers;
SELECT DISTINCT membership_grouped FROM customers;
SELECT DISTINCT churn_risk_score FROM churn;

SELECT
  c.membership_grouped,
  COUNT(CASE WHEN ch.churn_risk_score = 1 THEN 1 END) * 1.0 / COUNT(*) AS churn_rate
FROM
  customers c
JOIN
  churn ch ON c.customer_id = ch.customer_id
GROUP BY
  c.membership_grouped;


-- question 2: What is the average churn risk score for each region category?
-- tables = customers and churn
-- tip: use AVG() and count()

SELECT
	c.region_category,
    AVG(ch.churn_risk_score) AS avg_churn_risk_score
FROM 
	customers c 
JOIN 
	churn ch ON c.customer_id = ch.customer_id
GROUP BY 
	c.region_category;


-- question 3: How many customers use each type of internet option, and how many of them have used a special discount?
-- preferences tables
-- group by internet_option
-- SUM(CASE WHEN...) for both discount_yes and discount_no
SELECT * FROM preferences LIMIT 5;

SELECT
	internet_option,
    SUM(CASE WHEN used_special_discount='Yes' THEN 1 ELSE 0 END) AS discount_yes,
	SUM(CASE WHEN used_special_discount='No' THEN 1 ELSE 0 END) AS discount_no
FROM preferences
GROUP BY internet_option;


-- question 4: What is the average engagement score for each preferred offer type?
-- tables = preferences and activity
-- use AVG
-- GROUP BY preferred_offer_types

SELECT
	p.preferred_offer_types,
    AVG(a.engagement_score) AS avg_engage_score
FROM 
	preferences p
JOIN
	activity a ON p.customer_id = a.customer_id
GROUP BY 
	preferred_offer_types;

    
-- question 5:  Among customers with high churn risk, what is the breakdown of complaint status across membership groups?
-- Let's see how unresolved complaints relate to churn risk, broken down by membership type
-- 3 tables = customers, support, and churn
-- CASE WHEN to count complaint types
-- filter WHERE churn_risk_score = 1 (high risk)
-- GROUP BY membership_grouped
SELECT DISTINCT complaint_status FROM support;

SELECT
	c.membership_grouped,
    SUM(CASE WHEN s.complaint_status='Not Applicable' THEN 1 ELSE 0 END) AS not_applicable,
	SUM(CASE WHEN s.complaint_status = 'Solved' THEN 1 ELSE 0 END) AS solved,
	SUM(CASE WHEN s.complaint_status = 'Solved in Follow-up' THEN 1 ELSE 0 END) AS solved_followup,
	SUM(CASE WHEN s.complaint_status = 'Unsolved' THEN 1 ELSE 0 END) AS unsolved,
	SUM(CASE WHEN s.complaint_status = 'No Information Available' THEN 1 ELSE 0 END) AS no_info,
	COUNT(*) AS total_customers
FROM 
	customers c
JOIN 
	support s ON c.customer_id = s.customer_id
JOIN
	churn ch ON c.customer_id = ch.customer_id
WHERE
	ch.churn_risk_score = 1
GROUP BY
	c.membership_grouped;














-- dummy lines












-- space!