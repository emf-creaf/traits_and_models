#
# Wang et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_xlsx(paste0(DB_path, "data-raw/raw_trait_data/Wang_et_al_2024/Wang_et_al_2024.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::rename(originalName = Species,
                Gswmin = "gmin_mmol",
                Gswmax = "gmax_mmol") |>
  dplyr::mutate(Gswmin = as.numeric(Gswmin)/1000,
                Gswmax = as.numeric(Gswmax)/1000)|>
  dplyr::mutate(Reference = "Wang et al. (2024) Water loss after stomatal closure: quantifying leaf  minimum conductance and minimal water use in nine  temperate European tree species during a severe drought. Tree Physiology, 44, tpae027",
                DOI = "10.1093/treephys/tpae027",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Wang_et_al_2024.rds")
