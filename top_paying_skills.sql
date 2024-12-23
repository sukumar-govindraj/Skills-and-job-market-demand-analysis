SELECT 
    skills_dim.skills,
    Round(AVG(job_postings_fact.salary_year_avg),0) as average_salary
FROM job_postings_fact 
inner join skills_job_dim 
    on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim 
    on skills_dim.skill_id = skills_job_dim.skill_id
where
    (job_title_short= 'Data Analyst' ) AND
    (salary_year_avg is not NULL) AND
    (job_work_from_home=TRUE)
group by skills
ORDER BY average_salary desc
limit 25

