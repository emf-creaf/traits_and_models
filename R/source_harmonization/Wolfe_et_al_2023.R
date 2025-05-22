#
# Wolfe et al. (2023)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Wolfe_et_al_2023/pce14524-sup-0002-tables_s1_and_s2.xlsx"), sheet = "Table S2")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(species, Kleaf, ktotal, "Kleaf source") |>
  dplyr::rename(originalName = species,
                kleaf = Kleaf,
                kplant = ktotal, 
                Reference = "Kleaf source") |>
  dplyr::mutate(Priority = 1)|>
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
saveRDS(db_post, "data/harmonized_trait_sources/Wolfe_et_al_2023.rds")
