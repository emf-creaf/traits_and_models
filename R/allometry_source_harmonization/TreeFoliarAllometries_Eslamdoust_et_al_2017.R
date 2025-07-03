WFO_file <- "../PlantTraitDatabases/WFO_Backbone/classification.csv"

# Tree foliar biomass (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("Sources/Eslamdoust_et_al_2017/Eslamdoust_et_al_2017.xlsx")
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
write.csv2(db_post, "Products/harmonized/tree_foliar_biomass_eslamdoust_et_al_2017.csv", row.names = FALSE)

