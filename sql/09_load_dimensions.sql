/*
Project: Climate Impact on Olive Yield
File: 09_load_dimensions.sql
Purpose: Load and validate the country and year dimensions.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Load the country dimension
IF NOT EXISTS
(
    SELECT 1
    FROM analytics.dim_country
)
BEGIN
    INSERT INTO analytics.dim_country
    (
        country_name
    )
    SELECT DISTINCT
        LTRIM(RTRIM(country))
    FROM raw.gold_olive_yield
    WHERE NULLIF(LTRIM(RTRIM(country)), '') IS NOT NULL;
END;
GO

-- Load the year dimension
IF NOT EXISTS
(
    SELECT 1
    FROM analytics.dim_year
)
BEGIN
    INSERT INTO analytics.dim_year
    (
        year_number
    )
    SELECT DISTINCT
        TRY_CONVERT
        (
            SMALLINT,
            LTRIM(RTRIM([year]))
        )
    FROM raw.gold_olive_yield
    WHERE TRY_CONVERT
    (
        SMALLINT,
        LTRIM(RTRIM([year]))
    ) IS NOT NULL;
END;
GO

-- Validate the loaded dimensions
SELECT
    COUNT(1) AS country_count
FROM analytics.dim_country;
GO

SELECT
    COUNT(1) AS year_count,
    MIN(year_number) AS minimum_year,
    MAX(year_number) AS maximum_year
FROM analytics.dim_year;
GO