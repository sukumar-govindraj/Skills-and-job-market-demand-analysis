with skills_demand AS
(
    SELECT 
        skills_dim.skill_id,
        skills_dim.skills,
        count(skills_job_dim.job_id) as number_of_jobs
    FROM job_postings_fact 
    inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    inner join skills_dim on skills_dim.skill_id =  skills_job_dim.skill_id
    where 
        (job_title_short= 'Data Analyst' ) AND
        (job_location='Anywhere') AND
        (salary_year_avg is not NULL)
    group by skills_dim.skill_id
    -- ORDER BY number_of_jobs desc
    -- limit 5
),
average_salary as
(
    SELECT 
        skills_job_dim.skill_id,
        Round(AVG(job_postings_fact.salary_year_avg),0) as average_salary
    FROM job_postings_fact 
    inner join skills_job_dim on skills_job_dim.job_id = job_postings_fact.job_id
    inner join skills_dim on skills_dim.skill_id = skills_job_dim.skill_id
    where
        (job_title_short= 'Data Analyst' ) AND
        (salary_year_avg is not NULL) AND
        (job_work_from_home=TRUE)
    group by skills_job_dim.skill_id
    -- ORDER BY average_salary desc
    -- limit 25
)


select 
    skills_demand.skill_id,
    skills_demand.skills,
    number_of_jobs,
    average_salary
from 
    skills_demand
inner join average_salary on skills_demand.skill_id = average_salary.skill_id