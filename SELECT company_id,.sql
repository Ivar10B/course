SELECT company_id, 
    name AS company_name
    FROM company_dim 
    WHERE company_id IN (
        SELECT
                company_id
        FROM
                job_postings_fact
        WHERE
                job_no_degree_mention = TRUE 
        ORDER BY 
                company_id
    )

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
            company_job_count.total_job
    FROM company_dim
    LEFT JOIN company_job_count ON company_job_count.company_id = company_dim.company_id 
    ORDER BY total_job DESC 