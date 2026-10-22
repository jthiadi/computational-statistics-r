# Computational Statistics in R

Resampling inference, similarity-based recommendations, regression (including moderation, mediation, PCA, and factor analysis), and ensemble prediction — implemented in R. Each folder is a self-contained project with its data, source, and a pre-rendered `report.pdf`.

## Reproduce

**Need:** [R](https://cran.r-project.org/) 4.1 or newer. PDF reports also need the [Quarto CLI](https://quarto.org/docs/get-started/) and a LaTeX engine (Quarto can install TinyTeX on first render).

From the repository root:

```bash
Rscript install-packages.R
```

That installs CRAN packages plus [`compstatslib`](https://github.com/compstatslib/compstatslib) from GitHub (`plot_sample_ci()`, `interactive_regression()`, `interactive_pca()`, moderation plots).

Run a single project from **inside its folder** so relative data paths resolve:

```bash
cd 01-descriptive-statistics
Rscript analysis.R
```

```bash
cd 05-permutation-tests
quarto render analysis.qmd
```

Re-render every Quarto report:

```bash
Rscript render-all.R
```

Interactive click-to-add gadgets are already saved as `.rds` files, so reruns do not need the Shiny viewer. Scripts that draw random samples set `set.seed()`.

Pre-rendered `report.pdf` files are committed so you can read results without Quarto.

## Projects

| Folder | What it does | Source | Data |
| --- | --- | --- | --- |
| [`01-descriptive-statistics`](01-descriptive-statistics) | Order statistics, mean/sd, histogram, density, and boxplot of customer ages | `analysis.R` | `customers.txt` |
| [`02-distributions-and-binning`](02-distributions-and-binning) | Mixture vs symmetric densities; Sturges, Scott, and Freedman–Diaconis bin widths | `analysis.R`, `histogram-bins.R` | simulated |
| [`03-standardization-and-bootstrap`](03-standardization-and-bootstrap) | z-scores, sampling coverage of CIs, bootstrap CI for first-booking time of day | `analysis.R` | `first_bookings_datetime_sample.txt` |
| [`04-bootstrap-inference`](04-bootstrap-inference) | t-tests vs bootstrap tests and CIs for Verizon repair times | `analysis.qmd` | `verizon.csv`, `audit.txt` |
| [`05-permutation-tests`](05-permutation-tests) | Long-format reshape, permutation test, Wilcoxon statistic, QQ plot | `analysis.qmd` | `verizon_wide.csv`, `page_loads.csv` |
| [`06-item-similarity`](06-item-similarity) | Cosine / correlation recommendations for PicCollage bundles; correlation scatter scenarios | `analysis.qmd` | `piccollage_accounts_bundles.csv`, `pts_*.rds` |
| [`07-linear-regression`](07-linear-regression) | Geometry of OLS (SSR/SSE/SST, \(R^2\)); programmer salaries; Auto MPG | `analysis.qmd` | `programmer_salaries.txt`, `auto-data.txt`, `sim_*.rds` |
| [`08-applied-regression`](08-applied-regression) | Log transforms, VIF / multicollinearity, origin-specific slopes | `analysis.qmd` | `auto-data.txt` |
| [`09-moderation-mediation`](09-moderation-mediation) | Weight as moderator of acceleration→MPG; cylinders→weight→MPG mediation | `analysis.qmd` | `auto-data.txt` |
| [`10-principal-components`](10-principal-components) | PCA on collinear car-size variables and on security-attitude items | `analysis.qmd` | `auto-data.txt`, `security_questions.xlsx` |
| [`11-factor-analysis`](11-factor-analysis) | Parallel analysis, principal-axis factors, varimax rotation | `analysis.qmd` | `security_questions.xlsx` |
| [`12-cross-validation`](12-cross-validation) | In-sample MSE, train/test split, k-fold CV, regression trees | `analysis.qmd` | `auto-data.txt` |
| [`13-bagging-boosting`](13-bagging-boosting) | OLS vs trees; LOOCV; bagging and boosting; depth / learning-rate search | `analysis.qmd` | `insurance.csv` |

## Packages

| Package | Used for |
| --- | --- |
| **base R** | Most of the resampling, regression algebra, and plots |
| `tidyr` | Wide-to-long reshape |
| `car` | VIF |
| `ggplot2`, `readxl`, `psych` | Factor analysis and scree plots |
| `rpart`, `rpart.plot` | Regression trees and ensembles |
| `compstatslib` | Sampling-CI plots and interactive regression / PCA / moderation |

See `install-packages.R` for the install commands.
