#
# Sjoman et al 2018 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")
# 
# DB_path <- "/Users/nicolasmartin/Documents/Developpement/PlantTraitDatabases/"
# WFO_path <- "/Users/nicolasmartin/Documents/Developpement/"

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path,"Sources/Sjoman_et_al_2018_TLP_UrbanTree/Sjoman_2018_Summer.csv"), locale = readr::locale("fr"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "TLP") |>
  dplyr::rename(originalName = Species,
                Ptlp = "TLP") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference <- "Sjöman et al. 2018"
db_var$Priority <- 1

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Sjoman_et_al_2018.rds")
