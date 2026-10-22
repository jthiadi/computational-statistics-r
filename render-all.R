# Re-render every Quarto report.
# From the repository root, after install-packages.R:
#   Rscript render-all.R
#
# Each project folder is self-contained. This script cds into the folder
# before rendering so relative data paths (verizon.csv, auto-data.txt, …) work.

if (!requireNamespace("quarto", quietly = TRUE)) {
  stop(
    "The quarto R package is missing. Install it with install.packages('quarto'), ",
    "and install the Quarto CLI from https://quarto.org/docs/get-started/"
  )
}

root <- getwd()
qmd_files <- list.files(
  root,
  pattern = "\\.qmd$",
  recursive = TRUE,
  full.names = TRUE
)

if (length(qmd_files) == 0) {
  stop("No .qmd files found. Run this script from the repository root.")
}

for (qmd in qmd_files) {
  project_dir <- dirname(qmd)
  message("Rendering ", basename(project_dir), "/", basename(qmd))
  old <- setwd(project_dir)
  tryCatch(
    quarto::quarto_render(basename(qmd)),
    finally = setwd(old)
  )
}

message("Done. Open each folder's report.pdf (or the newly written PDF).")
