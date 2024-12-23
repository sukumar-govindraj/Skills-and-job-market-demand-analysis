SELECT 
    skills_job_dim.skill_id,
    skills_dim.skills,
    count(skills_job_dim.job_id) as number_of_jobs
FROM job_postings_fact 
inner join skills_job_dim 
    on skills_job_dim.job_id = job_postings_fact.job_id
inner join skills_dim 
    on skills_dim.skill_id =  skills_job_dim.skill_id

where 
    (job_title_short= 'Data Analyst' ) AND
    (job_location='Anywhere')
group by skills
ORDER BY number_of_jobs desc
limit 5

