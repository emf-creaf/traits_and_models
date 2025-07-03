WFO_file <- "../PlantTraitDatabases/WFO_Backbone/classification.csv"

cw_models <- openxlsx::read.xlsx("Sources/TreeAllometries/TreeAllometries.xlsx",
                                 sheet= "Tree_CW_models")

var_db <- cw_models |>
  dplyr::rename(originalName = "Name",
                a = "a_cw",
                b = "b_cw",
                Reference = "Source") |>
  dplyr::mutate(Equation = "CrownWidth = a·DBH^b",
                Response = "CrownWidth",
                ResponseDescription = "Crown width (m)",
                Predictor1 = "DBH",
                PredictorDescription1 = "Diameter at breast height (cm)",
                Priority = 1) |>
  dplyr::relocate(Reference, .after = PredictorDescription1)

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "Products/harmonized/tree_crown_width_europe.csv", row.names = FALSE)
