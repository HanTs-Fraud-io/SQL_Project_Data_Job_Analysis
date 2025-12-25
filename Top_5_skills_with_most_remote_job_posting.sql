/*
Find the count of the number of remote job postings per skill
    - Display the top 5 skills by their demand in remote jobs
    - Include skill ID, name, and count of postings requiring the skill
*/
WITH skills_for_remote AS (
    SELECT
        skill_id,
        COUNT(job_postings_fact.job_id) as job_count
    FROM 
        skills_job_dim
    INNER JOIN 
        job_postings_fact ON skills_job_dim.job_id = job_postings_fact.job_id
    WHERE
        job_location = 'Anywhere'
    GROUP BY
        skill_id
    ORDER BY
        job_count DESC
)
SELECT
    skills_dim.skill_id,
    skills,
    skills_for_remote.job_count
FROM 
    skills_for_remote
INNER JOIN
    skills_dim ON skills_dim.skill_id = skills_for_remote.skill_id
ORDER BY 
    skills_for_remote.job_count DESC;


