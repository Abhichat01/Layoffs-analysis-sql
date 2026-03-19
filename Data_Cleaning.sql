-- **** Creating Database **** --
IF EXISTS (SELECT * FROM sys.databases WHERE name = 'World_Layoff')
DROP DATABASE World_Layoff;

CREATE DATABASE World_Layoff;
GO

USE World_Layoff;

Select * from layoffs

-- **** Creating staging table **** --
SELECT *
INTO Layoffs_Staging
FROM layoffs;


-- **** Treatment for duplicates **** --
WITH CTE AS (
    SELECT *,
        ROW_NUMBER() OVER (
            PARTITION BY company, location, industry, total_laid_off,
                         percentage_laid_off, date, stage, country, funds_raised_millions
            ORDER BY company
        ) AS rn
    FROM Layoffs_Staging
)
DELETE FROM Layoffs_Staging
WHERE EXISTS (
    SELECT 1 FROM CTE
    WHERE CTE.rn > 1
    AND CTE.company = Layoffs_Staging.company
);

-- **** Standardizing Data **** --

-- Company Column
UPDATE Layoffs_Staging
SET company = LTRIM(RTRIM(company));

-- Industry 
UPDATE Layoffs_Staging
SET industry = NULL
WHERE industry = 'NULL';

UPDATE Layoffs_Staging
SET industry = 'Crypto Currency'
WHERE industry LIKE 'Crypto%';

-- Country
UPDATE Layoffs_Staging
SET country = 'United States'
WHERE country LIKE 'United Sta%';

-- Location
UPDATE Layoffs_Staging
SET location = 'Dusseldorf'
WHERE location LIKE 'D_ss%';

-- **** Fixing NULL Values Properly **** --
UPDATE Layoffs_Staging SET total_laid_off = NULL WHERE total_laid_off = 'NULL';
UPDATE Layoffs_Staging SET percentage_laid_off = NULL WHERE percentage_laid_off = 'NULL';
UPDATE Layoffs_Staging SET funds_raised_millions = NULL WHERE funds_raised_millions = 'NULL';

-- **** Converting Data Types **** --
-- Changing column type to allow conversion
ALTER TABLE Layoffs_Staging
ALTER COLUMN date NVARCHAR(50);

-- Converting values
UPDATE Layoffs_Staging
SET date = TRY_CONVERT(date, date, 101);

-- Finally changing datatype
ALTER TABLE Layoffs_Staging
ALTER COLUMN date DATE;

-- **** Treatment for Null Values **** --
UPDATE t1
SET t1.industry = t2.industry
FROM Layoffs_Staging t1
JOIN Layoffs_Staging t2
ON t1.company = t2.company
WHERE t1.industry IS NULL
AND t2.industry IS NOT NULL;

-- ***** Removing Useless Rows **** --
DELETE FROM Layoffs_Staging
WHERE total_laid_off IS NULL
AND percentage_laid_off IS NULL
AND funds_raised_millions IS NULL;

SELECT * FROM Layoffs_Staging