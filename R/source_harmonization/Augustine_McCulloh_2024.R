#
# Augustine & McCulloh (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
fn <- file.path(DB_path, "data-raw/raw_trait_data/Augustine_McCulloh_2024/Finaldata.csv")
db <- readr::read_csv("data-raw/raw_trait_data/Augustine_McCulloh_2024/Finaldata.csv", na = "N/A")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, Vcmax, Jmax, LMA.ai, LMA.aci, osm, elast, tlp, awf, Wd, kmax, lasa, p50, p12, slope) |>
  dplyr::rename(originalName = Species,
                Vmax = Vcmax,
                LeafPI0 = osm,
                LeafEPS = elast,
                Ptlp = tlp,
                LeafAF = awf,
                WoodDensity = Wd,
                Ks = kmax,
                Al2As = lasa,
                VCstem_P50 = p50,
                VCstem_P12 = p12,
                VCstem_slope = slope) |>
  dplyr::mutate(Vmax = Vmax*LMA.aci,
                Jmax = Jmax*LMA.ai,
                Al2As = 100*Al2As,
                VCstem_P12 = -VCstem_P12,
                VCstem_P50 = -VCstem_P50) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "P. banksiana", "Pinus banksiana"),
                originalName = stringr::str_replace(originalName, "P. resinosa", "Pinus resinosa"),
                originalName = stringr::str_replace(originalName, "P. strobus", "Pinus strobus"),
                Reference = "Augustine & McCulloh (2024). Physiological trait coordination and variability across and within  three Pinus species. New Phytologist.",
                Priority = 1)|>
  dplyr::select(-LMA.aci, -LMA.ai) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Augustine_McCulloh_2024.rds")
