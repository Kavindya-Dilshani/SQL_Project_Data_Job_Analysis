CREATE TABLE job_applied (
        job_id INT,
        application_sent_date DATE,
        custom_resume BOOLEAN,
        resume_file_name VARCHAR(255),
        cover_letter_sent BOOLEAN,
        cover_letter_file_name VARCHAR(255),
        status VARCHAR(50)

);

INSERT INTO job_applied(
        job_id,
        application_sent_date, 
        custom_resume,
        resume_file_name,
        cover_letter_sent,
        cover_letter_file_name,
        status
)
VALUES(
        1,
        '2024-02-01',
        true,
        'resume_01_pdf',
        true,
        'cover_letter_01.pdf',
        'submitted'
),
(
        2,
        '2024-02-02',
        false,
        'resume_02_pdf',
        false,
        NULL,
        'interview scheduled'
),
(
        3,
        '2024-02-03',
        true,
        'resume_03_pdf',
        true,
        'cover_letter_03.pdf',
        'ghosted'
),
(
        4,
        '2024-02-04',
        true,
        'resume_01_pdf',
        false,
        NULL,
        'submitted'
),
(
        5,
        '2024-02-05',
        false,
        'resume_05_pdf',
        true,
        'cover_letter_05.pdf',
        'rejected'
);

SELECT *
FROM job_applied;

ALTER TABLE job_applied
ADD contact VARCHAR(50);

UPDATE job_applied
SET contact = 'Erlich Bachmen'
WHERE job_id = 1;

UPDATE  job_applied
SET contact = 'Dinesh Chugtai'
WHERE job_id = 2;

UPDATE  job_applied
SET contact = 'Bertram Gilfoyle'
WHERE job_id = 3;

UPDATE  job_applied
SET contact = 'Jian Yang'
WHERE job_id = 4;

UPDATE  job_applied
SET contact = 'Big Head'
WHERE job_id = 5;


ALTER TABLE job_applied
RENAME COLUMN contact TO contact_name;

ALTER TABLE job_applied
ALTER COLUMN contact_name TYPE TEXT;

ALTER TABLE job_applied
DROP COLUMN contact_name;

DROP TABLE job_applied;



WITH company_job_count AS (
SELECT 
        company_id,
        COUNT(*) AS total_job_count
FROM 
        job_postings_fact
GROUP BY
        company_id
)

SELECT 
        company_dim.name AS company_name,
        company_job_count.total_job_count
FROM 
        company_dim
LEFT JOIN company_job_count
        ON company_dim.company_id = company_job_count.company_id
ORDER BY 
        total_job_count DESC;



WITH remote_job_skills AS (
SELECT 
        skill_id,
        COUNT(*) AS skills_count
FROM 
        skills_job_dim AS skills_to_job
INNER JOIN job_postings_fact AS job_posting 
        ON job_posting.job_id = skills_to_job.job_id
WHERE 
        job_posting.job_work_from_home = TRUE
GROUP BY 
        skill_id
)

SELECT 
        skills.skill_id,
        skills_count,
        skills AS skill_name
FROM 
        remote_job_skills
INNER JOIN skills_dim AS skills 
        ON remote_job_skills.skill_id = skills.skill_id
ORDER BY 
        skills_count DESC
LIMIT 5;


SELECT 
        job_title_short,
        company_id,
        job_location
From 
        job_postings_fact

UNION ALL

SELECT 
        job_title_short,
        company_id,
        job_location
From 
        february_jobs




SELECT 
        quarter_job_posting.job_location,
        quarter_job_posting.job_title_short,
        quarter_job_posting.job_via,
        quarter_job_posting.job_posted_date::DATE
FROM (
SELECT *
FROM 
        january_jobs
UNION ALL

SELECT *
FROM 
        february_jobs
UNION ALL

SELECT *
FROM 
        march_jobs
) AS quarter_job_posting
WHERE 
        quarter_job_posting.salary_year_avg > 70000;