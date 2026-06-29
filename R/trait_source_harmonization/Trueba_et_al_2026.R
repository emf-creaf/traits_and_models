#
# Trueba et al. (2026)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv2(paste0(DB_path, "data-raw/raw_trait_data/Trueba_et_al_2026/dataverse_files/dataset_gmin_gmax_Trueba_etal_2026.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(spname, "gmin") |>
  dplyr::rename(originalName = spname,
                Value = "gmin") |>
  dplyr::mutate(Trait = "Gswmin",
                Value = as.numeric(Value)/1000,
                Units = "mol s-1 m-2",
                Level = "taxon")|>
  dplyr::mutate(Reference = "Trueba et al. (2026) Ecological drivers and phylogenetic patterns of leaf minimum
conductance variability in vascular plants. New Phytologist 250: 3716-3731",
                DOI = "10.1111/nph.71166",
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
saveRDS(db_post, "data/harmonized_trait_sources/Trueba_et_al_2026.rds")
