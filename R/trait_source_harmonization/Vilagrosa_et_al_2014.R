#
# Vilagrosa et al. (2014)
#

harmonize_Vilagrosa_et_al_2024 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  # Read database -----------------------------------------------------------
  db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Vilagrosa_et_al_2014/vilagrosa2014.xlsx"))
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::rename(originalName = Species,
                  Value = "TLP") |>
    dplyr::mutate(Trait = "Ptlp",
                  Value = as.numeric(Value),
                  Units = "MPa",
                  Level = "population",
                  Method = "pressure-volume",
                  Reference = "Vilagrosa et al. (2014). Physiological differences explain the co-existence of different
regeneration strategies in Mediterranean ecosystems. New Phytologist 201: 1277-1288",
                  DOI = "10.1111/nph.12584",
                  Priority = 1)|>
    dplyr::relocate(Trait, .before = Value) |>
    tibble::as_tibble()
  
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Vilagrosa_et_al_2014.rds")
}


