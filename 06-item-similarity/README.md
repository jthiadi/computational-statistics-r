# Item similarity and recommendations

PicCollage sticker-bundle recommendations (cosine, correlation, adjusted cosine) plus clicked-point correlation scenarios.

## Run

From this folder, after installing packages from the repo root (`Rscript install-packages.R`):

```bash
quarto render analysis.qmd
quarto render correlation-scenarios.qmd
```

`piccollage_accounts_bundles.csv` and the `pts_*.rds` files are included.

## Optional local files (gitignored)

`best_books_ever.csv` and `description_embeddings.rds` are large (~70–90 MB). They are not loaded by the committed scripts, so they are not required to reproduce the reports.
