-- let's try extracting month from date columns

select 
    EXTRACT(MONTH FROM job_posted_date)
from job_postings_fact 
limit 5;

-- let's see how many jobs are posted per month throughout the years
select 
    extract(MONTH from job_posted_date) as month,
    extract(YEAR from job_posted_date) as year,
    count(*) as Number_of_jobs
from job_postings_fact
GROUP BY MONTH, YEAR
order by Number_of_jobs DESC;

-- let's try to extract job posted in the month of july for thr role of DAta Analyst
select *
from job_postings_fact
where 
    (extract(MONTH from job_posted_date) = 7) And
    (job_title_short='Data Analyst')

-- let's try creating table's using the the queries
CREATE TABLE july_month_data_analyst_jobs as
    (
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 7) And
            (job_title_short='Data Analyst')
    )
select count(*) from july_month_data_analyst_jobs;


-- lets just try for January for all jobs not just limited to data analyst jobs
CREATE TABLE january_jobs as
    (
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 1) And
            (job_title_short='Data Analyst')
    );
select count(*) from january_jobs;

-- February
CREATE TABLE february_jobs as
    (
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 2) And
            (job_title_short='Data Analyst')
    );
select count(*) from february_jobs;

-- March
CREATE TABLE march_jobs as
    (
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 3) And
            (job_title_short='Data Analyst')
    );
select count(*) from march_jobs;

-- Case
SELECT 
    case 
        WHEN job_location ='New York, NY' then "Local"
        when job_location='Anywhere' then "Remote",
        else 'Onsite'
    end as location_category
from job_postings_fact
where job_title_short='Data Analyst'
GROUP BY location_category;


-- Subquery
-- It can be used within SELECT, FROM, WHERE
select * 
FROM
    (
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 1) And
            (job_title_short='Data Analyst')
    )
as january_jobs;


-- CTE (Comman Table Expresions)
with january_jobs as 
(
        select *
        from job_postings_fact
        where 
            (extract(MONTH from job_posted_date) = 1) And
            (job_title_short='Data Analyst')
)

select * from january_jobs;

-- Find the count of the number remote job postings per skill
    -- Displat\y the top 5 skills by their demand in remote jobs
        --  include skill ID, Name and count of postings requiring the skills



with skill_specific_remote_job_count as
    (   
        select 
        skill_id,
        Count(*) as number_of_jobs
        from skills_job_dim as job_skill
        inner join job_postings_fact as jobs on job_skill.job_id = jobs.job_id
        where job_work_from_home='true'
        group by skill_id
    )
Select 
s.skill_id,
skills,
n.number_of_jobs
from skills_dim as s
inner join skill_specific_remote_job_count as n
    on s.skill_id = n.skill_id
order by n.number_of_jobs DESC
limit 5;



-- Find teh job postings from the first quarter that have salary gretaer than $70k

select 
    job_title_short,
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg as salary
from job_postings_fact
where 
    (extract(month from job_posted_date) in (1,2,3)) And
    (salary_year_avg >70000) AND
    (job_title_short='Data Analyst')
order by salary_year_avg DESC;
