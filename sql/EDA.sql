-- **** EDA **** --

use World_Layoff

-- **** Segmented layoffs **** --
SELECT 
    CASE 
        WHEN total_laid_off < 100 THEN 'Small'
        WHEN total_laid_off BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'Large'
    END AS layoff_size,
    COUNT(*) AS count_companies
FROM Layoffs_Staging
GROUP BY 
    CASE 
        WHEN total_laid_off < 100 THEN 'Small'
        WHEN total_laid_off BETWEEN 100 AND 1000 THEN 'Medium'
        ELSE 'Large'
    END;


-- **** Top 10 Companies by Layoffs **** --
SELECT TOP 10 company, SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY company
ORDER BY total_laid_off DESC;


-- **** Layoffs by Industry **** --
SELECT industry, SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY industry
ORDER BY total_laid_off DESC;

-- **** Layoffs by Country **** --
SELECT country, SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY country
ORDER BY total_laid_off DESC;


-- **** Layoffs by Stage **** --
SELECT stage, SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY stage
ORDER BY total_laid_off DESC;


-- **** Monthly Layoff Trend **** --
SELECT 
    YEAR(date) AS year,
    MONTH(date) AS month,
    SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY YEAR(date), MONTH(date)
ORDER BY year, month;

-- **** Yearly Layoff Trend **** --
SELECT 
    YEAR(date) AS year,
    SUM(total_laid_off) AS total_laid_off
FROM Layoffs_Staging
GROUP BY YEAR(date)
ORDER BY year DESC;



-- **** Rolling Lay OFF Daily **** --
SELECT 
    date,
    SUM(total_laid_off) AS daily_layoffs,
    SUM(SUM(total_laid_off)) OVER (ORDER BY date) AS rolling_total
FROM Layoffs_Staging
GROUP BY date
ORDER BY date;


-- **** Ranking Year wise **** --
WITH company_year AS (
    SELECT 
        company,
        YEAR(date) AS year,
        SUM(total_laid_off) AS total_laid_off
    FROM Layoffs_Staging
    GROUP BY company, YEAR(date)
),
ranking AS (
    SELECT *,
        DENSE_RANK() OVER (PARTITION BY year ORDER BY total_laid_off DESC) AS rank_num
    FROM company_year
)
SELECT *
FROM ranking
WHERE rank_num <= 5;
