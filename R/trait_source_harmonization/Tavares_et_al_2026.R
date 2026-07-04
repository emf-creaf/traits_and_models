#
# Tavares et al 2026 -----
#

harmonize_Tavares_et_al_2026 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  # Read database -----------------------------------------------------------
  db <- readr::read_delim("data-raw/raw_trait_data/Tavares_et_al_2026/Dataset_Tavares_et_al_2026_Functional_Ecology.csv", 
                   delim = ";", escape_double = FALSE, trim_ws = TRUE)
  
  # Variable harmonization --------------------------------------------------
  db_StemP50 <- db |>
    dplyr::select(Species, "Species", "P50") |>
    dplyr::rename(originalName = Species,
                  Value = P50) |>
    dplyr::mutate(Trait = "VCstem_P50",
                  Units = "MPa",
                  Method = "OV",
                  Level = "individual") |>
    dplyr::filter(!is.na(Value)) 
  db_conduit2sapwood <- db |>
    dplyr::select(Species, "Species", "RAPfrac") |>
    dplyr::rename(originalName = Species,
                  Value = RAPfrac) |>
    dplyr::mutate(Trait = "conduit2sapwood",
                  Units = as.character(NA),
                  Method = as.character(NA),
                  Level = "individual",
                  Value = 1-Value) |> # From fraction of parenchyma to fraction of conduits
    dplyr::filter(!is.na(Value)) 

  db_var <- dplyr::bind_rows(db_StemP50, db_conduit2sapwood) |>
    dplyr::relocate(Value, .after = Trait) |>
    dplyr::relocate(Level, .after = Value) |>
    dplyr::relocate(Method, .after = Level) |>
    dplyr::mutate(Value = as.numeric(Value),
                  Reference = "Tavares et al. (2026) Wood anatomical trait correlations with hydraulic efficiency and safety in an aseasonal wet tropical forest. Functional Ecology",
                  DOI = "10.1111/1365-2435.70381",
                  Priority = 1) |>
    dplyr::relocate(Priority, .after = Method) |>
    dplyr::arrange(originalName)|>
    tibble::as_tibble()
    
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  

  # Checking and storing -----------------------------------------------------------------
  if(traits4models::check_harmonized_trait(db_post)) saveRDS(db_post, "data/harmonized_trait_sources/Tavares_et_al_2026.rds")
}
