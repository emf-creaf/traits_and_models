harmonize_TreeFoliarAllometries_Eslamdoust_et_al_2017 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Tree foliar biomass (from Eslamdoust) ---------------------------------------
  allom_db  <- readxl::read_xlsx("data-raw/raw_allometry_data/Eslamdoust_et_al_2017/Eslamdoust_et_al_2017.xlsx")
  var_db <- allom_db |>
    dplyr::select(-R2) |>
    dplyr::rename(originalName = Species,
                  Reference = Source) |>
    dplyr::mutate(Response = "FoliarBiomass",
                  ResponseDescription = "Foliar biomass (kg)",
                  Predictor1 = "DBH",
                  PredictorDescription1 = "Diameter at breast height (cm)",
                  Priority = 2)
  
  db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
  
  db_post <- db_post |>
    dplyr::mutate(checkVersion = checkVersion)
  
  traits4models::check_harmonized_allometry(db_post)
  write.csv2(db_post, "data/harmonized_allometry_sources/tree_foliar_biomass_eslamdoust_et_al_2017.csv", row.names = FALSE)
  
}
