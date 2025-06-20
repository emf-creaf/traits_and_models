#
# Sjoman et al 2018 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Sjoman_et_al_2018_TLP_UrbanTree/Sjoman_2018_Summer.csv"), locale = readr::locale("fr"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "TLP") |>
  dplyr::rename(originalName = Species,
                Value = "TLP") |>
  dplyr::mutate(Trait = "Ptlp",
                Units = "MPa") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::mutate(Reference = "Sjöman et al. (2018) Improving confidence in tree species selection for challenging urban sites: a role for leaf turgor loss. Urban Tree 21:1171-1188",
                DOI = "10.1007/s11252-018-0791-5",
                Priority = 1) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)
# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Sjoman_et_al_2018.rds")
