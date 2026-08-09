/*
Project: Climate Impact on Olive Yield
File: 08_create_dimensions.sql
Purpose: Create the country and year dimensions.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Create the country dimension
CREATE TABLE analytics.dim_country
(
    country_id INT IDENTITY(1, 1) NOT NULL,
    country_name NVARCHAR(100) NOT NULL,

    CONSTRAINT pk_dim_country
        PRIMARY KEY (country_id),

    CONSTRAINT uq_dim_country_name
        UNIQUE (country_name)
);
GO

-- Create the year dimension
CREATE TABLE analytics.dim_year
(
    year_id INT IDENTITY(1, 1) NOT NULL,
    year_number SMALLINT NOT NULL,

    CONSTRAINT pk_dim_year
        PRIMARY KEY (year_id),

    CONSTRAINT uq_dim_year_number
        UNIQUE (year_number)
);
GO

-- Verify dimension creation
SELECT
    TABLE_SCHEMA AS table_schema,
    TABLE_NAME AS table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'analytics'
  AND TABLE_NAME IN
  (
      'dim_country',
      'dim_year'
  )
ORDER BY TABLE_NAME;
GO