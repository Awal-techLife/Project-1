with skills_demand as (
    SELECT
          skills_dim.skill_id,
          skills_dim.skills,
          count(skills_dim.skill_id) demand_count
    FROM
        job_postings_fact j
    INNER JOIN skills_job_dim on  
        j.job_id = skills_job_dim.job_id
    INNER JOIN skills_dim on
        skills_job_dim.skill_id = skills_dim.skill_id
    WHERE job_title_short = 'Data Analyst'
        AND job_work_from_home = TRUE
        AND salary_year_avg IS NOT NULL
    GROUP BY skills_dim.skill_id
),   

avg_skills_salary as (
    SELECT
        skills_job_dim.skill_id,
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
    GROUP BY skills_job_dim.skill_id
)

SELECT
     skills_demand.skill_id,
     skills_demand.skills,
     demand_count,
     avg_salary
FROM
    skills_demand
INNER JOIN avg_skills_salary on skills_demand.skill_id = 
     avg_skills_salary.skill_id  
WHERE demand_count > 10     
ORDER BY
     avg_salary DESC,
     demand_count DESC
LIMIT 25                    