#
# Lens et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Lens_et_al_2016/Lens_2016_P50_all_species_updated_FINAL_version3.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("species...4", "P50", "reference") |>
  dplyr::rename(originalName = "species...4",
                Value = "P50",
                OriginalReference = "reference") |>
  dplyr::mutate(Trait = "VCstem_P50",
                Units = "MPa") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::mutate(Reference = "Lens et al. (2016) Herbaceous angiosperms are not more vulnerable to drought-induced embolism than angiosperm trees. Plant Physiology 172, 661-667",
                DOI = "10.1104/pp.16.00829",
                Priority = 2) |>
  dplyr::relocate(OriginalReference, .after = "DOI")|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_var$OriginalReference[db_var$OriginalReference=="this study"] <- NA
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Lens_et_al_2016.rds")
