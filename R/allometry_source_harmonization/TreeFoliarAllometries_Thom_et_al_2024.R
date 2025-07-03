WFO_file <- "../PlantTraitDatabases/WFO_Backbone/classification.csv"

# Tree foliar biomass (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("Sources/Thom_et_al_2024/all_species_database.xlsx")
var_db <- allom_db |>
  dplyr::select(name, bmFoliage_a, bmFoliage_b) |>
  dplyr::rename(originalName = name,
                a = "bmFoliage_a",
                b = "bmFoliage_b") |>
  dplyr::mutate(Equation = "FoliarBiomass = a·DBH^b",
                Response = "FoliarBiomass",
                ResponseDescription = "Foliar biomass (kg)",
                Predictor1 = "DBH",
                PredictorDescription1 = "Diameter at breast height (cm)",
                Reference = "Thom et al. (2024). Parameters of 150 temperate and boreal tree species and provenances for an individual-based forest landscape and disturbance model. Data in Brief 55: 110662",
                Priority = 2) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "Quercus pubescence", "Quercus pubescens"))


db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "Products/harmonized/tree_foliar_biomass_thom_et_al_2024.csv", row.names = FALSE)

