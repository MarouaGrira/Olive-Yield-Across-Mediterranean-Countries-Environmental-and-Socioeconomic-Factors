/*
Project: Climate Impact on Olive Yield
File: 12_validate_dimensional_model.sql
Purpose: Validate the dimensional model and prediction metrics.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Validate dimensional-model row counts

SELECT
    'analytics.dim_country' AS table_name,
    COUNT(1) AS row_count
FROM analytics.dim_country

UNION ALL

SELECT
    'analytics.dim_year' AS table_name,
    COUNT(1) AS row_count
FROM analytics.dim_year

UNION ALL

SELECT
    'analytics.fact_olive_country_year' AS table_name,
    COUNT(1) AS row_count
FROM analytics.fact_olive_country_year

UNION ALL

SELECT
    'analytics.fact_yield_predictions' AS table_name,
    COUNT(1) AS row_count
FROM analytics.fact_yield_predictions;
GO

-- Validate the country-year grain

SELECT
    country_id,
    year_id,
    COUNT(1) AS record_count
FROM analytics.fact_olive_country_year
GROUP BY
    country_id,
    year_id
HAVING COUNT(1) > 1;
GO

-- Validate the country-year-model-split grain

SELECT
    country_id,
    year_id,
    model_name,
    dataset_split,
    COUNT(1) AS record_count
FROM analytics.fact_yield_predictions
GROUP BY
    country_id,
    year_id,
    model_name,
    dataset_split
HAVING COUNT(1) > 1;
GO

-- Validate expected null values

SELECT
    SUM(
        CASE
            WHEN agriculture_value_added_pct_gdp IS NULL THEN 1
            ELSE 0
        END
    ) AS agriculture_value_added_nulls,

    SUM(
        CASE
            WHEN gdp_per_capita IS NULL THEN 1
            ELSE 0
        END
    ) AS gdp_per_capita_nulls,

    SUM(
        CASE
            WHEN previous_year_yield IS NULL THEN 1
            ELSE 0
        END
    ) AS previous_year_yield_nulls,

    SUM(
        CASE
            WHEN yield_growth_rate IS NULL THEN 1
            ELSE 0
        END
    ) AS yield_growth_rate_nulls,

    SUM(
        CASE
            WHEN temperature_yearly_change IS NULL THEN 1
            ELSE 0
        END
    ) AS temperature_yearly_change_nulls,

    SUM(
        CASE
            WHEN precipitation_yearly_change IS NULL THEN 1
            ELSE 0
        END
    ) AS precipitation_yearly_change_nulls,

    SUM(
        CASE
            WHEN soil_moisture_yearly_change IS NULL THEN 1
            ELSE 0
        END
    ) AS soil_moisture_yearly_change_nulls

FROM analytics.fact_olive_country_year;
GO

-- Validate prediction metrics after SQL conversion

SELECT
    ROUND(
        AVG(absolute_error),
        3
    ) AS test_mae,

    ROUND(
        SQRT(
            AVG(
                CONVERT(
                    FLOAT,
                    prediction_error * prediction_error
                )
            )
        ),
        3
    ) AS test_rmse

FROM analytics.fact_yield_predictions;
GO