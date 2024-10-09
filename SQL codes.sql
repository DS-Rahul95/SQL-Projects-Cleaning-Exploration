-- Data Cleaning

select *
from layoffs;

-- 1. Remove Duplicates
-- 2. Stanadardize the Data
-- 3. Null Values and Blank Values
-- 4. Remove any columns

Drop table layoffs_staging;

CREATE TABLE  layoffs_staging
LIKE layoffs;

SELECT *
FROM layoffs_staging;

Insert layoffs_staging
SELECT *
FROM layoffs;

SELECT*,
ROW_NUMBER () OVER (PARTITION BY company, industry, total_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

WITH duplicate_cte as
(
SELECT*,
ROW_NUMBER () OVER (PARTITION BY company, industry, total_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging
)

DELETE
FROM duplicate_cte
WHERE row_num>1;

CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `row_num` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT *
FROM layoffs_staging2;

INSERT INTO layoffs_staging2
SELECT*,
ROW_NUMBER () OVER (PARTITION BY company, industry, total_laid_off,'date', stage, country, funds_raised_millions) as row_num
from layoffs_staging;

SELECT *
FROM  layoffs_staging2
WHERE row_num>1;

DELETE
FROM layoffs_staging2
WHERE row_num > 1;

SELECT *
FROM  layoffs_staging2;

-- Standardizing Data
SELECT *
FROM  layoffs_staging2;

SELECT DISTINCT (TRIM(company))
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET company= TRIM(company);

SELECT distinct industry 
from layoffs_staging2
order by 1;

SELECT * 
FROM layoffs_staging2 
where industry like 'crypto%';

update layoffs_staging2 set industry = 'crypto'
where industry like 'crypto %';

SELECT *
FROM layoffs_staging2
WHERE country like 'United States%'
order by 1;

SELECT DISTINCT country, TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
order by 1;

UPDATE layoffs_staging2 
set country = TRIM(TRAILING '.' FROM country) 
where country like ('United States%');

SELECT `date`,
str_to_date(`date`, '%m/%d/%Y') as new_date
FROM layoffs_staging2;

UPDATE layoffs_staging2 
SET `date` = str_to_date(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT *
FROM layoffs_staging2
WHERE total_laid_off is NULL
AND percentage_laid_off is NULL;

SELECT distinct industry 
FROM layoffs_staging2
where industry is null
or industry = '';

SELECT * 
FROM layoffs_staging2
WHere company = 'Airbnb';

UPDATE layoffs_staging2
SET industry = null
WHERE industry = '';

SELECT T1.industry, t2.industry
FROM layoffs_staging2 t1 Join layoffs_staging2 t2 
on t1.company=t2.company 
WHERE (t1.industry is NULL or t1.industry='')
AND t2.industry is not null;

UPDATE layoffs_staging2 t1
Join layoffs_staging2 t2 
	on t1.company=t2.company 
SET t1.industry=t2.industry
WHERE (t1.industry is NULL or t1.industry='')
AND t2.industry is not null;

SELECT *
FROM layoffs_staging2;

ALTER TABLE layoffs_staging2
DROP Column row_num;