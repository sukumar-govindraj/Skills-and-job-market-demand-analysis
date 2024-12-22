-- what are the top paying data analyst jobs?
-- Ideentify the top 10 highest paying data analyst roles that are available remotely
-- Focus on the job posting with speciiied salaries (Do not include nulls)
-- Why? Highlight the top paying oppportunities for data analysts, offering insights into 


SELECT 
    job_id,
    name as company_name,
    job_title,
    job_location,
    Job_Schedule_type,
    salary_year_avg,
    job_posted_date::DATE
FROM job_postings_fact 
left join company_dim on job_postings_fact.company_id = company_dim.company_id
WHERE 
    (job_title_short='Data Analyst') AND
    (job_location='Anywhere') AND
    (salary_year_avg) is not null
order by salary_year_avg DESC
limit 10;