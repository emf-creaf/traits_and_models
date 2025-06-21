#
# Bartlett et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Bartlett_et_al_2016/pnas.1604088113.sd01.csv"))


# Stem VC -----------------------------------------------------------------
db_var <- db |>
  dplyr::select(Name, "Stem P50 (MPa)", "Stem P88 (MPa)", "Stem P12 (MPa)", 
                "Reference (for Stem hydraulic traits)") |>
  dplyr::rename(originalName = Name,
                VCstem_P50 = "Stem P50 (MPa)",
                VCstem_P12 = "Stem P12 (MPa)",
                VCstem_P88 = "Stem P88 (MPa)",
                OriginalReference = "Reference (for Stem hydraulic traits)") |>
  dplyr::filter(!is.na(VCstem_P12) | !is.na(VCstem_P50) | !is.na(VCstem_P88)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                originalName = stringr::str_replace(originalName, "Erigoonum", "Eriogonum"))|>
  dplyr::mutate(Reference = "Bartlett et al. (2016)",
                DOI = "10.1073/pnas.1604088113",
                Priority = 3)|>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2016_StemVC.rds")


# VCleaf_P50 -----------------------------------------------------------------
db_var <- db |>
  dplyr::select(Name, "Leaf P50 (MPa)", 
                "Reference (for Leaf P50)") |>
  dplyr::rename(originalName = Name,
                VCleaf_P50 = "Leaf P50 (MPa)",
                OriginalReference = "Reference (for Leaf P50)") |>
  dplyr::filter(!is.na(VCleaf_P50)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                originalName = stringr::str_replace(originalName, "Erigoonum", "Eriogonum"))|>
  dplyr::mutate(Reference = "Bartlett et al. (2016)",
                DOI = "10.1073/pnas.1604088113",
                Priority = 3)|>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2016_LeafP50.rds")

# VCroot_P50 -----------------------------------------------------------------
db_var <- db |>
  dplyr::select(Name, "Root P50 (MPa)", 
                "Reference (for Root P50)") |>
  dplyr::rename(originalName = Name,
                VCroot_P50 = "Root P50 (MPa)",
                OriginalReference = "Reference (for Root P50)") |>
  dplyr::filter(!is.na(VCroot_P50)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                originalName = stringr::str_replace(originalName, "Erigoonum", "Eriogonum"))|>
  dplyr::mutate(Reference = "Bartlett et al. (2016)",
                DOI = "10.1073/pnas.1604088113",
                Priority = 3)|>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2016_RootP50.rds")


# Stomatal traits -----------------------------------------------------------------
db_var <- db |>
  dplyr::select(Name, "Gs P50 (MPa)", "Gs 95 (MPa)", 
                "Reference (for Stomatal traits)") |>
  dplyr::rename(originalName = Name,
                Gs_P50 = "Gs P50 (MPa)",
                Gs_P95 = "Gs 95 (MPa)",
                OriginalReference = "Reference (for Stomatal traits)") |>
  dplyr::filter(!is.na(Gs_P50) | !is.na(Gs_P95)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                originalName = stringr::str_replace(originalName, "Erigoonum", "Eriogonum"))|>
  dplyr::mutate(Reference = "Bartlett et al. (2016)",
                DOI = "10.1073/pnas.1604088113",
                Priority = 3)|>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2016_GsP50_GsP95.rds")

