#
# Kattge et al (2020) - TRY (numeric traits)
#
# library(ntfy)

harmonize_Kattge_et_al_2020_TRY_numeric <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  kattge_ref <- "Kattge et al. (2020) TRY plant trait database – enhanced coverage and open access. Global Change Biology 26:119–188."
  kattge_doi <- "10.1038/s41597-021-01006-6"
  
  
  # LeafArea - TRY_3110 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3110.rds"))|>
    dplyr::mutate(
      Trait = "LeafArea",
      Value = StdValue) |>
    dplyr::filter(
      !is.na(Value),
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
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mm2)
  table(db_var$Units)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafArea.rds")
  
  
  # Hact - TRY 3106 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3106.rds")) |>
    dplyr::select(
      AccSpeciesName,
      DatasetID,
      DataName,
      OriglName,
      StdValue,
      UnitName,
      ValueKindName,
      ErrorRisk,
      Reference) |>
    dplyr::filter(
      !is.na(StdValue),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
    dplyr::mutate(
      Trait = "Hact",
      Value = StdValue*100, # From m to cm
      Units = "cm"
    ) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      Units,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference,
                  Level = ValueKindName)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Hact.rds")
  
  
  # LeafDuration - TRY_12 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_12.rds"))|>
    dplyr::mutate(
      Trait = "LeafDuration",
      Value = StdValue) |>
    dplyr::filter(
      !is.na(Value),
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
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  
  #Check units (year)
  table(db_var$Units)
  db_var <- db_var|>
    dplyr::mutate(Value = Value/12,
                  Units = "year") # From months to yr
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafDuration.rds")
  
  
  # Z95 - TRY_12 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_6.rds"))|>
    dplyr::mutate(
      Trait = "Z95",
      Value = StdValue) |>
    dplyr::filter(
      !is.na(Value),
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
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  
  #Check units (mm)
  table(db_var$Units)
  db_var <- db_var|>
    dplyr::mutate(Value = Value*1000,
                  Units = "mm") # From m to mm
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Z95.rds")
  
  
  # SLA - TRY_3117 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3117.rds"))|>
    dplyr::mutate(
      Trait = "SLA",
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
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mm2 mg-1)
  table(db_var$Units)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SLA.rds")
  
  # LeafDensity - TRY_48 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_48.rds"))|>
    dplyr::mutate(
      Trait = "LeafDensity",
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
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (g cm-3)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "g cm-3")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafDensity.rds")
  
  
  # WoodDensity - TRY_4 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_4.rds"))|>
    dplyr::mutate(
      Trait = "WoodDensity",
      Value = StdValue) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !is.na(AccSpeciesName),
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
    dplyr::filter(originalName != "Tilia \xd7moltkei") |>
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (g cm-3)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "g cm-3")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodDensity.rds")
  
  # Al2As NOT DONE - TRY_171 ----------------------------------------------------------------
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="Huber value"]<-1/as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="Huber value"])
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="leaf.area.per.sapwood.area"]<-TRY_Al2As$StdValue[TRY_Al2As$OriglName=="leaf.area.per.sapwood.area"]*100
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="Sapwood: leaf area ratio"]<-10000/as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="Sapwood: leaf area ratio"])
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="The ratio of leaf area attached per unit sapwood cross-section area (m2 cm-2)"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="The ratio of leaf area attached per unit sapwood cross-section area (m2 cm-2)"])
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="values at base of living crown, m2/cm2"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="values at base of living crown, m2/cm2"])
  # TRY_Al2As$StdValue[TRY_Al2As$OriglName=="values at breast height, m2/cm2"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="values at breast height, m2/cm2"])
  # TRY_Al2As <- TRY_Al2As[TRY_Al2As$ErrorRisk <3, c("AccSpeciesName", "StdValue")]
  #
  # db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_171.rds"))|>
  #   dplyr::mutate(Al2As = dplyr::case_when(
  #     OriglName == "Huber value" ~ 1/as.numeric(OrigValueStr),
  #     OriglName == "leaf.area.per.sapwood.area" ~ 100as.numeric(StdValue),
  #     OriglName == "Sapwood: leaf area ratio" ~ 10000/as.numeric(OrigValueStr),
  #   )) |>
  #   dplyr::mutate(Units = "m2·m-2")|>
  #   dplyr::filter(
  #     !is.na(Al2As)
  #   ) |>
  #   dplyr::arrange(AccSpeciesName) |>
  #   dplyr::select(
  #     AccSpeciesName,
  #     Al2As,
  #     Units,
  #     Reference
  #   )|>
  #   dplyr::rename(originalName = AccSpeciesName)|>
  #   dplyr::mutate(
  #       originalName = gsub("\u0081|", "", originalName)) |>
  #   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  #   dplyr::arrange(originalName)
  # db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
  # saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodDensity.rds")
  
  
  # LeafWidth - TRY_145 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_145.rds"))|>
    dplyr::mutate(
      Trait = "LeafWidth",
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
    dplyr::filter(originalName != "Jasminum meyeri\xfbjohannis") |>
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (cm)
  table(db_var$Units)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafWidth.rds")
  
  # StomatalDensity- TRY_63 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_63.rds"))|>
    dplyr::mutate(
      Trait = "StomatalDensity",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName), 
      Level = dplyr::case_when(
        Level=="Single" ~ "individual",
        Level=="Mean" ~ "population",
        TRUE ~ "population"
      )) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check level
  table(db_var$Level)
  #Check units (1/mm2)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "mm-2")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_StomatalDensity.rds")
  
  # Stomatal conductance (Gsw) - TRY_45 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_45.rds"))|>
    dplyr::mutate(
      Trait = "Gsw",
      Value = as.numeric(StdValue)) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Method = NA,
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 2, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mol s-1  m-2)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Value = dplyr::case_when(
      Units=="mol m-2 s-1" ~ Value,
      Units=="milli mol m-2 s-1" ~ Value/1000, # From mmol to mol
      TRUE ~ NA
    ),
    Units = "mol s-1 m-2") 
  
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  if(!traits4models::check_harmonized_trait(db_post)) stop("Not valid")
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Gsw.rds")
  
  # SRL - TRY_614 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_614.rds"))|>
    dplyr::mutate(
      Trait = "SRL",
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName), 
      Level = dplyr::case_when(
        Level=="Single" ~ "individual",
        Level=="Mean" ~ "population",
        TRUE ~ "population"
      )) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (cm g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "cm g-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SRL.rds")
  
  # LeafPI0 - TRY_188 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_188.rds"))|>
    dplyr::mutate(
      Trait = "LeafPI0",
      Value = as.numeric(StdValue)) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Method = NA,
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (cm g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Value = -1*Value,
                  Units = "MPa") # From -MPa to MPa
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  if(!traits4models::check_harmonized_trait(db_post)) stop("Not valid")
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafPI0.rds")
  
  # LeafEPS - TRY_190 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_190.rds"))|>
    dplyr::mutate(
      Trait = "LeafEPS",
      Value = as.numeric(OrigValueStr)) |>
    dplyr::filter(
      !is.na(Value),
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Method = NA,
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (MPa)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "MPa")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  if(!traits4models::check_harmonized_trait(db_post)) stop("Not valid")
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafEPS.rds")
  
  # LigninPercent - TRY_87 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_87.rds"))|>
    dplyr::mutate(
      Trait = "LigninPercent",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units ()
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Value = Value/10,
                  Units = "%") # from mg·g-1 to %
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LigninPercent.rds")
  
  # Nleaf - TRY_14 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_14.rds"))|>
    dplyr::mutate(
      Trait = "Nleaf",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
                  OriginalReference = Reference) |>
    dplyr::filter(originalName != "Sorghum \xd7 drummondii") |>
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mg g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "mg g-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nleaf.rds")
  
  # Nsapwood - TRY_1229 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_1229.rds"))|>
    dplyr::mutate(
      Trait = "Nsapwood",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mg g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "mg g-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nsapwood.rds")
  
  # Nfineroot- TRY_475 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_475.rds"))|>
    dplyr::mutate(
      Trait = "Nfineroot",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mg g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "mg g-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nfineroot.rds")
  
  # Vmax- TRY_186 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_186.rds"))|>
    dplyr::mutate(
      Trait = "Vmax",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName), 
      Level = dplyr::case_when(
        Level=="Single" ~ "individual",
        Level=="Mean" ~ "population",
        TRUE ~ "population"
      )) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check level
  table(db_var$Level)
  #Check units (umol m-2 s-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "umol m-2 s-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Vmax.rds")
  
  # Jmax- TRY_269 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_269.rds"))|>
    dplyr::mutate(
      Trait = "Jmax",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName), 
      Level = dplyr::case_when(
        Level=="Single" ~ "individual",
        Level=="Mean" ~ "population",
        TRUE ~ "population"
      )) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check levels
  table(db_var$Level)
  #Check units (umol m-2 s-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Units = "umol m-2 s-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Jmax.rds")
  
  
  # WoodC- TRY_407 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_407.rds"))|>
    dplyr::mutate(
      Trait = "WoodC",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mg g-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Value = Value/1000,
                  Units = "g g-1") # From mg/g to g/g
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodC.rds")
  
  
  # RERleaf- TRY_407 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_41.rds"))|>
    dplyr::mutate(
      Trait = "RERleaf",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::rename(originalName = "AccSpeciesName",
                  OriginalReference = "Reference")|>
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (g g-1 day-1)
  table(db_var$Units)
  db_var <- db_var |>
    dplyr::mutate(Value = 24.0*3600.0*(Value/6.0)*(1e-6)*180.156, # From umol C/g/s to g gluc/g/day
                  Units = "g g-1 day-1")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_RERleaf.rds")
  
  
  # SeedMass- TRY_26 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_26.rds"))|>
    dplyr::mutate(
      Trait = "SeedMass",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (mg)
  table(db_var$Units)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SeedMass.rds")
  
  # LeafAngle- TRY_3 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3.rds"))|>
    dplyr::mutate(
      Trait = "LeafAngle",
      Value = as.numeric(OrigValueStr)) |>
    dplyr::filter(!is.na(Value),
                  Value >= 0,
                  Value <=90,
                  !ValueKindName %in% c("Maximum", "Minimum")) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (degree)
  table(db_var$Units)
  summary(db_var$Value)
  db_var <- db_var |>
    dplyr::mutate(Units = "degree")
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafAngle.rds")
  
  
  # SeedLongevity- TRY_26 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_33.rds"))|>
    dplyr::mutate(
      Trait = "SeedLongevity",
      Value = as.numeric(StdValue)) |>
    dplyr::filter(
      !is.na(Value),
      ErrorRisk < 3,
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
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
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName) |>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (year)
  table(db_var$Units)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SeedLongevity.rds")
  
  # ShadeTolerance- TRY_603 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_603.rds"))|>
    dplyr::filter(DatasetID == 49) |>
    dplyr::mutate(
      Trait = "ShadeTolerance",
      Value = as.numeric(OrigValueStr),
      Units = as.character(NA)) |>
    dplyr::filter(
      !is.na(Value),
      !ValueKindName %in% c("Maximum", "Minimum")
    ) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      Units,
      ValueKindName,
      Reference
    )|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference,
                  Level = ValueKindName)|>
    dplyr::mutate(
      originalName = gsub("\u0081|", "", originalName)) |>
    dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1, 
                  Level = dplyr::case_when(
                    Level=="Single" ~ "individual",
                    Level=="Mean" ~ "population",
                    TRUE ~ "population"
                  )) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  #Check units (0-5)
  db_var <- db_var |>
    dplyr::filter(Value>=0 & Value <=5)
  # traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  if(!traits4models::check_harmonized_trait(db_post)) stop("Not valid")
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_ShadeTol.rds")
}




# ntfy_send("TRY harmonization finished!", auth = TRUE)
