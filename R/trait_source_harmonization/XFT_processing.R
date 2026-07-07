#
# Choat et al. (2012) XFT
#

harmonize_Choat_et_al_2012_XFT <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Choat_et_al_2012_XFT/XFT_full_database_download_20260702-062125.csv"))
  
  # Correct methods
  db <- db |>
    dplyr::mutate(P50.method = dplyr::case_when(P50.method == "DH" ~ "DH", # DH = dehydration
                                                P50.method == "CE" ~ "CE", # CE = centrifuge
                                                P50.method == "CA" ~ "CA", # CA = cavitron
                                                P50.method == "AD" ~ "AD", # AD = air-injection
                                                P50.method == "Air-injection" ~ "AD", # AD = air-injection single end
                                                P50.method == "AS" ~ "AS", # AE = acoustic emissions
                                                P50.method == "AE" ~ "AE", # AE = acoustic emissions
                                                P50.method == "MicroCT" ~ "MicroCT", # MicroCT = microCT
                                                P50.method == "Pn" ~ "Pn", # PN = pneumatic method/Pneumatron
                                                P50.method == "PN" ~ "Pn", # PN = pneumatic method/Pneumatron
                                                P50.method == "MRI" ~ "MRI", # MRI = magnetic resonance imaging
                                                TRUE ~ NA))
  
  # Hmax --------------------------------------------------
  db_Hmax <- db |>
    dplyr::select(Genus, Species, "Height.max..m.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Height.max..m.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Hmax", 
                  Units = "cm",
                  Level = "individual",
                  Value = Value*100,
                  Priority = 2) |> #change units from m to cm
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # Hact --------------------------------------------------
  db_Hact <- db |>
    dplyr::select(Genus, Species, "Height.actual..m.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Height.actual..m.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Hact", 
                  Units = "cm",
                  Level = "individual",
                  Value = Value*100,
                  Priority = 2) |> #change units from m to cm
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # Al2As --------------------------------------------------
  db_Al2As <- db |>
    dplyr::select(Genus, Species, "Huber.value..m2.m.2.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Huber.value..m2.m.2.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Al2As", 
                  Units = "m2 m-2",
                  Level = "individual",
                  Value =  1/Value,
                  Priority = 1) |> #From HV to Al2As
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # SLA --------------------------------------------------
  db_SLA <- db |>
    dplyr::select(Genus, Species, "SLA..cm2.g.1.", "Reference...DOI.number") |>
    dplyr::rename(Value = "SLA..cm2.g.1.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "SLA", 
                  Units = "mm2 mg-1",
                  Level = "individual",
                  Value = Value/10,
                  Priority = 2) |> # Change units from cm2 g-1 to mm2 mg-1
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # Ptlp --------------------------------------------------
  db_Ptlp <- db |>
    dplyr::select(Genus, Species, "TLP..MPa.", "Reference...DOI.number") |>
    dplyr::rename(Value = "TLP..MPa.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Ptlp", 
                  Units = "MPa",
                  Method = NA,
                  Level = "individual",
                  Priority = 2) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # StomatalDensity --------------------------------------------------
  db_StomatalDensity <- db |>
    dplyr::select(Genus, Species, "Total.stomata.density", "Reference...DOI.number") |>
    dplyr::rename(Value = "Total.stomata.density",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "StomatalDensity", 
                  Units = "mm-2", # The data base says it is cm-2 but data looks like mm-2
                  Level = "individual",
                  Value = Value,
                  Priority = 2) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  
  # Gswmax --------------------------------------------------
  db_Gswmax <- db |>
    dplyr::select(Genus, Species, "Gs..mol.m.2.s.1.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Gs..mol.m.2.s.1.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Gswmax", 
                  Units = "mol s-1 m-2", 
                  Level = "individual",
                  Value = Value,
                  Priority = 2) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <10)|>
    tibble::as_tibble()
  
  # Gswmin --------------------------------------------------
  db_Gswmin <- db |>
    dplyr::select(Genus, Species, "Gsmin..mol.m.2.s.1.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Gsmin..mol.m.2.s.1.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Gswmin", 
                  Units = "mol s-1 m-2", 
                  Level = "individual",
                  Value = Value,
                  Priority = 2) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Units) |>
    dplyr::filter(!is.na(Value))|>
    tibble::as_tibble()
  
  # Ks --------------------------------------------------
  db_Ks <- db |>
    dplyr::select(Genus, Species, "Ks..kg.m.1.MPa.1.s.1.", "Reference...DOI.number") |>
    dplyr::rename(Value = "Ks..kg.m.1.MPa.1.s.1.",
                  OriginalReference = "Reference...DOI.number") |>
    dplyr::mutate(Trait = "Ks", 
                  Units = "kg m-1 MPa-1 s-1", 
                  Level = "individual",
                  Value = Value,
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Level, .after = Value) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value > 0)|>
    tibble::as_tibble()
  
  # VCstem_P50 --------------------------------------------------
  db_VCstem_P50 <- db |>
    dplyr::filter(Plant.organ %in% c("s", "S", "T")) |>
    dplyr::select(Genus, Species, "P50", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P50",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCstem_P50", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value,
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()

  # VCstem_P12 --------------------------------------------------
  db_VCstem_P12 <- db |>
    dplyr::filter(Plant.organ %in% c("s", "S", "T")) |>
    dplyr::select(Genus, Species, "P12", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P12",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCstem_P12", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCstem_P88 --------------------------------------------------
  db_VCstem_P88 <- db |>
    dplyr::filter(Plant.organ %in% c("s", "S", "T")) |>
    dplyr::select(Genus, Species, "P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P88",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCstem_P88", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCstem_slope --------------------------------------------------
  db_VCstem_slope <- db |>
    dplyr::filter(Plant.organ %in% c("s", "S", "T")) |>
    dplyr::select(Genus, Species, "P12","P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCstem_slope",
                  Value = (88 - 12)/(abs(P88) - abs(P12)),
                  Units = "%/MPa", 
                  Level = "individual",
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value>=0)|>
    dplyr::select(-P88, -P12) |>
    tibble::as_tibble()
  
  # VCleaf_P50 --------------------------------------------------
  db_VCleaf_P50 <- db |>
    dplyr::filter(Plant.organ %in% c("l", "L")) |>
    dplyr::select(Genus, Species, "P50", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P50",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCleaf_P50", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value,
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCleaf_P12 --------------------------------------------------
  db_VCleaf_P12 <- db |>
    dplyr::filter(Plant.organ %in% c("l", "L")) |>
    dplyr::select(Genus, Species, "P12", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P12",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCleaf_P12", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCleaf_P88 --------------------------------------------------
  db_VCleaf_P88 <- db |>
    dplyr::filter(Plant.organ %in% c("l", "L")) |>
    dplyr::select(Genus, Species, "P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P88",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCleaf_P88", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCleaf_slope --------------------------------------------------
  db_VCleaf_slope <- db |>
    dplyr::filter(Plant.organ %in% c("l", "L")) |>
    dplyr::select(Genus, Species, "P12","P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCleaf_slope",
                  Value = (88 - 12)/(abs(P88) - abs(P12)),
                  Units = "%/MPa", 
                  Level = "individual",
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::select(-P88, -P12) |>
    tibble::as_tibble()
  
  # VCroot_P50 --------------------------------------------------
  db_VCroot_P50 <- db |>
    dplyr::filter(Plant.organ %in% c("r", "R")) |>
    dplyr::select(Genus, Species, "P50", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P50",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCroot_P50", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value,
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCroot_P12 --------------------------------------------------
  db_VCroot_P12 <- db |>
    dplyr::filter(Plant.organ %in% c("r", "R")) |>
    dplyr::select(Genus, Species, "P12", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P12",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCroot_P12", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()
  
  # VCroot_P88 --------------------------------------------------
  db_VCroot_P88 <- db |>
    dplyr::filter(Plant.organ %in% c("r", "R")) |>
    dplyr::select(Genus, Species, "P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(Value = "P88",
                  OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCroot_P88", 
                  Units = "MPa", 
                  Level = "individual",
                  Value = Value, 
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::filter(Value <= 0)|>
    tibble::as_tibble()

  # VCroot_slope --------------------------------------------------
  db_VCroot_slope <- db |>
    dplyr::filter(Plant.organ %in% c("r", "R")) |>
    dplyr::select(Genus, Species, "P12","P88", "P50.method", "Reference...DOI.number") |>
    dplyr::rename(OriginalReference = "Reference...DOI.number",
                  Method = "P50.method") |>
    dplyr::mutate(Trait = "VCroot_slope",
                  Value = (88 - 12)/(abs(P88) - abs(P12)),
                  Units = "%/MPa", 
                  Level = "individual",
                  Priority = 1) |> 
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Units, .after = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::relocate(Level, .after = Method) |>
    dplyr::filter(!is.na(Value))|>
    dplyr::select(-P88, -P12) |>
    tibble::as_tibble()
  
  

  db_var <- dplyr::bind_rows(db_Hmax,
                             db_Hact,
                             db_Al2As,
                             db_SLA,
                             db_Ptlp,
                             db_StomatalDensity,
                             db_Gswmax,
                             db_Gswmin,
                             db_Ks,
                             db_VCstem_P12,
                             db_VCstem_P50,
                             db_VCstem_P88,
                             db_VCstem_slope,
                             db_VCleaf_P12,
                             db_VCleaf_P50,
                             db_VCleaf_P88,
                             db_VCleaf_slope,
                             db_VCroot_P12,
                             db_VCroot_P50,
                             db_VCroot_P88,
                             db_VCroot_slope)|>
    dplyr::arrange(Genus, Species) |>
    dplyr::filter(!(Species %in% c("spp.", "sp", "sp."))) |>
    dplyr::mutate(originalName = paste0(Genus, " ", Species)) |>
    dplyr::relocate(originalName, .before = Genus) |>
    dplyr::arrange(originalName) |>
    dplyr::select(-c(Genus, Species)) |>
    dplyr::mutate(Reference = "Choat et al. (2012) - https://xylemfunctionaltraits.org/",
                  DOI = "10.1038/nature11688",
                  Priority = 2) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  
  traits4models::check_harmonized_trait(db_var)
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  saveRDS(db_post, "data/harmonized_trait_sources/Choat_et_al_2012_XFT.rds")
}

