#
# Zhao et al. (2026)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- read.csv2(paste0(DB_path, "data-raw/raw_trait_data/Zhao_et_al_inreview_KPLANT/KPLANT_database_V1.0.csv"),
                        sep = "\t", dec=".")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(pl_species_corrected, "k_plant_leaf", "PaperDOI") |>
  dplyr::rename(originalName = pl_species_corrected,
                Value = "k_plant_leaf",
                OriginalReference = "PaperDOI") |>
  dplyr::mutate(Trait = "kplant",
                Value = as.numeric(Value)*(1e6/18.0), # From kg m-2 s-1 MPa-1 to mmol m-2 s-1 MPa-1
                Units = "mmol m-2 s-1 MPa-1")|>
  dplyr::filter(!is.na(Value),
                Value < 100.0) |> # Filter outliers?
  dplyr::mutate(Reference = "Zhao, Y., Mencuccini, M., Acuña-Míguez, B., Adet, L., Amin, S., Anadon-Rosell, A., Anderegg, L., Anderegg, W., Aranda, I., Bachofen, C., Bittencourt, P., Binks, O., De Cáceres, M., Carminati, A., Castells, E., Chaparro, D., Cochard, H., Creek, D., David, T., … Flo, V. (2026). KPLANT (V1.0) [Data set]. Zenodo.",
                DOI = "https://doi.org/10.5281/zenodo.19816125",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after="Priority") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Zhao_et_al_2026.rds")
