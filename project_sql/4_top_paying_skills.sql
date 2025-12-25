/*
Answer: What are the top sills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identity the most financially rewarding skills to acquire or improve
*/


SELECT
    skills,
    ROUND(AVG(salary_year_avg),0) AS avg_salary
FROM 
    job_postings_fact jp        
INNER JOIN     
    skills_job_dim ON jp.job_id = skills_job_dim.job_id
INNER JOIN    
    skills_dim ON skills_job_dim.skill_id = skills_dim.skill_id       
WHERE    
    jp.job_title_short = 'Data Analyst' AND
    salary_year_avg IS NOT NULL       
GROUP BY
    skills           
ORDER BY    
    avg_salary DESC        
LIMIT 25;              

/*
 three quick, high-level trends that stand out from your top-paying data analyst skills list:

DevOps & Infrastructure skills are commanding premium pay
Tools like Terraform, Ansible, Puppet, Airflow, Kafka, Cassandra, VMware, and GitLab dominate the list. 
This suggests companies highly value analysts who can work close to production systems and data pipelines, not just dashboards.

Advanced ML & AI tooling boosts analyst salaries
Skills such as PyTorch, TensorFlow, Keras, Hugging Face, DataRobot, MXNet show that analysts with hands-on 
machine learning and model deployment exposure are paid more than traditional SQL-only analysts.

Niche or cross-disciplinary skills drive outsized salaries
Outliers like Solidity (blockchain), Golang, and even SVN indicate that rare skill overlap (analytics + backend, 
Web3, or legacy systems) can dramatically increase pay due to low supply and high specialization.

Bottom line:
The highest-paid data analysts are increasingly hybrid professionals—combining analytics with engineering, ML, and 
infrastructure skills, rather than focusing purely on reporting
*/
