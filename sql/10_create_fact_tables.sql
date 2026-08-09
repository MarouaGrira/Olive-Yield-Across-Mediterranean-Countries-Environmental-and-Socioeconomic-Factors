/*
Project: Climate Impact on Olive Yield
File: 10_create_fact_tables.sql
Purpose: Create the olive yield and model prediction fact tables.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Create the annual country-level fact table
CREATE TABLE analytics.fact_olive_country_year
(
    olive_record_id INT IDENTITY(1, 1) NOT NULL,
    country_id INT NOT NULL,
    year_id INT NOT NULL,
    area_harvested_ha DECIMAL(18, 3) NULL,
    production_tonnes DECIMAL(18, 3) NULL,
    yield_kg_per_ha DECIMAL(18, 6) NULL,
    mean_temperature_c DECIMAL(18, 6) NULL,
    mean_dewpoint_c DECIMAL(18, 6) NULL,
    mean_wind_speed_m_s DECIMAL(18, 6) NULL,
    total_precipitation_mm DECIMAL(18, 6) NULL,
    mean_solar_radiation_mj_m2 DECIMAL(18, 6) NULL,
    mean_soil_moisture_0_7cm DECIMAL(18, 6) NULL,
    mean_soil_moisture_7_28cm DECIMAL(18, 6) NULL,
    mean_soil_moisture_28_100cm DECIMAL(18, 6) NULL,
    mean_soil_temperature_7_28cm_c DECIMAL(18, 6) NULL,
    mean_soil_temperature_28_100cm_c DECIMAL(18, 6) NULL,
    agricultural_land_pct DECIMAL(18, 6) NULL,
    agriculture_value_added_pct_gdp DECIMAL(18, 6) NULL,
    forest_area_pct DECIMAL(18, 6) NULL,
    gdp_per_capita DECIMAL(18, 6) NULL,
    population DECIMAL(18, 0) NULL,
    rural_population_pct DECIMAL(18, 6) NULL,
    temperature_change DECIMAL(18, 6) NULL,
    previous_year_yield DECIMAL(18, 6) NULL,
    yield_growth_rate DECIMAL(18, 6) NULL,
    average_soil_moisture DECIMAL(18, 6) NULL,
    average_soil_temperature DECIMAL(18, 6) NULL,
    temperature_yearly_change DECIMAL(18, 6) NULL,
    precipitation_yearly_change DECIMAL(18, 6) NULL,
    soil_moisture_yearly_change DECIMAL(18, 6) NULL,

    CONSTRAINT pk_fact_olive
        PRIMARY KEY (olive_record_id),

    CONSTRAINT uq_fact_olive
        UNIQUE (country_id, year_id),

    CONSTRAINT fk_fact_olive_country
        FOREIGN KEY (country_id)
        REFERENCES analytics.dim_country (country_id),

    CONSTRAINT fk_fact_olive_year
        FOREIGN KEY (year_id)
        REFERENCES analytics.dim_year (year_id)
);
GO

-- Create the yield-prediction fact table
CREATE TABLE analytics.fact_yield_predictions
(
    prediction_id INT IDENTITY(1, 1) NOT NULL,
    country_id INT NOT NULL,
    year_id INT NOT NULL,
    actual_yield DECIMAL(18, 6) NOT NULL,
    predicted_yield DECIMAL(18, 6) NOT NULL,
    prediction_error DECIMAL(18, 6) NOT NULL,
    absolute_error DECIMAL(18, 6) NOT NULL,
    absolute_percentage_error DECIMAL(18, 6) NOT NULL,
    model_name NVARCHAR(50) NOT NULL,
    dataset_split NVARCHAR(50) NOT NULL,

    CONSTRAINT pk_fact_predictions
        PRIMARY KEY (prediction_id),

    CONSTRAINT uq_fact_predictions
        UNIQUE
        (
            country_id,
            year_id,
            model_name,
            dataset_split
        ),

    CONSTRAINT fk_fact_predictions_country
        FOREIGN KEY (country_id)
        REFERENCES analytics.dim_country (country_id),

    CONSTRAINT fk_fact_predictions_year
        FOREIGN KEY (year_id)
        REFERENCES analytics.dim_year (year_id)
);
GO

-- Verify fact-table creation
SELECT
    TABLE_SCHEMA AS table_schema,
    TABLE_NAME AS table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'analytics'
  AND TABLE_NAME IN
  (
      'fact_olive_country_year',
      'fact_yield_predictions'
  )
ORDER BY TABLE_NAME;
GO