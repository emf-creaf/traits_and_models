#
# Pisek & Adamson (2020)
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path,"Sources/Pisek_Adamson_2020/Pisek_Adamson_2020_DiB.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "measurement", "Reference") |>
  dplyr::rename(LeafAngle = "measurement")|>
  dplyr::mutate(LeafAngle = as.numeric(LeafAngle),
                Units = "degrees") |>
  dplyr::rename(originalName = "Species")|>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName)


# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Pisek_Adamson_2020_LeafAngle.rds")
