#
# Pan et al. (2026)
#

harmonize_Pan_et_al_2026 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Pan_et_al_2026/New Phytologist NPH-MS-2026-55394 DATA.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_P50 <- db |>
    dplyr::select(Species, P50) |>
    dplyr::rename(originalName = Species,
                  Value = P50)|>
    dplyr::mutate(Value = -Value,
                  Trait = "VCstem_P50",
                  Units = "MPa",
                  Level = "individual",
                  Method = "OV")|>
    dplyr::relocate(Trait, .before = Value) |>
    tibble::as_tibble()
  db_WD <- db |>
    dplyr::select(Species, WD) |>
    dplyr::rename(originalName = Species,
                  Value = WD)|>
    dplyr::mutate(Trait = "WoodDensity",
                  Units = "g cm-3",
                  Level = "individual")|>
    dplyr::relocate(Trait, .before = Value) |>
    tibble::as_tibble()
  db_var <- dplyr::bind_rows(db_P50, db_WD) |>
    dplyr::mutate(Reference = "Pan et al. (2026) Evidence for a trade-off between growth rate and xylem embolism resistance in 22 Eucalyptus species",
                  DOI = "https://doi.org/10.1111/nph.71345",
                  Priority = 1)|>
    tibble::as_tibble()
  
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Pan_et_al_2026.rds")
}

