#
# Kattge et al (2020) - TRY by trait
#
# library(ntfy)

get_kattge_ref <- function() {
  kattge_ref <- "Kattge et al. (2020) TRY plant trait database – enhanced coverage and open access. Global Change Biology 26:119–188."
  return(kattge_ref)
}
get_kattge_doi <- function() {
  kattge_doi <- "10.1111/gcb.14904"
  return(kattge_doi)
}

harmonize_Kattge_et_al_2020_TRY_LeafVeinDensity <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_740.rds"))|>
    dplyr::mutate(
      Trait = "LeafVeinDensity",
      Value = StdValue) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
    dplyr::arrange(AccSpeciesName) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      UnitName,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(Units = UnitName,
                  Level = ValueKindName)|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = get_kattge_ref(),
                  DOI = get_kattge_doi(),
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mm mm-2)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "mm mm-2")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafVeinDensity.rds")
  
}


harmonize_Kattge_et_al_2020_TRY_StomatalArea <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_1191.rds"))|>
    dplyr::mutate(
      Trait = "StomatalArea",
      Value = as.numeric(OrigValueStr)) |>
    dplyr::filter(
      !is.na(Value),
    ) |>
    dplyr::arrange(AccSpeciesName) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      OrigUnitStr,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(Units = OrigUnitStr,
                  Level = ValueKindName)|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = get_kattge_ref(),
                  DOI = get_kattge_doi(),
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (um2)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "um2")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_StomatalArea.rds")
  
}


harmonize_Kattge_et_al_2020_TRY_StomatalLength <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_1190.rds"))|>
    dplyr::mutate(
      Trait = "StomatalLength",
      Value = as.numeric(OrigValueStr)) |>
    dplyr::filter(
      !is.na(Value),
    ) |>
    dplyr::arrange(AccSpeciesName) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      OrigUnitStr,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(Units = OrigUnitStr,
                  Level = ValueKindName)|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = get_kattge_ref(),
                  DOI = get_kattge_doi(),
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (um)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "um")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_StomatalLength.rds")
  
}

harmonize_Kattge_et_al_2020_TRY_StomatalWidth <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_1192.rds"))|>
    dplyr::mutate(
      Trait = "StomatalLength",
      Value = as.numeric(OrigValueStr)) |>
    dplyr::filter(
      !is.na(Value),
    ) |>
    dplyr::arrange(AccSpeciesName) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      OrigUnitStr,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(Units = OrigUnitStr,
                  Level = ValueKindName)|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = get_kattge_ref(),
                  DOI = get_kattge_doi(),
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (um)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "um")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_StomatalWidth.rds")
  
}


# ntfy_send("TRY harmonization finished!", auth = TRUE)
