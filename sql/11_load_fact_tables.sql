/*
Project: Climate Impact on Olive Yield
File: 11_load_fact_tables.sql
Purpose: Load and validate the olive yield and prediction fact tables.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Load the annual country-level fact table
IF NOT EXISTS
(
    SELECT 1
    FROM analytics.fact_olive_country_year
)
BEGIN
    INSERT INTO analytics.fact_olive_country_year
    (
        country_id,
        year_id,
        area_harvested_ha,
        production_tonnes,
        yield_kg_per_ha,
        mean_temperature_c,
        mean_dewpoint_c,
        mean_wind_speed_m_s,
        total_precipitation_mm,
        mean_solar_radiation_mj_m2,
        mean_soil_moisture_0_7cm,
        mean_soil_moisture_7_28cm,
        mean_soil_moisture_28_100cm,
        mean_soil_temperature_7_28cm_c,
        mean_soil_temperature_28_100cm_c,
        agricultural_land_pct,
        agriculture_value_added_pct_gdp,
        forest_area_pct,
        gdp_per_capita,
        population,
        rural_population_pct,
        temperature_change,
        previous_year_yield,
        yield_growth_rate,
        average_soil_moisture,
        average_soil_temperature,
        temperature_yearly_change,
        precipitation_yearly_change,
        soil_moisture_yearly_change
    )
    SELECT
        c.country_id,
        y.year_id,
        TRY_CONVERT(
            DECIMAL(18, 3),
            NULLIF(LTRIM(RTRIM(r.area_harvested_ha)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 3),
            NULLIF(LTRIM(RTRIM(r.production_tonnes)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.yield_kg_per_ha)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_temperature_c)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_dewpoint_c)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_wind_speed_m_s)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.total_precipitation_mm)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_solar_radiation_mj_m2)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_soil_moisture_0_7cm)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_soil_moisture_7_28cm)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_soil_moisture_28_100cm)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_soil_temperature_7_28cm_c)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.mean_soil_temperature_28_100cm_c)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.agricultural_land_pct)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.agriculture_value_added_pct_gdp)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.forest_area_pct)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.gdp_per_capita)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 0),
            NULLIF(LTRIM(RTRIM(r.population)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.rural_population_pct)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.temperature_change)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.previous_year_yield)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.yield_growth_rate)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.average_soil_moisture)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.average_soil_temperature)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.temperature_yearly_change)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.precipitation_yearly_change)), '')
        ),

        -- Convert scientific notation before applying decimal precision
        TRY_CONVERT(
            DECIMAL(18, 6),
            TRY_CONVERT(
                FLOAT,
                NULLIF(
                    REPLACE(
                        LTRIM(RTRIM(r.soil_moisture_yearly_change)),
                        CHAR(13),
                        ''
                    ),
                    ''
                )
            )
        )
    FROM raw.gold_olive_yield AS r
    INNER JOIN analytics.dim_country AS c
        ON c.country_name = LTRIM(RTRIM(r.country))
    INNER JOIN analytics.dim_year AS y
        ON y.year_number = TRY_CONVERT(
            SMALLINT,
            LTRIM(RTRIM(r.[year]))
        );
END;
GO

-- Load the yield-prediction fact table
IF NOT EXISTS
(
    SELECT 1
    FROM analytics.fact_yield_predictions
)
BEGIN
    INSERT INTO analytics.fact_yield_predictions
    (
        country_id,
        year_id,
        actual_yield,
        predicted_yield,
        prediction_error,
        absolute_error,
        absolute_percentage_error,
        model_name,
        dataset_split
    )
    SELECT
        c.country_id,
        y.year_id,
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.actual_yield)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.predicted_yield)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.prediction_error)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(LTRIM(RTRIM(r.absolute_error)), '')
        ),
        TRY_CONVERT(
            DECIMAL(18, 6),
            NULLIF(
                LTRIM(RTRIM(r.absolute_percentage_error)),
                ''
            )
        ),
        LTRIM(RTRIM(r.model_name)),
        NULLIF(
            REPLACE(
                LTRIM(RTRIM(r.dataset_split)),
                CHAR(13),
                ''
            ),
            ''
        )
    FROM raw.knn_test_predictions AS r
    INNER JOIN analytics.dim_country AS c
        ON c.country_name = LTRIM(RTRIM(r.country))
    INNER JOIN analytics.dim_year AS y
        ON y.year_number = TRY_CONVERT(
            SMALLINT,
            LTRIM(RTRIM(r.[year]))
        );
END;
GO

-- Validate fact-table row counts
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