#
# Klein (2014)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Klein_et_al_2014/fec12289-sup-0001-tables1.xlsx"), skip = 4)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Genus", "Species", "ψgs50 (MPa)", "Reference") |>
  dplyr::mutate(originalName = paste(Genus, Species)) |>
  dplyr::select(-Genus, -Species) |>
  dplyr::rename(Value = "ψgs50 (MPa)",
                OriginalReference = "Reference") |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Trait = "Gs_P50",
                Value = as.numeric(Value),
                Units = "MPa") |>
  dplyr::filter(!is.na(Value)) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::relocate(originalName, .before = Value) |>
  dplyr::mutate(Reference = "Klein (2014) The variability of stomatal sensitivity to leaf water potential across tree species indicates a continuum between isohydric and anisohydric behaviours. Functional Ecology",
                DOI = "10.1111/1365-2435.12289",
                Priority = 1)|>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()
db_var$OriginalReference[db_var$OriginalReference=="Klein T, unpublished data"] <- NA
traits4models::check_harmonized_trait(db_var)
# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Klein_et_al_2014.rds")
