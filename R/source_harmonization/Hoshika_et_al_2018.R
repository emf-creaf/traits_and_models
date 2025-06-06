#
# Hoshika et al. (2018)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Hoshika_et_al_2018/Hoshika_et_al_2018.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "gmax (mol m-2 s-1)") |>
  dplyr::rename(originalName = Species,
                Gswmax = "gmax (mol m-2 s-1)") |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "Eleaegnus", "Elaeagnus"))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_", " "))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_var.\\_", " var. "))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_L\\.", ""))|>
  dplyr::mutate(Reference = "Hoshika et al. (2018). Global diurnal and nocturnal parameters of stomatal
conductance in woody plants and major crops. Global Ecol. Biogeog. 27: 257-275",
                Priority = 3) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Hoshika_et_al_2018.rds")
