/*
Project: Climate Impact on Olive Yield
File: 07_validate_raw_data.sql
Purpose: Validate the completeness, grain, and consistency of the raw data.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Validate row counts
SELECT
    'raw.gold_olive_yield' AS table_name,
    COUNT(1) AS row_count
FROM raw.gold_olive_yield

UNION ALL

SELECT
    'raw.knn_test_predictions' AS table_name,
    COUNT(1) AS row_count
FROM raw.knn_test_predictions;
GO

-- Validate country and year coverage
SELECT
    'raw.gold_olive_yield' AS table_name,
    COUNT(DISTINCT country) AS country_count,
    MIN(TRY_CONVERT(SMALLINT, [year])) AS minimum_year,
    MAX(TRY_CONVERT(SMALLINT, [year])) AS maximum_year
FROM raw.gold_olive_yield

UNION ALL

SELECT
    'raw.knn_test_predictions' AS table_name,
    COUNT(DISTINCT country) AS country_count,
    MIN(TRY_CONVERT(SMALLINT, [year])) AS minimum_year,
    MAX(TRY_CONVERT(SMALLINT, [year])) AS maximum_year
FROM raw.knn_test_predictions;
GO

-- Validate the Gold country-year grain
SELECT
    country,
    [year],
    COUNT(1) AS record_count
FROM raw.gold_olive_yield
GROUP BY
    country,
    [year]
HAVING COUNT(1) > 1;
GO

-- Validate the prediction country-year-model grain
SELECT
    country,
    [year],
    model_name,
    COUNT(1) AS record_count
FROM raw.knn_test_predictions
GROUP BY
    country,
    [year],
    model_name
HAVING COUNT(1) > 1;
GO

-- Identify predictions without a matching Gold observation
SELECT
    p.country,
    p.[year],
    p.model_name
FROM raw.knn_test_predictions AS p
LEFT JOIN raw.gold_olive_yield AS g
    ON g.country = p.country
    AND g.[year] = p.[year]
WHERE g.country IS NULL;
GO

-- Check actual-yield consistency between both sources
SELECT
    p.country,
    p.[year],
    p.actual_yield,
    g.yield_kg_per_ha
FROM raw.knn_test_predictions AS p
INNER JOIN raw.gold_olive_yield AS g
    ON g.country = p.country
    AND g.[year] = p.[year]
WHERE ABS
(
    TRY_CONVERT(DECIMAL(18, 6), p.actual_yield)
    - TRY_CONVERT(DECIMAL(18, 6), g.yield_kg_per_ha)
) > 0.000001;
GO