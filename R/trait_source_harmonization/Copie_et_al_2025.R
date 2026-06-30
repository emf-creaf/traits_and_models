#
# Copie et al. 2025
#
harmonize_Copie_et_al_2025 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Copie_et_al_2025/Alice_data_thesis_mean.xlsx"), sheet = 1)
  
  
  # Filter out hybrids ------------------------------------------------------
  spp<-c("Abies numidica", "Abies nordmanniana", "Abies bornmuelleriana", "Abies concolor", "Abies borisii-regis", "Abies cephalonica",
         "Abies pinsapo", "Abies cilica")
  db <- db |>
    dplyr::filter(Species %in% spp)
  
  # Variable harmonization --------------------------------------------------------------------
  db_sla <- db |>
    dplyr::select(Site, Species, SLA_m2_g) |>
    dplyr::rename(originalName = "Species",
                  Value = "SLA_m2_g") |>
    dplyr::mutate(Value = as.numeric(Value)*1000) |> # m2 g-1 to m2 kg-1
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "SLA",
                  Units = "m2 kg-1",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_wooddensity <- db |>
    dplyr::select(Site, Species, Wood_densite_g_MS.cm3) |>
    dplyr::rename(originalName = "Species",
                  Value = "Wood_densite_g_MS.cm3") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "WoodDensity",
                  Units = "g cm-3",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-Site)
  db_al2as <- db |>
    dplyr::select(Site, Species, HV_DB) |>
    dplyr::rename(originalName = "Species",
                  Value = "HV_DB") |>
    dplyr::mutate(Value = 1/as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "Al2As",
                  Units = "m2 m-2",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-Site)
  db_pi0 <- db |>
    dplyr::select(Site, Species, n100) |>
    dplyr::rename(originalName = "Species",
                  Value = "n100") |>
    dplyr::mutate(Value = -as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "LeafPI0",
                  Units = "MPa",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-Site)
  db_eps <- db |>
    dplyr::select(Site, Species, eps_ft) |>
    dplyr::rename(originalName = "Species",
                  Value = "eps_ft") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "LeafEPS",
                  Units = "MPa",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-Site)
  db_tlp <- db |>
    dplyr::select(Site, Species, psi_tlp) |>
    dplyr::rename(originalName = "Species",
                  Value = "psi_tlp") |>
    dplyr::mutate(Value = -as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "Ptlp",
                  Units = "MPa",
                  Level = "population",
                  Method = "pressure-volume") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-Site)
  db_gmin <- db |>
    dplyr::select(Site, Species, gmin) |>
    dplyr::rename(originalName = "Species",
                  Value = "gmin") |>
    dplyr::mutate(Value = as.numeric(Value)/1000) |> # From mmol to mol
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "Gswmin",
                  Units = "mol s-1 m-2",
                  Level = "population") |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_P50 <- db |>
    dplyr::select(Site, Species, P50) |>
    dplyr::rename(originalName = "Species",
                  Value = "P50") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "VCstem_P50",
                  Units = "MPa",
                  Level = "population",
                  Method = "CA") |> # Cavitron
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_P12 <- db |>
    dplyr::select(Site, Species, P12) |>
    dplyr::rename(originalName = "Species",
                  Value = "P12") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "VCstem_P12",
                  Units = "MPa",
                  Level = "population",
                  Method = "CA") |> # Cavitron
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_P88 <- db |>
    dplyr::select(Site, Species, P88) |>
    dplyr::rename(originalName = "Species",
                  Value = "P88") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "VCstem_P88",
                  Units = "MPa",
                  Level = "population",
                  Method = "CA") |> # Cavitron
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_slope <- db |>
    dplyr::select(Site, Species, slope) |>
    dplyr::rename(originalName = "Species",
                  Value = "slope") |>
    dplyr::mutate(Value = as.numeric(Value)) |> 
    dplyr::group_by(Site, originalName) |>
    dplyr::summarize(Value = mean(Value, na.rm = TRUE), .groups = "drop") |>
    dplyr::mutate(Trait = "VCstem_slope",
                  Units = NA,
                  Level = "population",
                  Method = "CA") |> # Cavitron
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::select(-Site)
  db_var <- dplyr::bind_rows(db_sla,
                             db_wooddensity,
                             db_al2as,
                             db_pi0,
                             db_eps,
                             db_tlp,
                             db_gmin,
                             db_P50,
                             db_P12,
                             db_P88,
                             db_slope) |>
    dplyr::mutate(
      Reference = "Copie et al. (2025) Beyond proxies: towards ecophysiological indicators of drought resistance for forest management. Tree Physiology, 45, tpaf090",
      DOI = "10.1093/treephys/tpaf090",
      Priority = 1) |>
    tibble::as_tibble()
  
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Copie_et_al_2025.rds")
  
}
