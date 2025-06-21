#
# Kattge et al (2020) - TRY
#
library(ntfy)

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")


kattge_ref <- "Kattge et al. (2020) TRY plant trait database – enhanced coverage and open access. Global Change Biology 26:119–188."
kattge_doi <- "10.1038/s41597-021-01006-6"



# # GrowthForm - TRY 3400 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3400.rds")) |>
#   dplyr::rename(
#     Value = OrigValueStr
#   ) |>
#   dplyr::mutate(
#     Value = stringr::str_replace(Value, "tree", "Tree"),
#     Value = stringr::str_replace(Value, "shrub", "Shrub"),
#     Value = stringr::str_replace(Value, "herb", "Herb"),
#     Value = stringr::str_replace(Value, "other", "Other"),
#     Value = stringr::str_replace(Value, "Shrub/Tree", "Tree/Shrub"),
#     Value = stringr::str_replace(Value, "Herb/Shrub", "Shrub/Herb"),
#     Value = stringr::str_replace(Value, "Herb/Tree", "Tree/Herb"),
#     Value = stringr::str_replace(Value, "Tree/Herb/Shrub", "Tree/Shrub/Herb")
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Value,
#     Reference
#   ) |>
#   dplyr::mutate(Trait = "GrowthForm",
#                 Units = as.character(NA)) |>
#   dplyr::relocate(Trait, .before=Value) |>
#   dplyr::relocate(Units, .after=Value) |>
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
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_GrowthForm.rds")

# LifeForm - TRY 343 -----------------------------------------------------------------
# 
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
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LifeForm.rds")
# 
# DispersalMode - TRY 28 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_28.rds")) |>
#    dplyr::mutate(
#      Value = OrigValueStr
#    )  |>
#    dplyr::arrange(AccSpeciesName)  |>
#    dplyr::filter(
#     !( DatasetID %in% c(565,299))
#    ) |>
#    dplyr::mutate(Value = dplyr::case_when(
#       OriglName %in% c("disp_Biotic", "AnimalSpecies", "AnimalGroup", "dispersal mode: endozoochory") ~ "animal",
#      stringr::str_detect(Value, stringr::regex("(?i)(fleshy|Epi|clothes and footwear|adhesion|animal|pintail|squirrel|goat|pet|bighorn|Zooch|rabbit|snail|zoo|mamal|Ornithochory|dog|badger|turtles|fox|hedgehog|marten|buffalo|boar|hare|dog|donkey|marmot|cattle|pig|deer|sheep|fish|horse|vertebrate|bird|mammal|Anchorage)")) ~ "vertebrate",
#      stringr::str_detect(Value, stringr::regex("(?i)(roe|shrew|mouse|Hydrochoerus|Thomomys|Ctenomys|Heteromys|Marmota|Dasyprocta|Cuniculus|Rattus|Sigmodon|Myodes|Oryzomys|Aplodontia|Erethizon|Microtus|Peromyscus|pacarana|Myadestes|Myoprocta|Sciurus|Squirrel|Dasyprocta)")) ~ "rodent",
#       stringr::str_detect(Value, stringr::regex("(?i)(mirmecochory|ant|elaisomes|Dasyprocta|Melophorus|Pheidole|Iridomyrmex|Rhytidoponera)")) ~ "ant",
#       stringr::str_detect(Value, stringr::regex("(?i)(barbed|generative dispersule|vegetative dispersule|tumbling|gravity|Baro|autochor|Unassisted|germinule|Barochory)")) ~ "auto",
#      stringr::str_detect(Value, stringr::regex("(?i)(ballist|ballistic|Explosive|ballochor|Ball)")) ~ "ballistic",
#      stringr::str_detect(Value, stringr::regex("(?i)(WP|wind|ane|passive)")) ~ "wind",
#      stringr::str_detect(Value, stringr::regex("(?i)(water|hydro|dew|rain|hidr)")) ~ "water",
#      stringr::str_detect(Value, stringr::regex("(?i)(machinery|vehicle|harvesting|mowing|man|hay cutting|hay making machinery|hay transport)")) ~ "vehicles",
#      OriglName == "dispersal mode: dehiscent" ~ "auto",
#      OriglName %in% c("wind.disp","dispersal mode: wind","disp_Abiotic", "disp.Passive") ~ "wind",
#      DatasetID == 474 & grepl("^W", OrigValueStr)~ "wind",
#      DatasetID == 474 & grepl("^E", OrigValueStr) | grepl("^Z", OrigValueStr) ~ "vertebrate",
#      DatasetID == 474 & grepl("^G", OrigValueStr)  ~ "auto",
#      DatasetID == 474 & grepl("^H", OrigValueStr)  ~ "water",
#      DatasetID == 474 & grepl("^B", OrigValueStr)  ~ "ballistic",
#      DatasetID == 474 & grepl("^M", OrigValueStr)  ~ "ant",
#      DatasetID == 474 & grepl("^N", OrigValueStr) | grepl("^O", OrigValueStr) ~ "vertebrate",
#      TRUE  ~ Value)
#    ) |>
#    dplyr::filter(
#      !is.na(Value),
#      Value %in% c("auto", "ant", "vertebrate", "water", "ballistic", "wind", "rodent")
#    ) |>
#    dplyr::group_by(AccSpeciesName) |>
#    dplyr::select(
#      AccSpeciesName,
#      Value,
#      Reference
#    )|>
#   dplyr::mutate(Trait = "DispersalMode",
#                 Units = as.character(NA)) |>
#   dplyr::relocate(Trait, .before=Value) |>
#   dplyr::relocate(Units, .after=Value) |>
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
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_DispersalMode.rds")

# 
# 
# # LeafShape - TRY 43 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_43.rds"))|>
#   dplyr::mutate(
#     Value = OrigValueStr
#   ) |>
#   dplyr::mutate(Value = dplyr::case_when(
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(b|broad|broadleaved|broad-leaved|broadleaf)")) ~ "Broad",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(photosynthetic stem|Spines)")) ~ "Spines",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(n|needleleaved|needle-leaved|needle-leaf)")) ~ "Needle",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(scale-shaped|scale|scale-like|scale-leaf)")) ~ "Scale",
#     stringr::str_detect(OriglName, stringr::regex("Leaf type: broad")) ~ "Broad",
#     stringr::str_detect(OriglName, stringr::regex("Leaf type: scale")) ~ "Scale",
#     TRUE ~ Value)) |>
#   dplyr::filter(
#     !is.na(Value),
#     Value %in% c("Broad", "Needle", "Scale", "Spines")
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Value,
#     Reference
#   )|>
#   dplyr::mutate(Trait = "LeafShape",
#                 Units = as.character(NA)) |>
#   dplyr::relocate(Trait, .before=Value) |>
#   dplyr::relocate(Units, .after=Value) |>
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
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafShape.rds")
# 


# LeafArea - TRY_3110 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3110.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafArea",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
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
# #Check units (mm2)
# table(db_var$Units)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafArea.rds")


# PhenologyType - TRY 37 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_37.rds"))|>
#   dplyr::mutate(
#     Trait = "PhenologyType",
#     Value = OrigValueStr,
#     Units = as.character(NA)
#   ) |>
#   dplyr::mutate(Value = dplyr::case_when(
#     DatasetID == 49  & Value == "Y" ~ "winter-deciduous",
#     DatasetID == 49  & Value == "N" ~ "oneflush-evergreen",
#     DatasetID == 241  & Value == "D" ~ "drought-semideciduous",
#     DatasetID == 202  & Value == "1" ~ "drought-semideciduous",
#     DatasetID %in% c(87, 319)  & OriglName == "Evergreen" ~ "oneflush-evergreen",
#     DatasetID == 319  & OriglName == "Deciduous" ~ "winter-deciduous",
#     DatasetID == 236 &  OriglName == "Leaf phenology: deciduous" ~ "winter-deciduous",
#     DatasetID == 236 &  OriglName  == "Leaf phenology: evergreen" ~"oneflush-evergreen",
#     DatasetID == 236 &  OriglName  == "Leaf phenology: semi-deciduous" ~"winter-semideciduous",
# 
#     DatasetID %in% c( 1, 20,37,72, 88, 89,96,111,180 ,279,340,342,410) & Value == "D" ~ "winter-deciduous",
#     Value %in% c("D" , "DC") ~ "winter-deciduous",
#     Value %in% c("E", "EV") ~ "oneflush-evergreen",
#     Value == "SD" ~  "winter-semideciduous",
#     Value == "W" ~"winter-deciduous",
# 
#     stringr::str_detect(Value, stringr::regex("(?i)(always overwintering green|evergreen|evergeen|always summer green|Evergreen broad-leaved|oneflush-evergreen|Evergreen scale-like|Evergreen needle-leaved|always persistent green|evergreen type 1|evergreen type 2)")) ~ "oneflush-evergreen",
#     stringr::str_detect(Value, stringr::regex("(?i)(deciduous|Deciduous broad-leaved|Deciduous|Nonevergreen|winter deciduous|winter-deciduous|deciduous type 3|deciduous type 1|deciduous type 2|Deciduous needle-leaved|Deciduous scale-like)")) ~ "winter-deciduous",
#     stringr::str_detect(Value, stringr::regex("(?i)(winter semi-deciduous|semi-deciduous|semi-evergreen|always spring green)")) ~ "winter-semideciduous",
#     stringr::str_detect(Value, stringr::regex("(?i)(drought semi-deciduous|aestival)")) ~ "drought-semideciduous",
#     TRUE ~ Value
#   )) |>
#   dplyr::filter(
#     !is.na(Value),
#     Value %in% c("oneflush-evergreen","winter-deciduous", "winter-semideciduous","drought-semideciduous" )
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     Units,
#     Reference
#   )|>
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
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_PhenologyType.rds")


# Hact - TRY 3106 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3106.rds")) |>
#   dplyr::select(
#     AccSpeciesName,
#     DatasetID,
#     DataName,
#     OriglName,
#     StdValue,
#     UnitName,
#     ErrorRisk,
#     Reference) |>
#   dplyr::filter(
#     !is.na(StdValue),
#     ErrorRisk < 3
#   ) |>
#   dplyr::mutate(
#     Trait = "Hact",
#     Value = StdValue*100, # From m to cm
#     Units = "cm"
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     Units,
#     Reference
#   )|>
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
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Hact.rds")
# 

# LeafDuration - TRY_12 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_12.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafDuration",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# 
# #Check units (year)
# table(db_var$Units)
# db_var <- db_var|>
#   dplyr::mutate(Value = Value/12, 
#                 Units = "year") # From months to yr
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#     dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafDuration.rds")
# 

# Z95 - TRY_12 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_6.rds"))|>
#   dplyr::mutate(
#     Trait = "Z95",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# 
# #Check units (mm)
# table(db_var$Units)
# db_var <- db_var|>
#   dplyr::mutate(Value = Value*1000,
#                 Units = "mm") # From m to mm
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#     dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Z95.rds")
# 

# SLA - TRY_3117 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3117.rds"))|>
#   dplyr::mutate(
#     Trait = "SLA",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mm2 mg-1)
# table(db_var$Units)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#     dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SLA.rds")

# LeafDensity - TRY_48 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_48.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafDensity",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (g cm-3)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "g cm-3")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafDensity.rds")


# WoodDensity - TRY_4 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_4.rds"))|>
#   dplyr::mutate(
#     Trait = "WoodDensity",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3,
#     !is.na(AccSpeciesName)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::filter(originalName != "Tilia \xd7moltkei") |>
#   dplyr::mutate(
#       originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (g cm-3)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "g cm-3")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodDensity.rds")

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
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_145.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafWidth",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::filter(originalName != "Jasminum meyeri\xfbjohannis") |>
#   dplyr::mutate(
#       originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (cm)
# table(db_var$Units)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafWidth.rds")

# SRL - TRY_614 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_614.rds"))|>
#   dplyr::mutate(
#     Trait = "SRL",
#     Value = StdValue) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (cm g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "cm g-1")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SRL.rds")

# LeafPI0 - TRY_188 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_188.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafPI0",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (cm g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Value = -1*Value, 
#                 Units = "MPa") # From -MPa to MPa
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafPI0.rds")

# LeafEPS - TRY_190 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_190.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafEPS",
#     Value = as.numeric(OrigValueStr)) |>
#   dplyr::filter(
#     !is.na(Value),
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (MPa)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "MPa")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafEPS.rds")

# LigninPercent - TRY_87 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_87.rds"))|>
#   dplyr::mutate(
#     Trait = "LigninPercent",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units ()
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Value = Value/10, 
#                 Units = "%") # from mg·g-1 to %
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LigninPercent.rds")

# Nleaf - TRY_14 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_14.rds"))|>
#   dplyr::mutate(
#     Trait = "Nleaf",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference) |>
#   dplyr::filter(originalName != "Sorghum \xd7 drummondii") |>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mg g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "mg g-1") 
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nleaf.rds")

# Nsapwood - TRY_1229 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_1229.rds"))|>
#   dplyr::mutate(
#     Trait = "Nsapwood",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mg g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "mg g-1") 
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nsapwood.rds")

# Nfineroot- TRY_475 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_475.rds"))|>
#   dplyr::mutate(
#     Trait = "Nfineroot",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mg g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "mg g-1") 
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Nfineroot.rds")

# Vmax- TRY_186 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_186.rds"))|>
#   dplyr::mutate(
#     Trait = "Vmax",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (umol m-2 s-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "umol m-2 s-1")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Vmax.rds")

# Jmax- TRY_269 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_269.rds"))|>
#   dplyr::mutate(
#     Trait = "Jmax",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (umol m-2 s-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Units = "umol m-2 s-1")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_Jmax.rds")


# WoodC- TRY_407 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_407.rds"))|>
#   dplyr::mutate(
#     Trait = "WoodC",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mg g-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Value = Value/1000,
#                 Units = "g g-1") # From mg/g to g/g
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_WoodC.rds")


# RERleaf- TRY_407 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_41.rds"))|>
#   dplyr::mutate(
#     Trait = "RERleaf",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = "AccSpeciesName",
#                 OriginalReference = "Reference")|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#     dplyr::mutate(Reference = kattge_ref,
#                   DOI = kattge_doi,
#                   Priority = 1) |>
#     dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (g g-1 day-1)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Value = 24.0*3600.0*(Value/6.0)*(1e-6)*180.156, # From umol C/g/s to g gluc/g/day
#                 Units = "g g-1 day-1") 
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_RERleaf.rds")


# SeedMass- TRY_26 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_26.rds"))|>
#   dplyr::mutate(
#     Trait = "SeedMass",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (mg)
# table(db_var$Units)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SeedMass.rds")

# LeafAngle- TRY_3 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_3.rds"))|>
#   dplyr::mutate(
#     Trait = "LeafAngle",
#     Value = as.numeric(OrigValueStr)) |>
#   dplyr::filter(!is.na(Value),
#                 Value >= 0,
#                 Value <=90) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (degree)
# table(db_var$Units)
# summary(db_var$Value)
# db_var <- db_var |>
#   dplyr::mutate(Units = "degree")
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_LeafAngle.rds")


# SeedLongevity- TRY_26 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_33.rds"))|>
#   dplyr::mutate(
#     Trait = "SeedLongevity",
#     Value = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Value),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(Reference = kattge_ref,
#                   DOI = kattge_doi,
#                   Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (year)
# table(db_var$Units)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_SeedLongevity.rds")

# ShadeTolerance- TRY_603 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "data-raw/raw_trait_data/Kattge_et_al_2020_TRY/TRY_traits/TRY_603.rds"))|>
#   dplyr::filter(DatasetID == 49) |>
#   dplyr::mutate(
#     Trait = "ShadeTolerance",
#     Value = as.numeric(OrigValueStr),
#     Units = as.character(NA)) |>
#   dplyr::filter(
#     !is.na(Value)
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Trait,
#     Value,
#     Units,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName,
#                 OriginalReference = Reference)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)|>
#   dplyr::mutate(Reference = kattge_ref,
#                 DOI = kattge_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# #Check units (0-5)
# db_var <- db_var |>
#   dplyr::filter(Value>=0 & Value <=5)
# traits4models::check_harmonized_trait(db_var)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Kattge_et_al_2020_ShadeTol.rds")




# ntfy_send("TRY harmonization finished!", auth = TRUE)
