#
# Hoshika et al. (2018)
#

harmonize_Hoshika_et_al_2018 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Hoshika_et_al_2018/Hoshika_et_al_2018.xlsx"))
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::select(Species, "gmax (mol m-2 s-1)", "First author", "Year", "Journal") |>
    dplyr::rename(originalName = Species,
                  Value = "gmax (mol m-2 s-1)",
                  FirstAuthor = "First author") |>
    dplyr::mutate(Trait = "Gswmax",
                  Value = as.numeric(Value),
                  Units = "mol s-1 m-2",
                  Level = "population")|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "Eleaegnus", "Elaeagnus"))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_", " "))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_var.\\_", " var. "))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_L\\.", ""))|>
    dplyr::mutate(Reference = "Hoshika et al. (2018). Global diurnal and nocturnal parameters of stomatal
conductance in woody plants and major crops. Global Ecol. Biogeog. 27: 257-275",
                  DOI = "10.1111/geb.12681",
                  Priority = 3,
                  originalReference = paste0(FirstAuthor, " et al. (", Year, ") ", Journal)) |>
    dplyr::arrange(originalName) |>
    dplyr::select(-FirstAuthor, -Year, -Journal)|>
    tibble::as_tibble()
  traits4models::check_harmonized_trait(db_var)
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Hoshika_et_al_2018.rds")
}
