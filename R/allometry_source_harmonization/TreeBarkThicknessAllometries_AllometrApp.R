DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Tree bark thickness (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("data-raw/raw_allometry_data/AllometrApp/tree_bark_thickness_allometries_catalonia_2023-05-24.xlsx")
var_db <- allom_db |>
  dplyr::select(functional_group_level_name, equation, param_a, param_b, source) |>
  dplyr::rename(originalName = functional_group_level_name,
                Equation = equation,
                a = "param_a",
                b = "param_b",
                Reference = "source") |>
  dplyr::mutate(Equation = "BarkThickness = a·DBH^b",
                Response = "BarkThickness",
                ResponseDescription = "Bark thickness (mm)",
                Predictor1 = "DBH",
                PredictorDescription1 = "Diameter at breast height (cm)",
                Priority = 1)

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "data/harmonized_allometry_sources/tree_bark_thickness_catalonia.csv", row.names = FALSE)

