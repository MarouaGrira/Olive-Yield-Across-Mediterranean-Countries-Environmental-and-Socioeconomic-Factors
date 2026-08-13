/*
Project: Climate Impact on Olive Yield
File: 05_create_raw_knn_test_predictions.sql
Purpose: Create the raw table for KNN test predictions.
*/

USE Climate_Impact_Olive_Yield;
GO

-- Create the raw KNN prediction table
CREATE TABLE raw.knn_test_predictions
(
    country								NVARCHAR(100) NULL,
    [year]								NVARCHAR(20) NULL,
    actual_yield						NVARCHAR(100) NULL,
    predicted_yield						NVARCHAR(100) NULL,
    prediction_error					NVARCHAR(100) NULL,
    absolute_error						NVARCHAR(100) NULL,
    absolute_percentage_error			NVARCHAR(100) NULL,
    model_name							NVARCHAR(100) NULL,
    dataset_split						NVARCHAR(100) NULL
);
GO

-- Verify table creation
SELECT
    TABLE_SCHEMA AS table_schema,
    TABLE_NAME AS table_name
FROM INFORMATION_SCHEMA.TABLES
WHERE TABLE_SCHEMA = 'raw'
  AND TABLE_NAME = 'knn_test_predictions';
GO