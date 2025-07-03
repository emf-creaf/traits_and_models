WFO_file <- "../PlantTraitDatabases/WFO_Backbone/classification.csv"

# Shrub total fuel biomass (from AllometrApp) ---------------------------------------
allom_db  <- readxl::read_xlsx("Sources/AllometrApp/shrub_total_biomass_allometries_catalonia_2024-09-05.xlsx")
var_db <- allom_db[1:27,] |>
  dplyr::select(functional_group_level_name, equation, param_a, param_b) |>
  dplyr::rename(originalName = functional_group_level_name,
                Equation = equation,
                a = "param_a",
                b = "param_b") |>
  dplyr::mutate(Equation = "TotalBiomass = a·PHV^b",
                Response = "TotalBiomass",
                ResponseDescription = "Total biomass (kg)",
                Predictor1 = "PHV",
                PredictorDescription1 = "Phytovolume (m3)",
                Reference = "De Cáceres et al. (2019). Scaling-up individual-level allometric equations to predict stand-level fuel loading in Mediterranean shrublands. Ann. For. Sci. 76: 87",
                Priority = 1) |>
  dplyr::filter(!is.na(a))

# To remove authors
var_db$originalName <- unlist(lapply(var_db$originalName, function(x) {paste(strsplit(x, " ")[[1]][1:2], collapse = " ")}) )

db_post <- traits4models::harmonize_taxonomy_WFO(var_db, WFO_file)
traits4models::check_harmonized_allometry(db_post)
write.csv2(db_post, "Products/harmonized/shrub_total_biomass_catalonia.csv", row.names = FALSE)

