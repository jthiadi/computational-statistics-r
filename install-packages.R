# Install the R packages this repo needs.
# From the repository root:
#   Rscript install-packages.R
#
# Requires R >= 4.1 (compstatslib depends on it).

repos <- "https://cloud.r-project.org"

cran_packages <- c(
  "tidyr",
  "ggplot2",
  "readxl",
  "psych",
  "car",
  "rpart",
  "rpart.plot",
  "knitr",
  "rmarkdown"
)

installed <- rownames(installed.packages())
missing <- setdiff(cran_packages, installed)
if (length(missing) > 0) {
  install.packages(missing, repos = repos)
}

if (!requireNamespace("compstatslib", quietly = TRUE)) {
  if (!requireNamespace("devtools", quietly = TRUE)) {
    install.packages("devtools", repos = repos)
  }
  # Course visualization helpers: CI plots, interactive regression, PCA, moderation
  devtools::install_github("compstatslib/compstatslib", upgrade = "never")
}

message("R packages are installed.")
message("PDF reports also need the Quarto CLI: https://quarto.org/docs/get-started/")
message("After Quarto is installed, run:  Rscript render-all.R")
