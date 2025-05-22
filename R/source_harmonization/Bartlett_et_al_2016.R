#
# Bartlett et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Bartlett_et_al_2016/pnas.1604088113.sd01.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Name, "Leaf P50 (MPa)", "Stem P50 (MPa)", "Stem P88 (MPa)", "Stem P12 (MPa)", 
                "Root P50 (MPa)", "Gs P50 (MPa)", "Gs 95 (MPa)") |>
  dplyr::rename(originalName = Name,
                VCleaf_P50 = "Leaf P50 (MPa)",
                VCstem_P50 = "Stem P50 (MPa)",
                VCstem_P12 = "Stem P12 (MPa)",
                VCstem_P88 = "Stem P88 (MPa)",
                VCroot_P50 = "Root P50 (MPa)",
                Gs_P50 = "Gs P50 (MPa)",
                Gs_P95 = "Gs 95 (MPa)") |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                originalName = stringr::str_replace(originalName, "Erigoonum", "Eriogonum"))|>
  dplyr::mutate(Reference = "Bartlett et al. (2016)",
                DOI = "10.1073/pnas.1604088113",
                Priority = 3)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2016.rds")
