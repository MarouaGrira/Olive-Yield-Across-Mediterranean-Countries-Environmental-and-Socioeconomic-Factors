/*
Project: Climate Impact on Olive Yield
File: 02_create_schemas.sql
Purpose: Create schemas for raw and analysis-ready data.
*/

USE Climate_Impact_Olive_Yield;
GO

CREATE SCHEMA raw;
GO

CREATE SCHEMA analytics;
GO

-- Verify schema creation
SELECT
    name AS schema_name
FROM sys.schemas
WHERE name IN ('raw', 'analytics')
ORDER BY name;
GO