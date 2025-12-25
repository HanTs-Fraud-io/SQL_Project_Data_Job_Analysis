/*
Answer: What are the most optimal skills to learn (aka it's in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
offering strategic insights for career development in data analysis.
*/

WITH skills_in_demand AS ( 
    SELECT
        skills_dim.skill_id,
        skills_dim.skills,
        COUNT(jp.job_id) AS skill_count
    FROM 
        job_postings_fact jp
    INNER JOIN 
        skills_job_dim ON jp.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        jp.job_title_short = 'Data Analyst' AND
        jp.job_work_from_home = True AND
        jp.salary_year_avg IS NOT NULL
    GROUP BY
        skills_dim.skill_id
), average_salary AS (
    SELECT
    skills_job_dim.skill_id,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jp        
INNER JOIN     
    skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN    
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id       
WHERE    
    jp.job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL AND
    jp.job_work_from_home = True
GROUP BY
    skills_job_dim.skill_id
)
SELECT
    skills_in_demand.skill_id,
    skills_in_demand.skills,
    skills_in_demand.skill_count,
    average_salary.avg_salary
FROM
    skills_in_demand
INNER JOIN
    average_salary ON skills_in_demand.skill_id = average_salary.skill_id
WHERE
    skills_in_demand.skill_count >= 10
ORDER BY
    skills_in_demand.skill_count DESC,
    average_salary.avg_salary DESC
    LIMIT 25;

-- rewriting this same query more concisely
SELECT
    skills_dim.skill_id,
    skills_dim.skills,
    COUNT(jp.job_id) AS skill_count,
    ROUND(AVG(jp.salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jp
INNER JOIN
    skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
WHERE
    jp.job_title_short = 'Data Analyst' AND
    jp.job_work_from_home = True AND
    jp.salary_year_avg IS NOT NULL
GROUP BY
    skills_dim.skill_id
HAVING
    COUNT(jp.job_id) >= 10
ORDER BY
    skill_count DESC,
    avg_salary DESC
LIMIT 25;