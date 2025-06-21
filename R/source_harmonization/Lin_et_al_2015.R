#
# Lin et al. (2015)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Lin_et_al_2015/g1_Lin_et_al_2015.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::rename(originalName = "Species") |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Trait = "g1_Medlyn",
                Value = as.numeric(g1_Medlyn),
                Units = as.character(NA)) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-g1_Medlyn) |>
  dplyr::mutate(Reference = "Lin et al. (2015) Optimal stomatal behaviour around the world. Nature Climate Change",
                DOI = "10.1038/nclimate2550",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Lin_et_al_2015.rds")
