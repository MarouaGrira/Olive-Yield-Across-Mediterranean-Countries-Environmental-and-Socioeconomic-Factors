# 🌿 Olive Yield Across Mediterranean Countries: Environmental and Socioeconomic Factors

## Phase 2: SQL Data Pipeline and Dimensional Model

### Overview
This SQL phase transforms the outputs of the previous project notebooks into a validated, reporting-ready dimensional model for Power BI.

The workflow integrates the Gold dataset and final KNN test predictions, preserves the original source values in a raw layer, standardizes and structures the data for reporting, and validates the resulting dimensional model.

### SQL Objectives
- Preserve the notebook outputs in a dedicated raw-data layer.
- Integrate the Gold analytical dataset and final KNN test predictions.
- Build a dimensional model with shared country and year dimensions.
- Create fact tables for olive-yield observations and prediction results.
- Enforce consistent table grains and relational integrity.
- Validate data completeness, consistency, and prediction metrics.
- Prepare a reliable reporting layer for Power BI.

### Data Architecture
The SQL implementation follows a two-layer architecture:

- **Raw layer (`raw`)**: stores the Gold analytical dataset and final KNN test predictions as imported text values, preserving the source data before transformation.
- **Reporting layer (`analytics`)**: transforms and organizes the source data into shared dimensions and fact tables for Power BI reporting.

The `analytics` schema contains:
- `dim_country`: one record per country
- `dim_year`: one record per year
- `fact_olive_country_year`: olive-yield, climate, environmental, and socioeconomic measures at the country-year level
- `fact_yield_predictions`: actual yields, predicted yields, and prediction errors at the country-year-model-dataset-split level

### Pipeline Workflow
The pipeline moves data from notebook-generated CSV outputs to a Power BI-ready dimensional model through four stages:

1. **Ingestion**: Load the Gold analytical dataset and final KNN test predictions into dedicated raw tables.  
2. **Raw-data validation**: Check record counts, country and year coverage, duplicate grains, source alignment, and yield consistency.  
3. **Transformation and modeling**: Standardize source values and load shared country and year dimensions, followed by the olive-yield and prediction fact tables.  
4. **Model validation**: Verify table grains, selected null values, and prediction metrics before using the model for Power BI reporting.  

### Data Quality and Validation
Data-quality checks are applied across both the raw and reporting layers to verify that the dimensional model is complete, consistent, and aligned with its defined grain.

#### 1. Inbound Data & Structural Checks (Raw Layer)
* **Completeness**: Verified through row-count validations and full country-year coverage checks.
* **Grain Integrity**: Executed duplicate detection queries at the defined table grains to prevent data inflation.
* **Alignment & Sync**: Identified and flagged any KNN predictions lacking matching records in the Gold dataset, and verified actual-yield consistency across both imported sources.

#### 2. Relational & Analytical Checks (Dimensional Model)
* **Robustness**: Conducted targeted null-value checks for selected analytical fields to ensure reporting stability.
* **Model Accuracy**: Validated final prediction results directly within the database using SQL-calculated MAE and RMSE metrics.

### Repository Structure & Execution Order
The scripts are numbered sequentially according to their required execution order. 

```text
sql/
├── 📑 [PHASE 1: ENVIRONMENT & SCHEMA SETUP]
│   ├── 01_create_database.sql  
│   └── 02_create_schemas.sql  
├── 📥 [PHASE 2: INGESTION & RAW VALIDATION]
│   ├── 03_create_raw_gold_olive_yield.sql  
│   ├── 04_load_raw_gold_olive_yield.sql  
│   ├── 05_create_raw_knn_test_predictions.sql  
│   ├── 06_load_raw_knn_test_predictions.sql  
│   └── 07_validate_raw_data.sql  
├── 🛠️ [PHASE 3: TRANSFORMATION & MODELING]
│   ├── 08_create_dimensions.sql  
│   ├── 09_load_dimensions.sql  
│   ├── 10_create_fact_tables.sql  
│   └── 11_load_fact_tables.sql  
└── ✅ [PHASE 4: BI VALIDATION]
    └── 12_validate_dimensional_model.sql  
```

The validated dimensional model produced in this SQL phase will serve as the data foundation for the next stage of the project: developing the Power BI reporting layer.


### Locally Testing the SQL Pipeline
1. Open **SQL Server Management Studio (SSMS)** and connect to your SQL Server instance.
2. Clone this repository locally and open the scripts located in the `sql/` directory.
3. Execute the scripts sequentially from `01_create_database.sql` through `12_validate_dimensional_model.sql` within SSMS.
4. Review the Messages and Results tabs in SSMS after running the final validation script to verify successful database constraint enforcement and model metric replication.

### Developer
This data pipeline, database schema design, and quality validation framework were independently engineered by **Maroua Grira**. For my full professional profile, project responsibilities, and contact links, please visit the [Main Project README](../README.md#author--contact).

### Open-Source Licensing
This project is open-source and distributed under the **MIT License**. You are free to inspect, reproduce, and adapt the underlying database schemas, staging architectures, or validation queries for your own portfolios or engineering tasks. A star ⭐️ on this repository is highly appreciated if you find these frameworks valuable!

*Disclaimer: Core baseline statistics remain dependent on the open data policies governing FAOSTAT, ECMWF Copernicus, and the World Bank Group.*