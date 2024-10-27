SELECT
    skills,
    ROUND(AVG(salary_year_avg), 0) avg_salary
    
FROM 
    job_postings_fact
LEFT JOIN skills_job_dim 
    ON job_postings_fact.job_id = skills_job_dim.job_id
LEFT JOIN skills_dim 
    ON skills_dim.skill_id = skills_job_dim.skill_id
WHERE 
    job_title = 'Data Analyst' AND
    salary_year_avg IS NOT NULL
GROUP BY
    skills
ORDER BY
    avg_salary
LIMIT 25;