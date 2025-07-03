DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Tree foliar biomass (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("data-raw/raw_allometry_data/AllometrApp/tree_foliar_biomass_allometries_catalunya_2024-09-04.xlsx")
var_db <- allom_db |>
  dplyr::select(functional_group_level_name, equation, param_a, param_b, param_c, param_d, source) |>
  dplyr::rename(originalName = functional_group_level_name,
                Equation = equation,
                a = "param_a",
                b = "param_b",
                c = "param_c",
                d = "param_d",
                Reference = "source") |>
  dplyr::mutate(Equation = "FoliarBiomass = a·DBH^b·exp(c·BAL)·DBH^(d·BAL)",
                Response = "FoliarBiomass",
                ResponseDescription = "Foliar biomass (kg)",
                Predictor1 = "DBH",
                PredictorDescription1 = "Diameter at breast height (cm)",
                Predictor2 = "BAL",
                PredictorDescription2 = "Basal area of larger trees (m2/ha)",
                Priority = 1)

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "data/harmonized_allometry_sources/tree_foliar_biomass_catalonia.csv", row.names = FALSE)

