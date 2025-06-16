#
# Tumber-Davila et al. (2022)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Tumber_Davila_2022/nph18031-sup-0001-datasets1.xlsx"), sheet = "RSIP")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, Hs, Dr, Reference) |>
  dplyr::rename(originalName = Species,
                Hact = Hs,
                Z95 = Dr,
                OriginalReference = Reference) |>
  dplyr::mutate(Z95 = Z95 * 1000) |> # m to mm
  dplyr::mutate(Hact = Hact * 100) |> # m to cm
  dplyr::filter(!is.na(originalName)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\ ", " "))|>
  dplyr::mutate(Priority = 2) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Tumber-Dávila et al. (2022) Plant sizes and shapes above and belowground and their interactions with climate. New Phytologist 235: 1032-1056",
                DOI = "10.1111/nph.18031") |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Tumber_Davila_et_al_2022.rds")
