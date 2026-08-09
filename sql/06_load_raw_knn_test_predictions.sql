/*
Project: Climate Impact on Olive Yield
File: 06_load_raw_knn_test_predictions.sql
Purpose: Load the KNN test predictions CSV into the raw table.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Prevent duplicate loading
IF NOT EXISTS
(
    SELECT 1
    FROM raw.knn_test_predictions
)
BEGIN
    BULK INSERT raw.knn_test_predictions
    FROM '<FULL_PATH_TO_KNN_PREDICTIONS_CSV>'
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
FROM raw.knn_test_predictions;
GO