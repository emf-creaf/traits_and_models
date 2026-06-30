#
# Compilation FineFuelRatio 
#
harmonize_00_Compilation_FineFuelRatio <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_FineFuelRatio/FineFuelRatio.xlsx"), sheet =1)
  
  # r635 --------------------------------------------------
  db_var <- db |>
    dplyr::select(Species, r635, Source) |>
    dplyr::rename(originalName = Species,
                  Value = r635,
                  Reference = Source) |>
    dplyr::arrange(originalName) |>
    dplyr::mutate(Trait = "r635",
                  Units = NA,
                  Level = "population",
                  DOI = as.character(NA),
                  Priority = 1) |>
    dplyr::relocate(Trait, .before = Value) |>
    tibble::as_tibble()
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_FineFuelRatio.rds")
}

