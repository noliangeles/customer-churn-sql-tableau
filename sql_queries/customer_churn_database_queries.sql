DROP DATABASE if exists churn_analysis;
CREATE DATABASE churn_analysis;
USE churn_analysis;

CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT PRIMARY KEY,
    age INT,
    gender VARCHAR(10),
    region_category VARCHAR(20),
    membership_category VARCHAR(30),
    membership_grouped VARCHAR(20)
);

CREATE TABLE activity (
    activity_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    days_since_last_login FLOAT,
    avg_time_spent FLOAT,
    avg_transaction_value FLOAT,
    avg_frequency_login_days FLOAT,
    points_in_wallet FLOAT,
    engagement_score FLOAT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE preferences (
    pref_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    joined_through_referral VARCHAR(10),
    preferred_offer_types VARCHAR(50),
    medium_of_operation VARCHAR(20),
    internet_option VARCHAR(20),
    used_special_discount VARCHAR(10),
    offer_application_preference VARCHAR(10),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE support (
    support_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    past_complaint VARCHAR(10),
    had_complaint INT,
    complaint_status VARCHAR(30),
    feedback TEXT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

CREATE TABLE churn (
    churn_id INT AUTO_INCREMENT PRIMARY KEY,
    customer_id INT,
    churn_risk_score INT,
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);

-- INSERT INTO the first 5 rows into all tables
-- insert first 5 rows customers table
INSERT INTO customers (age, gender, region_category, membership_category, membership_grouped) VALUES (18, 'F', 'Village', 'Platinum Membership', 'Paid');
INSERT INTO customers (age, gender, region_category, membership_category, membership_grouped) VALUES (32, 'F', 'City', 'Premium Membership', 'Paid');
INSERT INTO customers (age, gender, region_category, membership_category, membership_grouped) VALUES (44, 'F', 'Town', 'No Membership', 'No Membership');
INSERT INTO customers (age, gender, region_category, membership_category, membership_grouped) VALUES (37, 'M', 'City', 'No Membership', 'No Membership');
INSERT INTO customers (age, gender, region_category, membership_category, membership_grouped) VALUES (31, 'F', 'City', 'No Membership', 'No Membership');

-- double check table
SELECT * FROM customers;

-- activity table
INSERT INTO activity (customer_id, days_since_last_login, avg_time_spent, avg_transaction_value, avg_frequency_login_days, points_in_wallet, engagement_score) VALUES (1, 17.0, 300.63, 53005.25, 17.0, 781.75, 5892.46);
INSERT INTO activity (customer_id, days_since_last_login, avg_time_spent, avg_transaction_value, avg_frequency_login_days, points_in_wallet, engagement_score) VALUES (2, 16.0, 306.34, 12838.38, 10.0, 698.25, 3761.65);
INSERT INTO activity (customer_id, days_since_last_login, avg_time_spent, avg_transaction_value, avg_frequency_login_days, points_in_wallet, engagement_score) VALUES (3, 14.0, 516.16, 21027.0, 22.0, 500.69, 11856.21);
INSERT INTO activity (customer_id, days_since_last_login, avg_time_spent, avg_transaction_value, avg_frequency_login_days, points_in_wallet, engagement_score) VALUES (4, 11.0, 53.27, 25239.56, 6.0, 567.66, 887.28);
INSERT INTO activity (customer_id, days_since_last_login, avg_time_spent, avg_transaction_value, avg_frequency_login_days, points_in_wallet, engagement_score) VALUES (5, 20.0, 113.13, 24483.66, 16.0, 663.06, 2473.14);

-- preferences table
INSERT INTO preferences (customer_id, joined_through_referral, preferred_offer_types, medium_of_operation, internet_option, used_special_discount, offer_application_preference)
VALUES
(1, 'No', 'Gift Vouchers/Coupons', 'Desktop', 'Wi-Fi', 'Yes', 'Yes'),
(2, 'Yes', 'Gift Vouchers/Coupons', 'Desktop', 'Mobile_Data', 'Yes', 'No'),
(3, 'Yes', 'Gift Vouchers/Coupons', 'Desktop', 'Wi-Fi', 'No', 'Yes'),
(4, 'Yes', 'Gift Vouchers/Coupons', 'Desktop', 'Mobile_Data', 'No', 'Yes'),
(5, 'No', 'Credit/Debit Card Offers', 'Smartphone', 'Mobile_Data', 'No', 'Yes');

-- support table
INSERT INTO support (customer_id, past_complaint, had_complaint, complaint_status, feedback) 
VALUES
(1, 'No', 0, 'Not Applicable', 'Products always in Stock'),
(2, 'Yes', 1, 'Solved', 'Quality Customer Care'),
(3, 'Yes', 1, 'Solved in Follow-up', 'Poor Website'),
(4, 'Yes', 1, 'Unsolved', 'Poor Website'),
(5, 'Yes', 1, 'Solved', 'Poor Website');

-- churn table
INSERT INTO churn (customer_id, churn_risk_score) 
VALUES
(1,0),
(2,0),
(3,1),
(4,1),
(5,1);

-- test query
SELECT * FROM customers;

-- Let's answer some questions using the sample data!
-- query 1: What is the average churn risk score by membership category?
-- hopefully this answers which membership category are associated with higher or lower churn risk
SELECT 
    c.membership_category,
    AVG(ch.churn_risk_score) AS avg_churn_score
FROM 
    customers c
JOIN 
    churn ch ON c.customer_id = ch.customer_id
GROUP BY 
    c.membership_category;

-- question 1
-- What is the average time spent on the platform per membership group (Paid vs. No Membership)?
-- tables needed = customers, activity
SELECT 
	c.membership_grouped,
    AVG(a.avg_time_spent) AS avg_time_spent
FROM 
	customers c
JOIN
	activity a ON c.customer_id = a.customer_id
GROUP BY 
	c.membership_grouped





-- question 2
-- Which region category has the highest average churn risk score?
-- tables = customers, churn
SELECT
	c.region_category,
    AVG(ch.churn_risk_score) AS avg_churn_score
FROM 
	customers c
JOIN
	churn ch ON c.customer_id = ch.customer_id
GROUP BY 
	c.region_category;
	
    
-- question 3
-- How many customers used a special discount, grouped by internet option?
-- preferences

SELECT 
	internet_option, SUM(CASE WHEN used_special_discount = 'Yes' THEN 1 ELSE 0 END) AS discount_yes,
	SUM(CASE WHEN used_special_discount = 'No' THEN 1 ELSE 0 END) AS discount_no
FROM 
	preferences
GROUP BY 
	internet_option;
    
    
-- question 4
-- Which preferred offer type has the highest average engagement score?
-- tables = preferences, activity

SELECT
	p.preferred_offer_types,
    AVG(a.engagement_score) AS avg_engage_score
FROM
	preferences p
LEFT JOIN
	activity a ON p.customer_id = a.customer_id
GROUP BY
	p.preferred_offer_types;

-- test references table
SELECT 
    preferred_offer_types,
    COUNT(*) AS customer_count
FROM preferences
GROUP BY preferred_offer_types;   
























-- dummy lines to allow scrolling



















-- more lines