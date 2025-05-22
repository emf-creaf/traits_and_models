#
# Lens et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Lens_et_al_2016/Lens_2016_P50_all_species_updated_FINAL_version3.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("species...4", "P50", reference) |>
  dplyr::rename(originalName = "species...4",
                VCstem_P50 = "P50",
                Reference = reference) |>
  dplyr::mutate(Priority = 2) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_var$Reference[db_var$Reference=="this study"] <- "Lens et al. 2016"

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Lens_et_al_2016.rds")
