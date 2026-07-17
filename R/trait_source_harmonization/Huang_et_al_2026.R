#
# Huang et al 2026 -----
#

harmonize_Huang_et_al_2026 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Huang_et_al_2026/nph71412-sup-0001-datasets1.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_StemP12 <- db |>
    dplyr::select(Species, "Species", "P12") |>
    dplyr::rename(originalName = Species,
                  Value = P12) |>
    dplyr::mutate(Value = -exp(as.numeric(Value)), # Given as log(abs(Psi))
                  Trait = "VCstem_P12",
                  Units = "MPa",
                  Method = "DH",
                  Level = "individual") |>
    dplyr::filter(!is.na(Value)) 
  db_StemP50 <- db |>
    dplyr::select(Species, "Species", "P50") |>
    dplyr::rename(originalName = Species,
                  Value = P50) |>
    dplyr::mutate(Value = -exp(as.numeric(Value)), # Given as log(abs(Psi))
                  Trait = "VCstem_P50",
                  Units = "MPa",
                  Method = "DH",
                  Level = "individual") |>
    dplyr::filter(!is.na(Value)) 
  db_StemP88 <- db |>
    dplyr::select(Species, "Species", "P88") |>
    dplyr::rename(originalName = Species,
                  Value = P88) |>
    dplyr::mutate(Value = -exp(as.numeric(Value)), # Given as log(abs(Psi))
                  Trait = "VCstem_P88",
                  Units = "MPa",
                  Method = "DH",
                  Level = "individual") |>
    dplyr::filter(!is.na(Value)) 
  db_var <- dplyr::bind_rows(db_StemP12, db_StemP50, db_StemP88) |>
    dplyr::relocate(Value, .after = Trait) |>
    dplyr::relocate(Level, .after = Value) |>
    dplyr::relocate(Method, .after = Level) |>
    dplyr::mutate(Value = as.numeric(Value),
                  Reference = "Huang et al. (2026) Host hydraulics constrain mistletoe resistance to drought-induced embolism. New Phytologist",
                  DOI = "10.1111/nph.71412",
                  Priority = 1) |>
    dplyr::relocate(Priority, .after = Method) |>
    dplyr::arrange(originalName)|>
    tibble::as_tibble()
    
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  

  # Checking and storing -----------------------------------------------------------------
  if(traits4models::check_harmonized_trait(db_post)) saveRDS(db_post, "data/harmonized_trait_sources/Huang_et_al_2026.rds")
}
