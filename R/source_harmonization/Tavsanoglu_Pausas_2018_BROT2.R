#
# Tavsanoglu & Pausas (2018) - BROT2
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
brot_db <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Tavsanoglu_Pausas_2018_BROT2/BROT2_dat.csv"), 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
brot_ref <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Tavsanoglu_Pausas_2018_BROT2/BROT2_sou.csv"), 
                              delim = ",", escape_double = FALSE, trim_ws = TRUE)

# LDMC --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LDMC")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (mg g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LDMC.rds")

# SLA --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "SLA")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (m2 kg-1 or mm2 mg-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mm2 mg-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_SLA.rds")

# Hact --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "Height")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Trait = "Hact",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (cm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value * 100,
                Units = "cm")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_Hact.rds")

# SeedMass --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "SeedMass")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="mg")|>
  dplyr::mutate(Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (mg)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_SeedMass.rds")

# WoodDensity --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "StemDensity")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Trait = "WoodDensity",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (g cm-3)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "g cm-3")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_WoodDensity.rds")

# RootingDepth --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "RootDepth")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Trait = "Z95",
                Value = as.numeric(Value)) |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (mm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*1000,
                Units = "mm")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_Z95.rds")

# LeafDuration --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LeafLifespan")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Trait = "LeafDuration",
                Value = as.numeric(Value)) |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (year)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value/12,
                Units = "year")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafDuration.rds")

# LeafArea --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LeafArea")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="mm2")|>
  dplyr::mutate(Value = as.numeric(Value)) |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units (mm2)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafArea.rds")

# pDead --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "DeadFuel")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="%")|>
  dplyr::mutate(Trait = "pDead",
                Value = as.numeric(Value)) |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
#Check units ([0-1])
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value/100,
                Units = "[0-1]")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_pDead.rds")

# LifeForm --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "GrowthForm")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    Value = dplyr::case_when(
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(Cha|Hemiphanerophyte|subshrub)")) ~ "Chamaephyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(hemic|forb)")) ~ "Hemicryptophyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(thero|tero|graminoid)")) ~ "Therophyte"
    ),
    Units = as.character(NA)
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LifeForm.rds")

# LeafShape --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "LeafShape")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    Value = dplyr::case_when(
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(broad)")) ~ "Broad",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(linear)")) ~ "Linear",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(needle)")) ~ "Needle",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(scale)")) ~ "Scale",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(spines)")) ~ "Spines",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(succulent)")) ~ "Succulent"
    ),
    Units = as.character(NA)
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafShape.rds")

# PhenologyType --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "LeafPhenology")|>
  dplyr::rename(Value = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    Trait = "PhenologyType",
    Value = dplyr::case_when(
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(evergreen)")) ~ "oneflush-evergreen",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(drought semi-deciduous)")) ~ "drought-semideciduous",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(winter deciduous)")) ~ "winter-deciduous",
      stringr::str_detect(tolower(Value), stringr::regex("(?i)(winter semi-deciduous)")) ~ "winter-semideciduous"
    ), 
    Units = as.character(NA)
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Tavşanoǧlu & Pausas (2018) A functional trait database for Mediterranean Basin plants. Scientific Data 5,1-18") |>
  dplyr::mutate(DOI = "10.1038/sdata.2018.135")  |>
  dplyr::left_join(brot_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "FullSource") |>
  dplyr::mutate(Priority = 1)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_PhenologyType.rds")
