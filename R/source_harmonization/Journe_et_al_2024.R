#
# Journé et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Journe_et_al_2024/finalFile_maturation.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("speciesN", "TSM", "DBHmax") |>
  dplyr::rename(originalName = speciesN,
                Dmat = "TSM",
                Dmax = "DBHmax") |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "_", " ")) |>
  dplyr::mutate(Reference = "Journé et al. (2024). The Relationship Between Maturation Size and Maximum Tree Size From Tropical to Boreal Climates. Ecol. Lett. 27",
                DOI = "10.1111/ele.14500",
                Priority = 2)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Journe_et_al_2024.rds")
