/*
Question: What are the most in-demand skills for data nalysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market,
providing insights into the most valuable skills for job seekers
*/

    SELECT
        skills,
        COUNT(jp.job_id) AS skill_count
    FROM 
        job_postings_fact jp
    INNER JOIN 
        skills_job_dim ON jp.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        jp.job_title_short = 'Data Analyst' 
    GROUP BY
        skills
    ORDER BY
        skill_count DESC
    LIMIT 5;