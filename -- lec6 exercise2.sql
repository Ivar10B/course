-- lec6 exercise2
WITH topskills AS (
    SELECT skill_id,
        COUNT(*) AS skill_count
    FROM skills_job_dim
    GROUP BY skill_id
    ORDER BY skill_count DESC
    LIMIT 5
)
SELECT skills_dim.skill_name,
         topskills.skill_count
FROM topskills skill_dim 
JOIN skills_dim   ON topskills.skill_id = skill_dim.skill_id;

-- 2)
  with company_job_count  AS  (
        SELECT
                company_id,
                COUNT(*) AS total_job
        FROM
            job_postings_fact
        GROUP BY
                company_id
    )
    SELECT company_dim.name,
            company_job_count.total_job,
            CASE
            WHEN company_job_count.total_job < 10 THEN 'small'
            WHEN company_job_count.total_job BETWEEN 10 AND 50 THEN 'medium'
            ELSE 'large'
            END AS size_category
    FROM company_dim
     LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id 
    ORDER BY total_job DESC 
   