SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date::DATE AS Date
FROM 
    job_postings_fact
LIMIt 5;


SELECT 
    job_title_short AS title,
    job_location AS location,
    job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS Date
FROM 
    job_postings_fact
LIMIt 5;


SELECT 
    job_title_short AS title,
    job_location AS location,
    EXTRACT (MONTH FROM job_posted_date) AS job_month,
    EXTRACT (YEAR FROM job_posted_date) AS job_month
FROM 
    job_postings_fact
LIMIt 5;


SELECT 
    COUNT(job_id) AS job_posted_count,
    EXTRACT (MONTH FROM job_posted_date)  AS Date_Month
FROM 
    job_postings_fact
WHERE 
    job_title_short = 'Data Analyst'
GROUP BY
     Date_Month
ORDER BY
    job_posted_count DESC;