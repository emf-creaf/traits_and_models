#
# Pisek & Adamson (2020)
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Pisek_Adamson_2020/Pisek_Adamson_2020_DiB.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "measurement", "Reference") |>
  dplyr::rename(Value = "measurement")|>
  dplyr::mutate(Trait = "LeafAngle",
                Value = as.numeric(Value),
                Units = "degree") |>
  dplyr::rename(originalName = "Species")|>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = "10.1016/j.dib.2020.106391") |>
  dplyr::mutate(Priority = 1)

traits4models::check_harmonized_trait(db_var)
# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Pisek_Adamson_2020_LeafAngle.rds")
