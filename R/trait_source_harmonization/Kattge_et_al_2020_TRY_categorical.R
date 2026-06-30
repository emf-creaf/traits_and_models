#
# Kattge et al (2020) - TRY
#
# library(ntfy)

harmonize_Kattge_et_al_2020_TRY_categorical <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  
  kattge_ref <- "Kattge et al. (2020) TRY plant trait database – enhanced coverage and open access. Global Change Biology 26:119–188."
  kattge_doi <- "10.1038/s41597-021-01006-6"
  
  
  
  # GrowthForm - TRY 3400 ----------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3400.rds")) |>
    dplyr::rename(
      Value = OrigValueStr
    ) |>
    dplyr::mutate(
      Value = stringr::str_replace(Value, "tree", "Tree"),
      Value = stringr::str_replace(Value, "shrub", "Shrub"),
      Value = stringr::str_replace(Value, "herb", "Herb"),
      Value = stringr::str_replace(Value, "other", "Other"),
      Value = stringr::str_replace(Value, "Shrub/Tree", "Tree/Shrub"),
      Value = stringr::str_replace(Value, "Herb/Shrub", "Shrub/Herb"),
      Value = stringr::str_replace(Value, "Herb/Tree", "Tree/Herb"),
      Value = stringr::str_replace(Value, "Tree/Herb/Shrub", "Tree/Shrub/Herb")
    ) |>
    dplyr::select(
      AccSpeciesName,
      Value,
      Reference
    ) |>
    dplyr::mutate(Trait = "GrowthForm",
                  Units = as.character(NA)) |>
    dplyr::relocate(Trait, .before=Value) |>
    dplyr::relocate(Units, .after=Value) |>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Level = "taxon", 
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_GrowthForm.rds")
  
  # LifeForm TO BE REVISED - TRY 343 -----------------------------------------------------------------
  # db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_343.rds"))  |>
  #   dplyr::mutate(
  #     Trait = "LifeForm",
  #     Value = OrigValueStr,
  #     Units = as.character(NA)
  #    ) |>
  #   dplyr::filter(
  #     !is.na(Value),
  #     #  verifica si la variable Value no está vacia y contiene al menos una letra del alfabeto.
  #     Value != "" & grepl("[[:alpha:]]", Value)
  #   ) |>
  #   dplyr::mutate(
  #     #  elimina todos los caracteres que no son letras, dígitos o espacios en blanco de la variable LifeForm y luego crea una nueva versión de LifeForm
  #     Value = gsub("[^[:alnum:]\\s]", "", Value)) |>
  #   dplyr::mutate(
  #     Value = dplyr::case_when(
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Cha|Hemiphanerophyte)")) ~ "Chamaephyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(hemic)")) ~ "Hemicryptophyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
  #       stringr::str_detect(tolower(Value), stringr::regex("(?i)(thero|tero)")) ~ "Therophyte",
  #       TRUE ~ Value
  #     )
  #   ) |>
  #   dplyr::mutate(
  #     Value = dplyr::case_when(
  #       Value == "Geophytes" ~ "Cryptophyte",
  #       Value == "G" ~ "Geophytes",
  #       Value == "Chamaephytes" ~ "Chamaephyte",
  #       Value == "Ch" ~ "Chamaephyte",
  #       Value == "CH" ~ "Chamaephyte",
  #       Value == "Hemicryptophytes" ~ "Hemicryptophyte",
  #       Value == "H" ~ "Hemicryptophyte",
  #       Value %in% c("Hydrophytes", "Helophytes") ~ "Hydrophyte",
  #       Value == "Therophytes" ~ "Therophyte",
  #       Value == "T" ~ "Therophyte",
  #       Value == "TH" ~ "Therophyte",
  #       Value %in% c("Phanerophytes", "Mega meso micro nanophanerophyte") ~ "Phanerophyte",
  #       Value == "P" ~ "Phanerophyte",
  #       Value == "Ph" ~ "Phanerophyte",
  #       DatasetID == 202 & OrigValueStr %in% c(1, 2) ~ "Phanerophyte",
  #       DatasetID == 202 & OrigValueStr %in% c(3, 4) ~ "Chamaephyte",
  #       DatasetID == 202 & OrigValueStr %in% c(5, 6, 7) ~ "Hemicryptophyte",
  #       DatasetID == 202 & OrigValueStr == "8" ~ "Therophyte",
  #       DatasetID %in% c("174", "178") &  OrigValueStr == "Mega meso and microphanerophyte" ~ "Phanerophyte",
  #       DatasetID == 37  & OrigValueStr == "1" ~ "Therophyte",
  #       DatasetID == 37  & OrigValueStr == "2" ~ "Cryptophyte",
  #       DatasetID == 37  & OrigValueStr == "3" ~ "Hemicryptophyte",
  #       DatasetID == 37  & OrigValueStr == "4" ~ "Chamaephyte",
  #       DatasetID == 37  & OrigValueStr == "5" ~ "Phanerophyte",
  #       TRUE ~ Value
  #     )) |>
  #   dplyr::filter(
  #     !is.na(Value),
  #     Value %in% c("Phanerophyte","Chamaephyte","Cryptophyte", "Hydrophyte","Therophyte","Epiphyte", "Hemicryptophyte")
  #   ) |>
  #   dplyr::select(
  #     AccSpeciesName,
  #     Trait,
  #     Value,
  #     Units,
  #     Reference
  #   ) |>
  #   dplyr::rename(originalName = AccSpeciesName,
  #                 OriginalReference = Reference)|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  #   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  #   dplyr::arrange(originalName)|>
  #   dplyr::mutate(Reference = kattge_ref,
  #                 DOI = kattge_doi,
  #                 Priority = 1) |>
  #   dplyr::relocate(OriginalReference, .after = DOI)
  # db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  #   dplyr::mutate(checkVersion = checkVersion)
  # traits4models::check_harmonized_trait(db_post)
  # saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LifeForm.rds")
  
  # DispersalMode - TRY 28 ------------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_28.rds")) |>
    dplyr::mutate(
      Value = OrigValueStr
    )  |>
    dplyr::arrange(AccSpeciesName)  |>
    dplyr::filter(
      !( DatasetID %in% c(565,299))
    ) |>
    dplyr::mutate(Value = dplyr::case_when(
      OriglName %in% c("disp_Biotic", "AnimalSpecies", "AnimalGroup", "dispersal mode: endozoochory") ~ "vertebrate",
      stringr::str_detect(Value, stringr::regex("(?i)(fleshy|Epi|clothes and footwear|adhesion|animal|pintail|squirrel|goat|pet|bighorn|Zooch|rabbit|snail|zoo|mamal|Ornithochory|dog|badger|turtles|fox|hedgehog|marten|buffalo|boar|hare|dog|donkey|marmot|cattle|pig|deer|sheep|fish|horse|vertebrate|bird|mammal|Anchorage)")) ~ "vertebrate",
      stringr::str_detect(Value, stringr::regex("(?i)(roe|shrew|mouse|Hydrochoerus|Thomomys|Ctenomys|Heteromys|Marmota|Dasyprocta|Cuniculus|Rattus|Sigmodon|Myodes|Oryzomys|Aplodontia|Erethizon|Microtus|Peromyscus|pacarana|Myadestes|Myoprocta|Sciurus|Squirrel|Dasyprocta)")) ~ "vertebrate",
      stringr::str_detect(Value, stringr::regex("(?i)(mirmecochory|ant|elaisomes|Dasyprocta|Melophorus|Pheidole|Iridomyrmex|Rhytidoponera)")) ~ "insect",
      stringr::str_detect(Value, stringr::regex("(?i)(barbed|generative dispersule|vegetative dispersule|tumbling|gravity|Baro|autochor|Unassisted|germinule|Barochory)")) ~ "auto",
      stringr::str_detect(Value, stringr::regex("(?i)(ballist|ballistic|Explosive|ballochor|Ball)")) ~ "ballistic",
      stringr::str_detect(Value, stringr::regex("(?i)(WP|wind|ane|passive)")) ~ "wind",
      stringr::str_detect(Value, stringr::regex("(?i)(water|hydro|dew|rain|hidr)")) ~ "water",
      stringr::str_detect(Value, stringr::regex("(?i)(machinery|vehicle|harvesting|mowing|man|hay cutting|hay making machinery|hay transport)")) ~ "vehicles",
      OriglName == "dispersal mode: dehiscent" ~ "auto",
      OriglName %in% c("wind.disp","dispersal mode: wind","disp_Abiotic", "disp.Passive") ~ "wind",
      DatasetID == 474 & grepl("^W", OrigValueStr)~ "wind",
      DatasetID == 474 & grepl("^E", OrigValueStr) | grepl("^Z", OrigValueStr) ~ "vertebrate",
      DatasetID == 474 & grepl("^G", OrigValueStr)  ~ "auto",
      DatasetID == 474 & grepl("^H", OrigValueStr)  ~ "water",
      DatasetID == 474 & grepl("^B", OrigValueStr)  ~ "ballistic",
      DatasetID == 474 & grepl("^M", OrigValueStr)  ~ "insect",
      DatasetID == 474 & grepl("^N", OrigValueStr) | grepl("^O", OrigValueStr) ~ "vertebrate",
      TRUE  ~ Value)
    ) |>
    dplyr::filter(
      !is.na(Value),
      Value %in% c("auto", "insect", "vertebrate", "water", "ballistic", "wind", "vehicles")
    ) |>
    dplyr::group_by(AccSpeciesName) |>
    dplyr::select(
      AccSpeciesName,
      Value,
      Reference
    )|>
    dplyr::mutate(Trait = "DispersalMode",
                  Units = as.character(NA),
                  Level = "taxon") |>
    dplyr::relocate(Trait, .before=Value) |>
    dplyr::relocate(Units, .after=Value) |>
    dplyr::relocate(Level, .after=Units) |>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_DispersalMode.rds")
  
  
  
  # LeafShape - TRY 43 ------------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_43.rds"))|>
    dplyr::mutate(
      Value = OrigValueStr
    ) |>
    dplyr::mutate(Value = dplyr::case_when(
      stringr::str_detect(OrigValueStr, stringr::regex("(?i)(b|broad|broadleaved|broad-leaved|broadleaf)")) ~ "Broad",
      stringr::str_detect(OrigValueStr, stringr::regex("(?i)(photosynthetic stem|Spines)")) ~ "Spines",
      stringr::str_detect(OrigValueStr, stringr::regex("(?i)(n|needleleaved|needle-leaved|needle-leaf)")) ~ "Needle",
      stringr::str_detect(OrigValueStr, stringr::regex("(?i)(scale-shaped|scale|scale-like|scale-leaf)")) ~ "Scale",
      stringr::str_detect(OriglName, stringr::regex("Leaf type: broad")) ~ "Broad",
      stringr::str_detect(OriglName, stringr::regex("Leaf type: scale")) ~ "Scale",
      TRUE ~ Value)) |>
    dplyr::filter(
      !is.na(Value),
      Value %in% c("Broad", "Needle", "Scale", "Spines")
    ) |>
    dplyr::select(
      AccSpeciesName,
      Value,
      Reference
    )|>
    dplyr::mutate(Trait = "LeafShape",
                  Units = as.character(NA),
                  Level = "taxon") |>
    dplyr::relocate(Trait, .before=Value) |>
    dplyr::relocate(Units, .after=Value) |>
    dplyr::relocate(Level, .after=Units) |>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafShape.rds")
  
  
  
  # PhenologyType - TRY 37 ------------------------------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_37.rds"))|>
    dplyr::mutate(
      Trait = "PhenologyType",
      Value = OrigValueStr,
      Units = as.character(NA)
    ) |>
    dplyr::mutate(Value = dplyr::case_when(
      DatasetID == 49  & Value == "Y" ~ "winter-deciduous",
      DatasetID == 49  & Value == "N" ~ "oneflush-evergreen",
      DatasetID == 241  & Value == "D" ~ "drought-semideciduous",
      DatasetID == 202  & Value == "1" ~ "drought-semideciduous",
      DatasetID %in% c(87, 319)  & OriglName == "Evergreen" ~ "oneflush-evergreen",
      DatasetID == 319  & OriglName == "Deciduous" ~ "winter-deciduous",
      DatasetID == 236 &  OriglName == "Leaf phenology: deciduous" ~ "winter-deciduous",
      DatasetID == 236 &  OriglName  == "Leaf phenology: evergreen" ~"oneflush-evergreen",
      DatasetID == 236 &  OriglName  == "Leaf phenology: semi-deciduous" ~"winter-semideciduous",
      
      DatasetID %in% c( 1, 20,37,72, 88, 89,96,111,180 ,279,340,342,410) & Value == "D" ~ "winter-deciduous",
      Value %in% c("D" , "DC") ~ "winter-deciduous",
      Value %in% c("E", "EV") ~ "oneflush-evergreen",
      Value == "SD" ~  "winter-semideciduous",
      Value == "W" ~"winter-deciduous",
      
      stringr::str_detect(Value, stringr::regex("(?i)(always overwintering green|evergreen|evergeen|always summer green|Evergreen broad-leaved|oneflush-evergreen|Evergreen scale-like|Evergreen needle-leaved|always persistent green|evergreen type 1|evergreen type 2)")) ~ "oneflush-evergreen",
      stringr::str_detect(Value, stringr::regex("(?i)(deciduous|Deciduous broad-leaved|Deciduous|Nonevergreen|winter deciduous|winter-deciduous|deciduous type 3|deciduous type 1|deciduous type 2|Deciduous needle-leaved|Deciduous scale-like)")) ~ "winter-deciduous",
      stringr::str_detect(Value, stringr::regex("(?i)(winter semi-deciduous|semi-deciduous|semi-evergreen|always spring green)")) ~ "winter-semideciduous",
      stringr::str_detect(Value, stringr::regex("(?i)(drought semi-deciduous|aestival)")) ~ "drought-semideciduous",
      TRUE ~ Value
    )) |>
    dplyr::filter(
      !is.na(Value),
      Value %in% c("oneflush-evergreen","winter-deciduous", "winter-semideciduous","drought-semideciduous" )
    ) |>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      Units,
      Reference
    )|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Level = "taxon", 
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_PhenologyType.rds")
  
  
  # PhotosynthesisPathway - TRY 22 ------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_22.rds"))|>
    dplyr::mutate(
      Trait = "PhotosyntheticPathway",
      Value = OrigValueStr,
      Units = as.character(NA)
    ) |>
    dplyr::filter(!is.na(Value),
                  Value %in% c("C3", "C4", "CAM"),
                  !ValueKindName %in% c("Maximum", "Minimum"))|>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      Units,
      Reference
    )|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName)|>
    dplyr::mutate(Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_PhotosyntheticPathway.rds")
  
  
  # WoodPorosityType - TRY 273 ----------------------------------------------
  db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_273.rds")) |>
    dplyr::mutate(
      Trait = "WoodPorosityType",
      Value = OrigValueStr,
      Units = as.character(NA)
    ) |>
    dplyr::filter(!is.na(Value),
                  !ValueKindName %in% c("Maximum", "Minimum"))|>
    dplyr::select(
      AccSpeciesName,
      Trait,
      Value,
      Units,
      OriglName,
      Reference
    )|>
    dplyr::rename(originalName = AccSpeciesName,
                  OriginalReference = Reference)|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
    dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
    dplyr::arrange(originalName) |>
    dplyr::filter(OriglName!="Deutlichkeit",
                  !startsWith(OriglName, "Growth ring boundaries")) |>
    dplyr::mutate(Value = dplyr::case_when(
      Value == "ring" ~ "ring-porous",
      Value == "Ring porous" ~ "ring-porous",
      Value == "Ring porous/learlywood" ~ "ring-porous",
      Value == "Diffuse porous" ~ "diffuse-porous",
      Value == "diffuse porous" ~ "diffuse-porous",
      Value == "diffuse" ~ "diffuse-porous",
      Value == "difuse" ~ "diffuse-porous",
      Value == "diffuse to semi-ring-porous" ~ "semi-ring-porous", 
      Value == "Semi diffuse porous" ~ "semi-ring-porous", 
      Value == "semi ring porous" ~ "semi-ring-porous",
      Value == "semi" ~ "semi-ring-porous",
      Value == "vesselless" ~ NA,
      Value == "Tracheids" ~ NA,
      Value == "non porous" ~ NA,
      OriglName == "Vessels:   Diffuse-porous" & Value == "yes" ~ "diffuse-porous",
      OriglName == "Vessels:   Ring porous." & Value == "yes" ~ "ring-porous",
      OriglName == "Vessels:   Semi-ring-porous" & Value == "yes" ~ "semi-ring-porous",
      TRUE ~ Value)) |>
    dplyr::filter(!is.na(Value)) |>
    dplyr::select(-OriglName)|>
    dplyr::mutate(Level = "taxon",
                  Reference = kattge_ref,
                  DOI = kattge_doi,
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = DOI)
  
  traits4models::check_harmonized_trait(db_var)
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  traits4models::check_harmonized_trait(db_post)
  saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodPorosityType.rds")

}


# ntfy_send("TRY harmonization finished!", auth = TRUE)
