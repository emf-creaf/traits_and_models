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
                Ptlp = "TLP") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference <- "Sjöman et al. (2018) Improving confidence in tree species selection for challenging urban sites: a role for leaf turgor loss. Urban Tree 21:1171-1188"
db_var$DOI <- "10.1007/s11252-018-0791-5"
db_var$Priority <- 1

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Sjoman_et_al_2018.rds")
