#
# Yan et al. (2020)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Yan_et_al_2020/rsbl20200456_si_002.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, `Kleaf (mmol m-2 s-1 MPa-1)`, `P50leaf (MPa)`, Source) |>
  dplyr::rename(originalName = Species,
                kleaf = `Kleaf (mmol m-2 s-1 MPa-1)`,
                VCleaf_P50 = `P50leaf (MPa)`,
                Reference = Source) |>
  dplyr::mutate(Priority = 1) |>
  # dplyr::filter(!is.na(originalName)) |>
  # dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  # dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Yan_et_al_2020.rds")
