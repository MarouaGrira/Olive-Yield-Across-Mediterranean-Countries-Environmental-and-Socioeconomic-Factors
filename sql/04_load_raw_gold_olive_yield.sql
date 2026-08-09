/*
Project: Climate Impact on Olive Yield
File: 04_load_raw_gold_olive_yield.sql
Purpose: Load the olive yield CSV into the raw table.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Prevent duplicate loading
IF NOT EXISTS
(
    SELECT 1
    FROM raw.gold_olive_yield
)
BEGIN
    BULK INSERT raw.gold_olive_yield
    FROM '<FULL_PATH_TO_GOLD_CSV>'
    WITH
    (
        FORMAT = 'CSV',
        FIRSTROW = 2,
        FIELDQUOTE = '"',
        CODEPAGE = '65001',
        ROWTERMINATOR = '0x0a'
    );
END;
GO

-- Validate the imported volume
SELECT
    COUNT(1) AS imported_rows
FROM raw.gold_olive_yield;
GO

-- Preview the imported data
SELECT TOP (10)
    country,
    [year],
    production_tonnes,
    yield_kg_per_ha
FROM raw.gold_olive_yield;
GO