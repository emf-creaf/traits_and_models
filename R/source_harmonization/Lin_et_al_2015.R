#
# Lin et al. (2015)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Lin_et_al_2015/g1_Lin_et_al_2015.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::rename(originalName = "Species") |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(g1_Medlyn = as.numeric(g1_Medlyn),
                Reference = "Lin et al. (2015)",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Lin_et_al_2015.rds")
