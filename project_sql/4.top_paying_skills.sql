SELECT
      skills,
      round(avg(salary_year_avg),0)avg_salary
FROM
    job_postings_fact j
INNER JOIN skills_job_dim on  
    j.job_id = skills_job_dim.job_id
INNER JOIN skills_dim on
    skills_job_dim.skill_id = skills_dim.skill_id
WHERE job_title_short = 'Data Analyst'
    AND salary_year_avg IS NOT NULL
    AND job_work_from_home = TRUE 
GROUP BY skills
ORDER BY  avg_salary DESC
LIMIT 25        