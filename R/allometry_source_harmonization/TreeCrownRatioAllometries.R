DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

cr_models <- openxlsx::read.xlsx("data-raw/raw_allometry_data/TreeAllometries/TreeAllometries.xlsx",
                                 sheet= "Tree_CR_models")

var_db <- cr_models |>
  dplyr::rename(originalName = "Name",
                a = "a_cr",
                b = "b_1cr",
                c = "b_2cr",
                d = "b_3cr",
                e = "c_1cr",
                f = "c_2cr",
                Reference = "Source") |>
  dplyr::mutate(Equation = "CrownRatio = 1/(1 + exp(a + b·HD + c·(H/100) + d·DBH^2 + e·BAL + f·ln(CCF)))",
                Response = "CrownRatio",
                ResponseDescription = "Crown ratio",
                Predictor1 = "HD",
                PredictorDescription1 = "Height-diameter ratio (m·m-1)",
                Predictor2 = "H",
                PredictorDescription2 = "Tree height (m)",
                Predictor3 = "DBH",
                PredictorDescription3 = "Diameter at breast height (cm)",
                Predictor4 = "BAL",
                PredictorDescription4 = "Basal area of larger trees",
                Predictor5 = "CCF",
                PredictorDescription5 = "Crown competition factor",
                Priority = 1) |>
  dplyr::relocate(Reference, .after = PredictorDescription5)

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "data/harmonized_allometry_sources/tree_crown_ratio_europe.csv", row.names = FALSE)
