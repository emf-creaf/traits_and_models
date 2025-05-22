#
# Larter et al 2023 unpublished
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path,"data-raw/raw_trait_data/unpublished_P50_Larter_2023/P50DB.xlsx"), sheet = 1)
head(db)
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "P50") |>
  dplyr::rename(originalName = Species,
                VCstem_P50 = "P50"
  ) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                Reference = "unpublished_P50_Larter_2023",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Larter_unpublished_2023.rds")

