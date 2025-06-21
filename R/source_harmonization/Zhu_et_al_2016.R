#
# Zhu et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Zhu_et_al_2016/Zhu_et_al_2016_data.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, P50_leaf, P50_branch, K_s, Source) |>
  dplyr::rename(originalName = Species,
                VCleaf_P50 = P50_leaf,
                VCstem_P50 = P50_branch,
                Ks = K_s,
                OriginalReference = Source) |>
  dplyr::mutate(VCleaf_P50 = as.numeric(VCleaf_P50)) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Zhu et al. (2016). Are leaves more vulnerable to cavitation than branches? Functional Ecology, 30, 1740-1744",
                DOI = "10.1111/1365-2435.12656", 
                Priority = 3) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()


# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Zhu_et_al_2016.rds")
