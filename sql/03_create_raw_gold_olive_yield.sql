/*
Project: Climate Impact on Olive Yield
File: 03_create_raw_gold_olive_yield.sql
Purpose: Create the raw table used to import the olive yield dataset.
*/

USE Climate_Impact_Olive_Yield;
GO

CREATE TABLE raw.gold_olive_yield
(
    country                            NVARCHAR(100) NULL,
    [year]                             NVARCHAR(20) NULL,
    area_harvested_ha                  NVARCHAR(100) NULL,
    production_tonnes                  NVARCHAR(100) NULL,
    yield_kg_per_ha                    NVARCHAR(100) NULL,
    mean_temperature_c                 NVARCHAR(100) NULL,
    mean_dewpoint_c                    NVARCHAR(100) NULL,
    mean_wind_speed_m_s                NVARCHAR(100) NULL,
    total_precipitation_mm             NVARCHAR(100) NULL,
    mean_solar_radiation_mj_m2         NVARCHAR(100) NULL,
    mean_soil_moisture_0_7cm           NVARCHAR(100) NULL,
    mean_soil_moisture_7_28cm          NVARCHAR(100) NULL,
    mean_soil_moisture_28_100cm        NVARCHAR(100) NULL,
    mean_soil_temperature_7_28cm_c     NVARCHAR(100) NULL,
    mean_soil_temperature_28_100cm_c   NVARCHAR(100) NULL,
    agricultural_land_pct              NVARCHAR(100) NULL,
    agriculture_value_added_pct_gdp    NVARCHAR(100) NULL,
    forest_area_pct                    NVARCHAR(100) NULL,
    gdp_per_capita                     NVARCHAR(100) NULL,
    population                         NVARCHAR(100) NULL,
    rural_population_pct               NVARCHAR(100) NULL,
    temperature_change                 NVARCHAR(100) NULL,
    previous_year_yield                NVARCHAR(100) NULL,
    yield_growth_rate                  NVARCHAR(100) NULL,
    average_soil_moisture              NVARCHAR(100) NULL,
    average_soil_temperature           NVARCHAR(100) NULL,
    temperature_yearly_change          NVARCHAR(100) NULL,
    precipitation_yearly_change        NVARCHAR(100) NULL,
    soil_moisture_yearly_change        NVARCHAR(100) NULL
);
GO

-- Verify table creation
SELECT
    TABLE_SCHEMA AS table_schema,
    TABLE_NAME AS table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'raw'
  AND TABLE_NAME = 'gold_olive_yield';
GO