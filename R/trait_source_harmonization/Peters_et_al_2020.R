#
# Peters et al 2020 -----
#

harmonize_Peters_et_al_2020 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Peters_et_al_2020/Peters_et_al_Table_S1_completed.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_RootP50 <- db |>
    dplyr::select(Species, "Genus", "Species", "Root_P50", "Method", "Reference") |>
    dplyr::mutate(originalName = paste(Genus, Species),
                  Trait = "VCroot_P50",
                  Units = "MPa",
                  Level = "individual") |>
    dplyr::rename(Value = "Root_P50") |>
    dplyr::filter(!is.na(Value)) 
  db_RootP12 <- db |>
    dplyr::select(Species, "Genus", "Species", "Root_P12", "Method", "Reference") |>
    dplyr::mutate(originalName = paste(Genus, Species),
                  Trait = "VCroot_P12",
                  Units = "MPa",
                  Level = "individual") |>
    dplyr::rename(Value = "Root_P12") |>
    dplyr::filter(!is.na(Value)) 
  db_StemP50 <- db |>
    dplyr::select(Species, "Genus", "Species", "Stem_P50", "Method", "Reference") |>
    dplyr::mutate(originalName = paste(Genus, Species),
                  Trait = "VCstem_P50",
                  Units = "MPa",
                  Level = "individual") |>
    dplyr::rename(Value = "Stem_P50") |>
    dplyr::filter(!is.na(Value)) 
  db_StemP12 <- db |>
    dplyr::select(Species, "Genus", "Species", "Stem_P12", "Method", "Reference") |>
    dplyr::mutate(originalName = paste(Genus, Species),
                  Trait = "VCstem_P12",
                  Units = "MPa",
                  Level = "individual") |>
    dplyr::rename(Value = "Stem_P12") |>
    dplyr::filter(!is.na(Value)) 
  
  db_var <- dplyr::bind_rows(db_RootP12, db_RootP50, db_StemP12, db_StemP50) |>
    dplyr::select(-Genus, -Species) |>
    dplyr::rename(originalReference = Reference) |>
    dplyr::relocate(Value, .after = Trait) |>
    dplyr::relocate(Level, .after = Value) |>
    dplyr::relocate(Method, .after = Level) |>
    dplyr::mutate(Reference = "Peters et al. (2020) Non-invasive imaging reveals convergence in root and stem vulnerability to cavitation across five tree species. Journal of Experimental Botany  71: 6623-6637",
                  DOI = "10.1111/plb.13355",
                  Priority = 1,
                  Method = dplyr::case_when(Method == "IM" ~ "OV", # IM/OV=imaging
                                            Method == "AD" ~ "AD", # AD = air-injection
                                            Method == "CE" ~ "CE", # CE = centrifuge
                                            Method == "AE" ~ "AE", # AE = acoustic emissions
                                            Method == "DH" ~ "DH") # DH = dehydration
                  ) |>
    dplyr::relocate(originalReference, .after = DOI) |>
    dplyr::relocate(Priority, .after = Method) |>
    dplyr::arrange(originalName)|>
    tibble::as_tibble()
    
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Peters_et_al_2020.rds")
}
