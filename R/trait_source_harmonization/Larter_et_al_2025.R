#
# Larter et al. (2025)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Larter_et_al_2025/nph70718-sup-0004-tables3.xlsx")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "MaxHeight", "P50_leaf", "P50_stem", "Kmax", "SLA") |>
  dplyr::rename(originalName = Species,
                Hmax = "MaxHeight",
                VCleaf_P50 = "P50_leaf",
                VCstem_P50 = "P50_stem",
                SLA = "SLA",
                Ks = "Kmax") |>
  dplyr::mutate(Hmax = as.numeric(Hmax)*(100.0), # From m to cm
                Ks = as.numeric(Ks) # kg m-1 MPa-1 s-1
                )|>
  dplyr::mutate(Reference = "Larter et al. 2025. Weak global trade-off between frost and drought resistance in trees. New Phytologist 249: 810-828",
                DOI = "https://doi.org/10.1111/nph.70718",
                Priority = 1) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Larter_et_al_2025.rds")
