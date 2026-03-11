/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst roles identified in the first query.
- Add the required skills for these roles by joining with the job_skills_dim table.
-Why? It provides insights into the specific skills that are in demand for high-paying Data Analyst positions, helping job seekers focus on acquiring these skills to enhance their career prospects.
*/

WITH top_paying_jobs AS (
SELECT 
    job_id,
    job_title,
    salary_year_avg,
    name AS company_name
FROM 
    job_postings_fact
LEFT JOIN company_dim ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst' AND 
    job_location = 'Anywhere' AND 
    salary_year_avg IS NOT NULL
ORDER BY
    salary_year_avg DESC
LIMIT 10
)

SELECT 
    top_paying_jobs.*,
    skills
FROM top_paying_jobs
INNER JOIN skills_job_dim ON top_paying_jobs.job_id = skills_job_dim.job_id
INNER JOIN skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
ORDER BY
    salary_year_avg DESC;