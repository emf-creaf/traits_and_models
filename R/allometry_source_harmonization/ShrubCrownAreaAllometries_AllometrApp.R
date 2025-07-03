WFO_file <- "../PlantTraitDatabases/WFO_Backbone/classification.csv"

# Shrub crown area (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("Sources/AllometrApp/shrub_crown_area_allometries_catalonia_2024-09-05.xlsx")
var_db <- allom_db[1:27,] |>
  dplyr::select(functional_group_level_name, equation, param_a, param_b) |>
  dplyr::rename(originalName = functional_group_level_name,
                Equation = equation,
                a = "param_a",
                b = "param_b") |>
  dplyr::mutate(Equation = "CrownArea = a·Ht^b",
                Response = "CrownArea",
                ResponseDescription = "Crown area (cm2)",
                Predictor1 = "Ht",
                PredictorDescription1 = "Shrub total height (cm)",
                Reference = "De Cáceres et al. (2019). Scaling-up individual-level allometric equations to predict stand-level fuel loading in Mediterranean shrublands. Ann. For. Sci. 76: 87",
                Priority = 1) |>
  dplyr::filter(!is.na(a))

# To remove authors
var_db$originalName <- unlist(lapply(var_db$originalName, function(x) {paste(strsplit(x, " ")[[1]][1:2], collapse = " ")}) )

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "Products/harmonized/shrub_crown_area_catalonia.csv", row.names = FALSE)

