# 🌿 Olive Yield Across Mediterranean Countries: Environmental and Socioeconomic Factors

**An end-to-end data engineering, machine learning, and business intelligence repository modeling environmental and socioeconomic drivers of olive cultivation across 11 Mediterranean nations (2000–2024).**


## Project Overview

This workspace unifies multi-domain agricultural, climatic, and financial datasets at a uniform Country-Year grain. The pipeline tracks long-term historical baseline trends and short-term year-over-year rate changes, evaluating crop yield predictability via an optimized K-Nearest Neighbors (KNN) regression framework using a rigorous train-test validation split. The final phase delivers advanced business intelligence reporting, leveraging parametric visual analytics, in-memory statistical scripting, and a dedicated machine learning diagnostic portal built entirely within Power BI.

The system is engineered as a unified, three-tier modular pipeline:
1. **Data Consolidation, Engineering & Machine Learning (`/notebooks`)**: Multi-source collection, temporal harmonization, feature engineering, and predictive modeling.
2. **Relational Database Modeling (`/sql`)**: Star-schema mapping and strict data grain quality enforcement via SSMS.
3. **Business Intelligence Reporting (`/dashboard`)**: Parametric visual analytics, in-memory statistical scripting, and a dynamic machine learning diagnostic portal via Power BI—featuring cascading parameter sync logic that automatically switches the visual target context between *Olive Yield* and *Yield Growth Rate* based on the selected metric domain.

The final analytical dataset is fully standardized at a strict **Country-Year** observation grain.


## Data Sources & Features
This project unifies multi-domain agricultural, climate, and socio-economic data obtained from authoritative public sources. All datasets are standardized, harmonized, and integrated at a uniform Country-Year observation grain covering the 2000–2024 period.

### 1. FAOSTAT (Baseline Agricultural Statistics)
* **Source**: [FAOSTAT Portal](https://fao.org)
* **Key Features**: Country, Year, Olive production (tonnes), Harvested area (hectares), and Yield (kg/ha).

### 2. ERA5 Climate & Soil Data (Copernicus Climate Data Store)
* **Source**: [Copernicus CDS](https://copernicus.eu)
* **Key Meteorological Features**: 
  * country, year
  * temperature (°C)
  * Dew point temperature (°C)
  * Wind speed (m/s)
  * precipitation (mm)
  * solar radiation (MJ/m²)
* **Key Soil & Agrometeorological Features**:
  * soil moisture (0–7cm layer)
  * soil moisture (7–28cm layer)
  * soil moisture (28–100cm layer)
  * soil temperature (7–28cm layer, °C)
  * soil temperature (28–100cm layer, °C)

### 3. World Bank Open Data (Socio-Economic & Land-Use)
* **Source**: [World Bank Data](https://worldbank.org)
* **Key Features**: Country, Year, Population (number of people), GDP per capita (current US$), Agricultural land (% of total land area), Forest area (% of total land area), Rural population (% of total population), and Agriculture value added (% of GDP).


## Core Research Questions Addressed
* **Climate Drivers**: How do temperature, precipitation, and solar radiation fluctuations affect regional olive yield?
* **Socioeconomic Impact**: To what extent do demographic shifts, country-level wealth (GDP), and agricultural land use influence olive yield trends?
* **Regional Variations**: How do historical baseline trends, long-term production stability, and year-over-year changes vary across the 11 selected countries?
* **Predictive Accuracy**: Can integrated environmental and economic parameters accurately predict future olive yield within a train-test validation framework?


## Medallion Data Architecture & File Inventory

The project workflow employs a Medallion Data Architecture to ingest, clean, aggregate, and enrich multi-domain tabular data into high-utility reporting layers.

```text
  [ FAOSTAT ]       [ ERA5 Copernicus ]     [ World Bank WDI ]
       │                     │                      │
       └─────────────────────┼──────────────────────┘
                             ▼
                        1. Bronze Layer  <── [Raw Data Storage]
                             │
                             ▼
                        2. Silver Layer  <── [Cleaned Monthly Data / Standardized Indexing]
                             │
                             ▼
                        3. Gold Layer    <── [Enriched Annual Dataset / Feature Engineering]
```


### 1. Bronze Layer (`/data/bronze`)
Stores completely untouched, raw extraction files fetched directly from authoritative public sources to ensure absolute data lineage.
* `faostat_olives_bronze.csv`: Raw production baseline values from the FAOSTAT Portal.
* `era5_olive_bronze_monthly.csv`: Raw monthly atmospheric and meteorological data extractions from the Copernicus Climate Data Store.
* `worldbank_olive_bronze.csv`: Raw macroeconomic metrics from the World Bank Open Data API.

### 2. Silver Layer (`/data/silver`)
This layer handles the core data engineering, multi-source synchronization, and initial enrichment, unifying separate data streams into a consistent format backed by automated data quality validation and consistency checks.
* `faostat_olives_silver.csv`: Aligned baseline agricultural output matrix containing olive production (tonnes), harvested area (hectares), and crop yield (kg/ha).
* `era5_olive_silver_monthly.csv` & `era5_olive_silver_yearly.csv`: Processed atmospheric timelines tracking mean temperature (°C), dew point temperature (°C), wind speed (m/s), solar radiation (MJ/m²), and total precipitation (mm). Includes integrated multi-depth agrometeorological soil layers: Mean Soil Moisture and Mean Soil Temperature at 0–7cm, 7–28cm, and 28–100cm depths.
* `worldbank_olive_silver.csv`: Standardized country-level development indicators tracking population (number of people), GDP per capita (current US$), agricultural land (% of total land area), forest area (% of total land area), rural population (% of total population), and agriculture value added (% of GDP).
* `integrated_olive_silver.csv`: Initial consolidated joint table structurally mapping all three multi-domain sources at a uniform spatial-temporal index.
* `temperature_change_annual.csv`: Enriched environmental indicator tracking annual surface temperature change anomalies calculated relative to the 1951–1980 historical baseline.
* `integrated_silver_enriched.csv`: Final combined, multi-domain silver layer incorporating baseline datasets and temperature anomalies before targeted ML feature preparation.

### 3. Gold Layer (`/data/gold`)
This layer applies advanced feature engineering to the enriched data, computing specialized climate stress indicators and advanced meteorological metrics. It creates the finalized, analytics-ready foundation used directly across downstream analysis and modeling phases.
* `gold_olive_dataset.csv`: The final, feature-engineered dataset containing consolidated agricultural, socioeconomic, and calculated climate stress metrics structured at the strict Country-Year grain.

## Dataset Enrichment & Feature Engineering Phase

After the initial integration of the primary tabular datasets, the analytical pipeline executes a secondary enrichment and feature engineering phase to construct the finalized Gold Layer, maximizing machine learning predictive performance:

### 1. External Data Enrichment (Notebook 1)
* FAOSTAT Temperature Change Indicator (°C): The baseline integrated rows are enriched by appending annual temperature change metrics calculated relative to the 1951–1980 historical climatological baseline to isolate localized warming trends.

### 2. Algorithmic Feature Engineering (Notebook 2)
Instead of relying purely on raw source variables, the dataset is enriched with custom engineered features calculated directly within the pipeline:
* Advanced Climate Metrics: Custom calculations capturing interactions between atmospheric parameters and multi-depth soil states, such as matching surface temperatures with deep soil temperatures.
* Climate Stress Indicators: Engineered threshold metrics designed to isolate extreme weather anomalies, seasonal variations, and moisture stress trends impacting olive cultivation over time.

## Repository Workflow & System Directories

The workspace is modularly segregated into clear execution phases, mirroring standard enterprise product lifecycles.

### Phase 1: Core Notebooks & Machine Learning Execution (`/notebooks`)
A sequential pipeline of production-commented Jupyter Notebooks carrying out data processing and predictive inference:
* `01_data_collection_and_consolidation.ipynb`: Handles raw multi-source ingestion, executes structural data quality checks, aligns disparate schemas, appends the external FAOSTAT Temperature Change baseline anomalies, and exports the clean Bronze and Silver data layers.
* `02_gold_dataset_engineering.ipynb`: Computes custom temporal aggregations, engineers advanced climate metrics, integrates environmental stress variables, and delivers the finalized Gold dataset.
* `03_exploratory_data_analysis.ipynb`: Runs comprehensive descriptive statistical modules, maps climate-yield interactions, and builds multi-country baseline comparison charts.
* `04_predictive_modeling.ipynb`: Executes statistical feature selection, trains the K-Nearest Neighbors (KNN) regression models, evaluates model fit errors against previous-year baselines, and logs out-of-sample model metrics (MAE, RMSE, Bias, R²).

### Phase 2: Relational Modeling & Validation (`/sql`)
Migrates the analytical Gold tables and machine learning predictions into Microsoft SQL Server to enforce referential integrity and run database quality checks.
* Scripts `01` through `12`: Numbered sequentially within SQL Server Management Studio (SSMS) to automate environment instantiation, staging table indexing, shared dimension schema loading (`dim_country`, `dim_year`), and fact table normalization (`fact_olive_country_year`, `fact_yield_predictions`).
* Database Auditing: Hand-coded relational validation routines checking for orphans, table grains, and verifying machine learning score persistence directly using T-SQL.
* For setup steps and database code details, review the dedicated [SQL Sub-README](./sql/README.md).

### Phase 3: Interactive Visual Intelligence (`/dashboard`)
Encapsulates the standalone reporting layer built directly over the validated database schemas.
* `Mediterranean_Olive_Yield_Dashboard.pbix`: A fully dynamic, single-file Power BI deployment leveraging an optimized semantic star schema.
* Technical Implementations: Contains custom folder-organized DAX measures tables, advanced field parameters for runtime X/Y axis switching, dependent filter cascading trees, and a complete conditional machine learning error tracking matrix.
* For visual explanations and DAX details, review the dedicated [Power BI Sub-README](./dashboard/README.md).

## How to Run the Pipeline Locally

### 1. Python Environment Initialization
Ensure you have Python 3.10+ running locally. Clone the repository and install all environmental dependencies:
```bash
pip install -r requirements.txt
```
Execute notebooks `01` through `04` in sequence to regenerate data states and model output logs.

### 2. Database Schema Deployment
1. Fire up SQL Server Management Studio (SSMS).
2. Navigate to the `/sql` directory, load the scripts, and run files `01_create_database.sql` through `12_validate_dimensional_model.sql` sequentially to seed the analytics tables.

### 3. Report Ingestion
Open `Mediterranean_Olive_Yield_Dashboard.pbix` via Power BI Desktop to explore interactive filters, review data relationships in the Model View, or test visual parametric toggles.


## Future Roadmap

The current deployment serves as a robust analytics baseline. To scale the predictive accuracy and operational scope of the pipeline, the following developmental iterations are planned:
* Time-Horizon Expansion via Feature Optimization: Filtering and removing time-limiting socioeconomic or climatic variables that exhibit high missing-value thresholds (over 60% missing records prior to 2000) to safely expand the remaining core dataset across a longer, multi-decade historical training window.
* Statistical Multi-Matrix Auditing: Integrating Spearman and Kendall rank matrices directly into the reporting layer to flag non-linear agrometeorological relationships identified by variance gaps in the Pearson models.
* Deep Feature Engineering: Incorporating multi-month lag structures to evaluate the delayed impact of seasonal winter soil moisture configurations on subsequent harvest-year yields.


## Author & Contact

This end-to-end data system was entirely designed, architected, and engineered by **Maroua Grira**.

**Core Production Competencies Demonstrated:**
* Data Engineering: Multi-source ETL pipelines, schema harmonization, and custom time-series temporal aggregation engines.
* Database Administration: SQL database scripting, Star Schema architecture modeling, relational constraints, and database quality audits.
* Machine Learning: Linear feature selection, K-Nearest Neighbors (KNN) training, and statistical model evaluation.
* Business Intelligence: Advanced enterprise DAX development, Field Parameters, cascading user interaction patterns, and data storytelling.

**Connect with me:**
* Email: [grira.maroua@gmail.com]

## MIT Open-Source License

This project is open-source and distributed under the **MIT License**. You are fully encouraged to review the code, clone the storage layers, and adapt the underlying python code, database queries, or DAX models for your own portfolios or engineering tasks. A repository star is highly appreciated if you find these design frameworks useful!

*Note: Core baseline dataset files remain governed by the respective open-data policies and citation mandates of FAOSTAT, ECMWF Copernicus, and the World Bank Group.*
