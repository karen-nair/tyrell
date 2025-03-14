-- Add necessary indexes for better lookup performance
CREATE INDEX idx_jobs_category ON jobs(job_category_id);
CREATE INDEX idx_jobs_type ON jobs(job_type_id);
CREATE INDEX idx_jobs_deleted ON jobs(deleted);
CREATE INDEX idx_jobs_publish_status ON jobs(publish_status);
CREATE INDEX idx_jobs_name ON jobs(name);
CREATE INDEX idx_jobs_description ON jobs(description);

-- Optimize the query
SELECT 
    Jobs.id AS `Jobs__id`, 
    Jobs.name AS `Jobs__name`, 
    Jobs.media_id AS `Jobs__media_id`, 
    Jobs.job_category_id AS `Jobs__job_category_id`, 
    Jobs.job_type_id AS `Jobs__job_type_id`, 
    Jobs.description AS `Jobs__description`, 
    Jobs.detail AS `Jobs__detail`, 
    Jobs.salary_range_average AS `Jobs__salary_range_average`, 
    JobCategories.name AS `JobCategories__name`, 
    JobTypes.name AS `JobTypes__name`
FROM jobs Jobs
INNER JOIN job_categories JobCategories 
    ON JobCategories.id = Jobs.job_category_id
    AND JobCategories.deleted IS NULL
INNER JOIN job_types JobTypes 
    ON JobTypes.id = Jobs.job_type_id
    AND JobTypes.deleted IS NULL
WHERE (Jobs.name LIKE '%キャビンアテンダント%' 
       OR Jobs.description LIKE '%キャビンアテンダント%')
  AND Jobs.publish_status = 1 
  AND Jobs.deleted IS NULL
ORDER BY Jobs.sort_order DESC, Jobs.id DESC
LIMIT 50 OFFSET 0;
