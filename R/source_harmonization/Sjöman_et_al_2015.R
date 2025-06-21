#
# Sjoman et al 2015 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- read.table(paste0(DB_path,"data-raw/raw_trait_data/Sjoman_et_al_2015/Sjoman_2015_Summer_Acer_OK.csv"), sep=";", dec=".", h=T)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "TLP") |>
  dplyr::rename(originalName = Species,
                Value = "TLP") |>
  dplyr::mutate(Trait = "Ptlp",
                Units = "MPa") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_var$Reference <- "Sjoman et al. (2015) Urban forest resilience through tree selection - Variation in drought tolerance in Acer. Urban Forestry & Urban Greening 14: 858-865"
db_var$DOI <- "10.1016/j.ufug.2015.08.004"
db_var$Priority <- 1
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Sjoman_et_al_2015.rds")
