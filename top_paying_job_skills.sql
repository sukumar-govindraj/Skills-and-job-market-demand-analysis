-- What skills are required for the top paying jobs
-- 


with top_paying_job as
(    
    SELECT 
        job_id,
        name as company_name,
        job_title_short,
        salary_year_avg
    FROM job_postings_fact 
    left join company_dim on job_postings_fact.company_id = company_dim.company_id
    WHERE 
        (job_title_short='Data Analyst') AND
        (job_location='Anywhere') AND
        (salary_year_avg) is not null
    order by salary_year_avg DESC
    limit 10
    )


select 
tp.*,
s.*
FROM skills_job_dim as sj
inner join top_paying_job as tp 
    on tp.job_id = sj.job_id
inner join skills_dim as s 
    on s.skill_id = sj.skill_id
