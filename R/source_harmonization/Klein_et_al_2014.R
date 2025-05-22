#
# Klein et al. (2014)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Klein_et_al_2014/fec12289-sup-0001-tables1.xlsx"), skip = 4)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Genus", "Species", "ψgs50 (MPa)", Reference) |>
  dplyr::mutate(originalName = paste(Genus, Species)) |>
  dplyr::select(-Genus, -Species) |>
  dplyr::rename(Gs_P50 = "ψgs50 (MPa)") |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Gs_P50 = as.numeric(Gs_P50)) |>
  dplyr::relocate(originalName, .before = Gs_P50) |>
  dplyr::mutate(Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Klein_et_al_2014.rds")
