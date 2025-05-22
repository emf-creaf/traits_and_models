#
# Zhu et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Zhu_et_al_2016/Zhu_et_al_2016_data.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, P50_leaf, P50_branch, K_s, Source) |>
  dplyr::rename(originalName = Species,
                VCleaf_P50 = P50_leaf,
                VCstem_P50 = P50_branch,
                Ks = K_s,
                Reference = Source) |>
  dplyr::mutate(VCleaf_P50 = as.numeric(VCleaf_P50),
                Priority = 3) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()


# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Zhu_et_al_2016.rds")
