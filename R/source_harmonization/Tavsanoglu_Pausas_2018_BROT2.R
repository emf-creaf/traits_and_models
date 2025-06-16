#
# Tavsanoglu & Pausas (2018) - BROT2
#
DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
brot_db <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Tavsanoglu_Pausas_2018_BROT2/BROT2_dat.csv"), 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
brot_ref <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Tavsanoglu_Pausas_2018_BROT2/BROT2_sou.csv"), 
                              delim = ",", escape_double = FALSE, trim_ws = TRUE)

# LDMC --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LDMC")|>
  dplyr::rename(LDMC = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(LDMC = as.numeric(LDMC)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LDMC.rds")

# SLA --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "SLA")|>
  dplyr::rename(SLA = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(SLA = as.numeric(SLA)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_SLA.rds")

# Hact --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "Height")|>
  dplyr::rename(Hact = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Hact = 100*as.numeric(Hact), # From m to cm
                Units = "cm") |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_Hact.rds")

# SeedMass --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "SeedMass")|>
  dplyr::rename(SeedMass = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="mg")|>
  dplyr::mutate(SeedMass = as.numeric(SeedMass)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_SeedMass.rds")

# WoodDensity --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "StemDensity")|>
  dplyr::rename(WoodDensity = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(WoodDensity = as.numeric(WoodDensity)) |>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_WoodDensity.rds")

# RootingDepth --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "RootDepth")|>
  dplyr::rename(Z95 = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(Z95 = 1000*as.numeric(Z95), # From m to mm
                Units = "mm") |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_Z95.rds")

# LeafDuration --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LeafLifespan")|>
  dplyr::rename(LeafDuration = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(LeafDuration = as.numeric(LeafDuration)/12, # From months to years
                Units = "yr") |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafDuration.rds")

# LeafArea --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "LeafArea")|>
  dplyr::rename(LeafArea = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="mm2")|>
  dplyr::mutate(LeafArea = as.numeric(LeafArea)) |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafArea.rds")

# pDead --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "Units", "SourceID") |>
  dplyr::filter(Trait == "DeadFuel")|>
  dplyr::rename(pDead = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::filter(Units=="%")|>
  dplyr::mutate(pDead = as.numeric(pDead)/100,
                Units = "[0-1]") |> 
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_pDead.rds")

# LifeForm --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "GrowthForm")|>
  dplyr::rename(LifeForm = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    LifeForm = dplyr::case_when(
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Cha|Hemiphanerophyte|subshrub)")) ~ "Chamaephyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hemic|forb)")) ~ "Hemicryptophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(thero|tero|graminoid)")) ~ "Therophyte"
    )
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LifeForm.rds")

# LeafShape --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "LeafShape")|>
  dplyr::rename(LeafShape = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    LeafShape = dplyr::case_when(
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(broad)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(linear)")) ~ "Linear",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(needle)")) ~ "Needle",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(scale)")) ~ "Scale",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(spines)")) ~ "Spines",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(succulent)")) ~ "Succulent"
    )
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_LeafShape.rds")

# PhenologyType --------------------------------------------------
db_var <- brot_db |>
  dplyr::select("Taxon", "Trait", "Data", "SourceID") |>
  dplyr::filter(Trait == "LeafPhenology")|>
  dplyr::rename(PhenologyType = "Data",
                OriginalReferenceID = SourceID)|>
  dplyr::mutate(
    PhenologyType = dplyr::case_when(
      stringr::str_detect(tolower(PhenologyType), stringr::regex("(?i)(evergreen)")) ~ "oneflush-evergreen",
      stringr::str_detect(tolower(PhenologyType), stringr::regex("(?i)(drought semi-deciduous)")) ~ "drought-semideciduous",
      stringr::str_detect(tolower(PhenologyType), stringr::regex("(?i)(winter deciduous)")) ~ "winter-deciduous",
      stringr::str_detect(tolower(PhenologyType), stringr::regex("(?i)(winter semi-deciduous)")) ~ "winter-semideciduous"
    )
  )|>
  dplyr::rename(originalName = "Taxon")|>
  dplyr::select(-Trait)|>
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
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Tavsanoglu_Pausas_2018_PhenologyType.rds")
