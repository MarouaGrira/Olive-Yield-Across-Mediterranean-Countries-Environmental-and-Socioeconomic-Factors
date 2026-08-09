# 🌿 Olive Yield Across Mediterranean Countries: Environmental and Socioeconomic Factors

## Phase 3: Power BI Analytical Reporting & Semantic Model

### Overview
This operational phase maps the validated data assets from the PostgreSQL dimensional model into a high-performance, two-page interactive analytics layer. 

The dashboard serves as an enterprise business intelligence tool enabling multi-dimensional user-driven slicing across 11 Mediterranean nations (2000–2024). It bridges the gap between descriptive regional data and production machine learning diagnostics by visualizing out-of-sample KNN model performance on a single screen.

**Key Architectural Highlight:** The report implements advanced **cascading parameter sync** logic. Selecting a category dynamically switches the underlying visual calculation target between **Olive Yield** and **Yield Growth Rate**, preventing invalid data comparisons and enforcing strict analytical logic directly within the user interface.

### Power BI Objectives
- **Dynamic Variable Ingestion**: Construct high-utility field parameters to collapse complex cross-filtering options into zero-clutter visualization modules.
- **Context-Aware Analytics**: Engineer DAX metrics capable of evaluating cross-sectional statistical formulas (e.g., Pearson correlation, Coefficients of Variation) entirely in-memory.
- **ML Auditing & Validation Portal**: Deliver a production-grade model validation matrix tracking spatial-temporal error tracking (MAE, RMSE, Bias).
- **User-Centric Visual Engineering**: Enforce absolute control over selected variables grouped by busienss questions, dynamic titles, responsive unit scaling, and visual interaction cross-filtering boundaries and selected data to present.

### Data Architecture & Semantic Model Description
To guarantee fast query performance and clean DAX execution, the report establishes a decoupled **Star Schema** architecture utilizing dedicated structural elements:

#### Dimension Tables:
- `analytics dim_country`: Shared country dimension providing uniform geographic filtering.
- `analytics dim_year`: Shared temporal dimension enabling granular time-series evaluation.

#### Fact Tables:
- `analytics fact_olive_country_year`: Dense matrix of consolidated agricultural (FAOSTAT), meteorological (ERA5), and financial (World Bank) variables at the country-year grain.
- `analytics fact_yield_predictions`: Granular ML diagnostic tracking mapping observed values, KNN predictions, signed bias, and absolute errors.

#### Field Parameters:
- `Outcome Metric`: Decouples chart Y-axes to dynamically pivot reporting elements between *Yield*, *Production*, *Harvested Area*, and *Growth Rate* without duplicate visuals.
- `Factor Selector`: Acts as a dynamic slicer feeding the correlation engine with multi-domain indicators on demand.


### Production Dashboard Interfaces

#### Page 1: Historical Performance & Yield Associations
Engineered to deliver instantaneous regional benchmarking combined with automated variable correlation exploration.
- **Executive Performance Matrix**: A dedicated high-visibility KPI indicator board displaying fixed historical baselines:
  - *Olive Yield Leader*: Egypt (**9,018 kg/ha**)
  - *Olive Production Leader*: Spain (**6.36 Mt/year**)
  - *Steepest Upward Yield Trend*: Egypt (**+186.3 kg/ha/yr**)
  - *Steepest Downward Yield Trend*: Italy (**-51.8 kg/ha/yr**)
  - *Most Stable Yield*: Greece (**11.6% CoV**)
  - *Most Variable Yield*: Portugal (**57.5% CoV**)
- **Dynamic Trend Analysis Module**: A fully parametric line chart driven by concurrent *Metric*, *Country*, and *Period* slicers. It handles multi-select slicing, scales numeric boundaries on the fly, and uses context-aware natural language processing in titles to reflect the user's active filter path.
- **Statistical Yield Association Map**: A customized horizontal correlation chart evaluating Pearson Correlation Coefficients on a strict boundary of **−1.00 to +1.00**. Uses rule-based conditional color rules to partition directional signals:
  - Aggregated features (*Climate*, *Soil*, *Socioeconomic*) are mapped against **Olive Yield**.
  - Year-over-year rate modifications are mapped against **Yield Growth Rate**.

#### Page 2: KNN Prediction Performance
A dedicated machine learning diagnostic portal evaluating model precision during the held-out **2020–2024 test window**.
- **Interactive Fit Diagnostics**: A responsive line chart mapping *Actual Yield* (Solid Line, Circles) against *KNN Predictions* (Dashed Line, Diamonds), filtering instantly down to localized country views via user selection.
- **Spatial Error Breakdown**: A structured ranking bar chart sorting mean absolute errors by country, allowing developers to isolate regional blind spots.
- **Temporal Error Anomaly Matrix**: A dense reporting matrix plotting absolute country-year prediction errors. Implements precise threshold conditional formatting to flag data anomalies (Pale green for optimal convergence, Amber for intermediate variance, and Muted red for model divergence).
- *Null-Handling Principle: Missing prediction slots are maintained as structural blanks to prevent zero-error calculation skews.*


### Advanced BI Engineering & DAX Inventory
The dashboard showcases high-level semantic engineering through programmatic calculations rather than primitive drag-and-drop visuals:
- **Statistical DAX Engineering**: Hand-coded measures calculating time-series linear trend slopes, mathematical Coefficients of Variation (CoV = σ / μ), and cross-table country-specific Pearson correlations running dynamically over variable filter contexts.
- **Filter Context Isolation**: Advanced utilization of `CALCULATE`, `ALLSELECTED`, and iterator functions (`SUMX`, `MAEX`) to evaluate global baseline variances while maintaining user slicing capabilities.
- **UI/UX Optimization**: Multi-tier dependent slicer trees, automated chart formatting rules, and strict control over visual interactive behaviors to safeguard core benchmark logic.


### Repository & Semantic Model Structure
The internal semantic model is built using a professional enterprise star-schema design, separating logic into dedicated dimensions, facts, and parametric controls:

```text
dashboard/
├── 📊 Mediterranean_Olive_Yield_Dashboard.pbix  # Single-file interactive deployment application
└── 📂 Semantic Model (Internal Architecture)
    ├── 🧮 Measure_Table                         # Folder-organized table isolating all custom DAX measures
    │   ├── 📁 01 - Performance Highlights       # Baseline KPI algorithms and trend slopes
    │   ├── 📁 02 - Trend Analysis               # Parametric axis formatting calculations
    │   ├── 📁 03 - Yield Associations           # In-memory Pearson correlation calculations
    │   └── 📁 04 - KNN Prediction               # ML evaluation errors (MAE, RMSE, Bias, R²)
    ├── 📋 analytics dim_country                 # Geographic dimension table
    ├── 📋 analytics dim_year                    # Temporal dimension table
    ├── 📊 analytics fact_olive_co...            # Comprehensive observation fact table
    ├── 📊 analytics fact_yield_pr...            # Machine learning inference fact table
    ├── ⚙️ Factor Selector                       # Parametric correlation pointer variable
    └── ⚙️ Outcome Metric                        # Parametric visual axis pointer variable
```

### Locally Testing the Deployment
1. Download the standalone `Mediterranean_Olive_Yield_Dashboard.pbix` application file from this directory.
2. Open the file utilizing **Power BI Desktop** (Free production client required).
3. Toggle tabs to navigate between the operational analysis layer and the machine learning performance portal.
4. Test cross-filtering by toggling metric parameters to observe corresponding runtime title changes and matrix conditional variations.

### Developer
This analytics dashboard was completely designed, modeled, and engineered by **Maroua Grira**. For a detailed overview of my engineering competencies, underlying data pipelines, or to reach out regarding open opportunities, please review the [Main Project README](../README.md#author--contact).

### Open-Source Licensing
This project is open-source and distributed under the **MIT License**. You are free to inspect, reproduce, and adapt the underlying DAX logic or architectural patterns for your own portfolios or engineering tasks. A star ⭐️ on this repository is highly appreciated if you find these frameworks valuable!

*Disclaimer: Core baseline statistics remain dependent on the open data policies governing FAOSTAT, ERA5 Copernicus, and the World Bank Group.*
