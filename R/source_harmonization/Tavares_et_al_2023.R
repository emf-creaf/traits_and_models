#
# Tavares et al. (2023)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Tavares_et_al_2023/Data_package_Tavares_et_al_2023/Data/Hydraulic_traits_dataset_TAVARES_et_al_2023.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, p50, p88, wd_b) |>
  dplyr::rename(originalName = Species,
                VCstem_P50 = "p50",
                VCstem_P88 = "p88",
                WoodDensity = wd_b) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(VCstem_P50 = as.numeric(VCstem_P50),
                VCstem_P88 = as.numeric(VCstem_P88),
                WoodDensity = as.numeric(WoodDensity),
                Reference = "Tavares et al. (2023). Basin-wide variation in tree hydraulic safety margins predicts the carbon balance of Amazon forests. Nature 617: 111-116",
                DOI = "10.1038/s41586-023-05971-3",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Tavares_et_al_2023.rds")
