#
# De Cáceres et al. (2019) - CR and pDead
#

harmonize_DeCaceres_et_al_2019 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  fn <- file.path(DB_path, "data-raw/raw_trait_data/DeCaceres_et_al_2019_CR_pDead/Shrub_Pdead_CR.txt")
  db <- readr::read_delim(fn)
  
  
  # CrownRatio --------------------------------------------------------------
  db_var <- db[1:27,] |>
    dplyr::select(Name, "CR.mean") |>
    dplyr::rename(originalName = Name,
                  Value = "CR.mean") |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
    dplyr::mutate(Trait = "CrownRatio",
                  Units = NA,
                  Level = "population",
                  Reference = "De Cáceres et al. (2019). Scaling-up individual-level allometric equations to predict stand-level fuel loading in Mediterranean shrublands. Ann. For. Sci. 76: 87",
                  DOI = "10.1007/s13595-019-0873-4",
                  Priority = 1) |>
    dplyr::relocate(Trait, .before=Value) |>
    dplyr::arrange(originalName) |>
    dplyr::filter(!is.na(Value)) |>
    tibble::as_tibble()
  
  db_var$originalName <- unlist(lapply(db_var$originalName, function(x) {paste(strsplit(x, " ")[[1]][1:2], collapse = " ")}) )
  
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
  
  traits4models::check_harmonized_trait(db_post)
  
  saveRDS(db_post, "data/harmonized_trait_sources/De_Caceres_et_al_2019_CrownRatio.rds")
  
  
  # pDead -------------------------------------------------------------------
  db_var <- db[1:27,] |>
    dplyr::select(Name, "Pdead.mean") |>
    dplyr::rename(originalName = Name,
                  Value = "Pdead.mean") |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
    dplyr::mutate(Trait = "pDead",
                  Units = NA,
                  Level = "population",
                  Reference = "De Cáceres et al. (2019). Scaling-up individual-level allometric equations to predict stand-level fuel loading in Mediterranean shrublands. Ann. For. Sci. 76: 87",
                  DOI = "10.1007/s13595-019-0873-4",
                  Priority = 1) |>
    dplyr::relocate(Trait, .before=Value) |>
    dplyr::arrange(originalName) |>
    dplyr::filter(!is.na(Value)) |>
    tibble::as_tibble()
  
  db_var$originalName <- unlist(lapply(db_var$originalName, function(x) {paste(strsplit(x, " ")[[1]][1:2], collapse = " ")}) )
  
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  traits4models::check_harmonized_trait(db_post)
  
  saveRDS(db_post, "data/harmonized_trait_sources/De_Caceres_et_al_2019_pDead.rds")
}


