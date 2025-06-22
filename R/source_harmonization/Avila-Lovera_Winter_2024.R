#
# Ávila-Lovera & Winter (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Avila-Lovera_Winter_2024/Table 1.xlsx", 
                            sheet = "Sheet1")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "gbark") |>
  dplyr::rename(originalName = "Species",
                Value = "gbark")|>
  dplyr::mutate(Trait = "Gbark",
                Value = as.numeric(Value),
                Units = "mmol m-2 s-1")|>
  dplyr::filter(!is.na(Value)) |>
  dplyr::select(originalName, Trait, Value, Units) |>
  dplyr::mutate(Reference = "Ávila-Lovera & Winter (2024) Variation in stem bark conductance to water vapor in Neotropical plant species. Frontiers in Forests and Global Change 17",
                DOI = "10.3389/ffgc.2023.1278803",
                Priority = 1) |>
  dplyr::arrange(originalName)

#Check units (mol s-1 m-2)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value/1000,
                Units = "mol s-1 m-2")
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Avila-Lovera_Winter_2024.rds")
