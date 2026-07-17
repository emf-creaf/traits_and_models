
harmonize_TreeFoliarAllometries_AllometrApp <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Tree foliar biomass (from AllometrApp) ---------------------------------------
  allom_db1  <- readxl::read_xlsx("data-raw/raw_allometry_data/AllometrApp/tree_foliar_biomass_allometries_catalunya_2024-09-04.xlsx") |>
    dplyr::filter(source!="Calculated IEFC")
  var_db1 <- allom_db1 |>
    dplyr::select(functional_group_level_name, equation, param_a, param_b, param_c, source) |>
    dplyr::rename(originalName = functional_group_level_name,
                  Equation = equation,
                  a = "param_a",
                  b = "param_b",
                  c = "param_c",
                  Reference = "source") |>
    dplyr::mutate(Equation = "FoliarBiomass = a·DBH^b",
                  Response = "FoliarBiomass",
                  ResponseDescription = "Foliar biomass (kg)",
                  Predictor1 = "DBH",
                  PredictorDescription1 = "Diameter at breast height (cm)",
                  Predictor2 = "BAL",
                  PredictorDescription2 = "Basal area of larger trees (m2/ha)",
                  Priority = 1)
  
  
  allom_db2  <- readxl::read_xlsx("data-raw/raw_allometry_data/AllometrApp/BF_fDBH&BA_MCA.xlsx")
  var_db2 <- allom_db2 |>
    dplyr::select(SP, a_exp, b, c) |>
    dplyr::rename(originalName = "SP",
                  a = "a_exp",
                  b = "b",
                  c = "c")|>
    dplyr::mutate(Equation = "FoliarBiomass = a·DBH^b·exp(c·BAL)",
                  Reference = "Calculated IEFC",
                  Response = "FoliarBiomass",
                  ResponseDescription = "Foliar biomass (kg)",
                  Predictor1 = "DBH",
                  PredictorDescription1 = "Diameter at breast height (cm)",
                  Predictor2 = "BAL",
                  PredictorDescription2 = "Basal area of larger trees (m2/ha)",
                  Priority = 1)
  
  var_db <- dplyr::bind_rows(var_db1, var_db2)
  
  db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file) 
  
  db_post <- db_post |>
    dplyr::mutate(checkVersion = checkVersion)
  
  traits4models::check_harmonized_allometry(db_post)
  
  write.csv2(db_post, "data/harmonized_allometry_sources/tree_foliar_biomass_catalonia.csv", row.names = FALSE)
  
}
