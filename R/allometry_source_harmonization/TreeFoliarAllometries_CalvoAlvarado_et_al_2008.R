DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Tree foliar biomass (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("data-raw/raw_allometry_data/Calvo-Alvarado_et_al_2008/Calvo-Alvarado_et_al_2008.xlsx")
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
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "data/harmonized_allometry_sources/tree_foliar_biomass_calvoalvarado_et_al_2024.csv", row.names = FALSE)

