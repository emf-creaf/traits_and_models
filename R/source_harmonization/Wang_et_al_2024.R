#
# Wang et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_xlsx(paste0(DB_path, "Sources/Wang_et_al_2024/Wang_et_al_2024.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::rename(originalName = Species,
                Gswmin = "gmin_mmol",
                Gswmax = "gmax_mmol") |>
  dplyr::mutate(Gswmin = as.numeric(Gswmin)/1000,
                Gswmax = as.numeric(Gswmax)/1000)|>
  dplyr::mutate(Reference = "Wang et al. (2024)",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Wang_et_al_2024.rds")
