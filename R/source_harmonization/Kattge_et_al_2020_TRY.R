#
# Kattge et al (2020) - TRY
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"


# GrowthForm - TRY 3400 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_3400.rds")) |>
#   dplyr::rename(
#     GrowthForm = OrigValueStr
#   ) |>
#   dplyr::mutate(
#     GrowthForm = stringr::str_replace(GrowthForm, "tree", "Tree"),
#     GrowthForm = stringr::str_replace(GrowthForm, "shrub", "Shrub"),
#     GrowthForm = stringr::str_replace(GrowthForm, "herb", "Herb"),
#     GrowthForm = stringr::str_replace(GrowthForm, "other", "Other"),
#     GrowthForm = stringr::str_replace(GrowthForm, "Shrub/Tree", "Tree/Shrub"),
#     GrowthForm = stringr::str_replace(GrowthForm, "Herb/Shrub", "Shrub/Herb"),
#     GrowthForm = stringr::str_replace(GrowthForm, "Herb/Tree", "Tree/Herb"),
#     GrowthForm = stringr::str_replace(GrowthForm, "Tree/Herb/Shrub", "Tree/Shrub/Herb")
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     GrowthForm,
#     Reference
#   ) |>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_GrowthForm.rds")
# 

# # LifeForm - TRY 343 -----------------------------------------------------------------
# 
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_343.rds"))  |>
#   dplyr::mutate(
#     LifeForm = OrigValueStr
#    ) |>
#   dplyr::filter(
#     !is.na(LifeForm),
#     #  verifica si la variable LifeForm no está vacia y contiene al menos una letra del alfabeto.
#     LifeForm != "" & grepl("[[:alpha:]]", LifeForm)
#   ) |>
#   dplyr::mutate(
#     #  elimina todos los caracteres que no son letras, dígitos o espacios en blanco de la variable LifeForm y luego crea una nueva versión de LifeForm
#     LifeForm = gsub("[^[:alnum:]\\s]", "", LifeForm)) |>
#   dplyr::mutate(
#     LifeForm = dplyr::case_when(
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Cha|Hemiphanerophyte)")) ~ "Chamaephyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hemic)")) ~ "Hemicryptophyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
#       stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(thero|tero)")) ~ "Therophyte",
#       TRUE ~ LifeForm
#     )
#   ) |>
#   dplyr::mutate(
#     LifeForm = dplyr::case_when(
#       LifeForm == "Geophytes" ~ "Cryptophyte",
#       LifeForm == "G" ~ "Geophytes",
#       LifeForm == "Chamaephytes" ~ "Chamaephyte",
#       LifeForm == "Ch" ~ "Chamaephyte",
#       LifeForm == "CH" ~ "Chamaephyte",
#       LifeForm == "Hemicryptophytes" ~ "Hemicryptophyte",
#       LifeForm == "H" ~ "Hemicryptophyte",
#       LifeForm %in% c("Hydrophytes", "Helophytes") ~ "Hydrophyte",
#       LifeForm == "Therophytes" ~ "Therophyte",
#       LifeForm == "T" ~ "Therophyte",
#       LifeForm == "TH" ~ "Therophyte",
#       LifeForm %in% c("Phanerophytes", "Mega meso micro nanophanerophyte") ~ "Phanerophyte",
#       LifeForm == "P" ~ "Phanerophyte",
#       LifeForm == "Ph" ~ "Phanerophyte",
#       DatasetID == 202 & LifeForm %in% c(1, 2) ~ "Phanerophyte",
#       DatasetID == 202 & LifeForm %in% c(3, 4) ~ "Chamaephyte",
#       DatasetID == 202 & LifeForm %in% c(5, 6, 7) ~ "Hemicryptophyte",
#       DatasetID == 202 & LifeForm == "8" ~ "Therophyte",
#       DatasetID %in% c("174", "178") &  OrigValueStr == "Mega meso and microphanerophyte" ~ "Phanerophyte",
#       DatasetID == 37  & LifeForm == "1" ~ "Therophyte",
#       DatasetID == 37  & LifeForm == "2" ~ "Cryptophyte",
#       DatasetID == 37  & LifeForm == "3" ~ "Hemicryptophyte",
#       DatasetID == 37  & LifeForm == "4" ~ "Chamaephyte",
#       DatasetID == 37  & LifeForm == "5" ~ "Phanerophyte",
#       TRUE ~ LifeForm
#     )) |>
#   dplyr::filter(
#     !is.na(LifeForm),
#     LifeForm %in% c("Phanerophyte","Chamaephyte","Cryptophyte", "Hydrophyte","Therophyte","Epiphyte", "Hemicryptophyte")
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     LifeForm,
#     Reference
#   ) |>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LifeForm.rds")
# 
# # DispersalMode - TRY 28 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_28.rds")) |>
#    dplyr::mutate(
#      DispersalType = OrigValueStr
#    )  |>
#    dplyr::arrange(AccSpeciesName)  |>
#    dplyr::filter(
#     !( DatasetID %in% c(565,299))
#    ) |>
#    dplyr::mutate(DispersalType = dplyr::case_when(
#       OriglName %in% c("disp_Biotic", "AnimalSpecies", "AnimalGroup", "dispersal mode: endozoochory") ~ "animal",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(fleshy|Epi|clothes and footwear|adhesion|animal|pintail|squirrel|goat|pet|bighorn|Zooch|rabbit|snail|zoo|mamal|Ornithochory|dog|badger|turtles|fox|hedgehog|marten|buffalo|boar|hare|dog|donkey|marmot|cattle|pig|deer|sheep|fish|horse|vertebrate|bird|mammal|Anchorage)")) ~ "vertebrate",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(roe|shrew|mouse|Hydrochoerus|Thomomys|Ctenomys|Heteromys|Marmota|Dasyprocta|Cuniculus|Rattus|Sigmodon|Myodes|Oryzomys|Aplodontia|Erethizon|Microtus|Peromyscus|pacarana|Myadestes|Myoprocta|Sciurus|Squirrel|Dasyprocta)")) ~ "rodent",
#       stringr::str_detect(DispersalType, stringr::regex("(?i)(mirmecochory|ant|elaisomes|Dasyprocta|Melophorus|Pheidole|Iridomyrmex|Rhytidoponera)")) ~ "ant",
#       stringr::str_detect(DispersalType, stringr::regex("(?i)(barbed|generative dispersule|vegetative dispersule|tumbling|gravity|Baro|autochor|Unassisted|germinule|Barochory)")) ~ "auto",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(ballist|ballistic|Explosive|ballochor|Ball)")) ~ "ballistic",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(WP|wind|ane|passive)")) ~ "wind",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(water|hydro|dew|rain|hidr)")) ~ "water",
#      stringr::str_detect(DispersalType, stringr::regex("(?i)(machinery|vehicle|harvesting|mowing|man|hay cutting|hay making machinery|hay transport)")) ~ "vehicles",
#      OriglName == "dispersal mode: dehiscent" ~ "auto",
#      OriglName %in% c("wind.disp","dispersal mode: wind","disp_Abiotic", "disp.Passive") ~ "wind",
#      DatasetID == 474 & grepl("^W", OrigValueStr)~ "wind",
#      DatasetID == 474 & grepl("^E", OrigValueStr) | grepl("^Z", OrigValueStr) ~ "vertebrate",
#      DatasetID == 474 & grepl("^G", OrigValueStr)  ~ "auto",
#      DatasetID == 474 & grepl("^H", OrigValueStr)  ~ "water",
#      DatasetID == 474 & grepl("^B", OrigValueStr)  ~ "ballistic",
#      DatasetID == 474 & grepl("^M", OrigValueStr)  ~ "ant",
#      DatasetID == 474 & grepl("^N", OrigValueStr) | grepl("^O", OrigValueStr) ~ "vertebrate",
#      TRUE  ~ DispersalType)
#    ) |>
#    dplyr::filter(
#      !is.na(DispersalType),
#      DispersalType %in% c("auto", "ant", "vertebrate", "water", "ballistic", "wind", "rodent")
#    ) |>
#    dplyr::group_by(AccSpeciesName) |>
#    dplyr::select(
#      AccSpeciesName,
#      DispersalType,
#      Reference
#    )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_DispersalMode.rds")
# 
# 
# 
# # LeafShape - TRY 43 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_43.rds"))|>
#   dplyr::mutate(
#     LeafShape = OrigValueStr
#   ) |>
#   dplyr::mutate(LeafShape = dplyr::case_when(
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(b|broad|broadleaved|broad-leaved|broadleaf)")) ~ "Broad",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(photosynthetic stem|Spines)")) ~ "Spines",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(n|needleleaved|needle-leaved|needle-leaf)")) ~ "Needle",
#     stringr::str_detect(OrigValueStr, stringr::regex("(?i)(scale-shaped|scale|scale-like|scale-leaf)")) ~ "Scale",
#     stringr::str_detect(OriglName, stringr::regex("Leaf type: broad")) ~ "Broad",
#     stringr::str_detect(OriglName, stringr::regex("Leaf type: scale")) ~ "Scale",
#     TRUE ~ LeafShape)) |>
#   dplyr::filter(
#     !is.na(LeafShape),
#     LeafShape %in% c("Broad", "Needle", "Scale", "Spines")
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafShape,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafShape.rds")
# 
# 
# 
# # LeafArea - TRY_3110 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_3110.rds"))|>
#   dplyr::mutate(
#     LeafArea = StdValue) |>
#   dplyr::filter(
#     !is.na(LeafArea)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafArea,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafArea.rds")
# 
# 
# 
# # PhenologyType - TRY 37 ------------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_37.rds"))|>
#   dplyr::mutate(
#     PhenologyType = OrigValueStr
#   ) |>
#   dplyr::mutate(PhenologyType = dplyr::case_when(
#     DatasetID == 49  & PhenologyType == "Y" ~ "winter-deciduous",
#     DatasetID == 49  & PhenologyType == "N" ~ "oneflush-evergreen",
#     DatasetID == 241  & PhenologyType == "D" ~ "drought-semideciduous",
#     DatasetID == 202  & PhenologyType == "1" ~ "drought-semideciduous",
#     DatasetID %in% c(87, 319)  & OriglName == "Evergreen" ~ "oneflush-evergreen",
#     DatasetID == 319  & OriglName == "Deciduous" ~ "winter-deciduous",
#     DatasetID == 236 &  OriglName == "Leaf phenology: deciduous" ~ "winter-deciduous",
#     DatasetID == 236 &  OriglName  == "Leaf phenology: evergreen" ~"oneflush-evergreen",
#     DatasetID == 236 &  OriglName  == "Leaf phenology: semi-deciduous" ~"winter-semideciduous",
# 
#     DatasetID %in% c( 1, 20,37,72, 88, 89,96,111,180 ,279,340,342,410) & PhenologyType == "D" ~ "winter-deciduous",
#     PhenologyType %in% c("D" , "DC") ~ "winter-deciduous",
#     PhenologyType %in% c("E", "EV") ~ "oneflush-evergreen",
#     PhenologyType == "SD" ~  "winter-semideciduous",
#     PhenologyType == "W" ~"winter-deciduous",
# 
#     stringr::str_detect(PhenologyType, stringr::regex("(?i)(always overwintering green|evergreen|evergeen|always summer green|Evergreen broad-leaved|oneflush-evergreen|Evergreen scale-like|Evergreen needle-leaved|always persistent green|evergreen type 1|evergreen type 2)")) ~ "oneflush-evergreen",
#     stringr::str_detect(PhenologyType, stringr::regex("(?i)(deciduous|Deciduous broad-leaved|Deciduous|Nonevergreen|winter deciduous|winter-deciduous|deciduous type 3|deciduous type 1|deciduous type 2|Deciduous needle-leaved|Deciduous scale-like)")) ~ "winter-deciduous",
#     stringr::str_detect(PhenologyType, stringr::regex("(?i)(winter semi-deciduous|semi-deciduous|semi-evergreen|always spring green)")) ~ "winter-semideciduous",
#     stringr::str_detect(PhenologyType, stringr::regex("(?i)(drought semi-deciduous|aestival)")) ~ "drought-semideciduous",
#     TRUE ~ PhenologyType
#   )) |>
#   dplyr::filter(
#     !is.na(PhenologyType),
#     PhenologyType %in% c("oneflush-evergreen","winter-deciduous", "winter-semideciduous","drought-semideciduous" )
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     PhenologyType,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_PhenologyType.rds")
# 
# 
# # Hact - TRY 3106 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_3106.rds")) |>
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
#     Hact = StdValue*100, # From m to cm
#     Units = "cm"
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Hact,
#     Units,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# 
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Hact.rds")
# 
# 
# # LeafDuration - TRY_12 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_12.rds"))|>
#   dplyr::mutate(
#     LeafDuration = StdValue) |>
#   dplyr::filter(
#     !is.na(LeafDuration)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafDuration,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::mutate(LeafDuration = LeafDuration/12, Units = "yr") |> # From months to yr
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafDuration.rds")
# 
# 
# # Z95 - TRY_12 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_6.rds"))|>
#   dplyr::mutate(
#     Z95 = StdValue) |>
#   dplyr::filter(
#     !is.na(Z95)
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     Z95,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::mutate(Z95 = Z95*1000, Units = "mm") |> # From m to mm
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Z95.rds")
# 
# 
# # SLA - TRY_3117 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_3117.rds"))|>
#   dplyr::mutate(
#     SLA = StdValue) |>
#   dplyr::filter(
#     !is.na(SLA),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     SLA,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_SLA.rds")
# 
# # LeafDensity - TRY_48 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_48.rds"))|>
#   dplyr::mutate(
#     LeafDensity = StdValue) |>
#   dplyr::filter(
#     !is.na(LeafDensity),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafDensity,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafDensity.rds")
# 
# 
# # WoodDensity - TRY_4 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_4.rds"))|>
#   dplyr::mutate(
#     WoodDensity = StdValue) |>
#   dplyr::filter(
#     !is.na(WoodDensity),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     WoodDensity,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
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
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_WoodDensity.rds")

# Al2As NOT DONE - TRY_171 ----------------------------------------------------------------
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="Huber value"]<-1/as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="Huber value"])
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="leaf.area.per.sapwood.area"]<-TRY_Al2As$StdValue[TRY_Al2As$OriglName=="leaf.area.per.sapwood.area"]*100
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="Sapwood: leaf area ratio"]<-10000/as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="Sapwood: leaf area ratio"])
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="The ratio of leaf area attached per unit sapwood cross-section area (m2 cm-2)"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="The ratio of leaf area attached per unit sapwood cross-section area (m2 cm-2)"])
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="values at base of living crown, m2/cm2"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="values at base of living crown, m2/cm2"])
# TRY_Al2As$StdValue[TRY_Al2As$OriglName=="values at breast height, m2/cm2"]<-10000*as.numeric(TRY_Al2As$OrigValueStr[TRY_Al2As$OriglName=="values at breast height, m2/cm2"])
# TRY_Al2As <- TRY_Al2As[TRY_Al2As$ErrorRisk <3, c("AccSpeciesName", "StdValue")]
# 
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_171.rds"))|>
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
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_WoodDensity.rds")


# # LeafWidth - TRY_145 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_145.rds"))|>
#   dplyr::mutate(
#     LeafWidth = StdValue) |>
#   dplyr::filter(
#     !is.na(LeafWidth),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafWidth,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
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
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafWidth.rds")

# # SRL - TRY_614 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_614.rds"))|>
#   dplyr::mutate(
#     SRL = StdValue) |>
#   dplyr::filter(
#     !is.na(SRL),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     SRL,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_SRL.rds")
# 
# # LeafPI0 - TRY_188 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_188.rds"))|>
#   dplyr::mutate(
#     LeafPI0 = StdValue) |>
#   dplyr::filter(
#     !is.na(LeafPI0),
#     ErrorRisk < 3
#   ) |>
#   dplyr::arrange(AccSpeciesName) |>
#   dplyr::select(
#     AccSpeciesName,
#     LeafPI0,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::mutate(LeafPI0 = -1*as.numeric(LeafPI0), Units = "MPa")|> # From -MPa to MPa
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafPI0.rds")
# 
# # LeafEPS - TRY_190 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_190.rds"))|>
#   dplyr::mutate(
#     LeafEPS = as.numeric(OrigValueStr)) |>
#   dplyr::filter(
#     !is.na(LeafEPS),
#   ) |>
#   dplyr::mutate(Units = "MPa")|>
#   dplyr::select(
#     AccSpeciesName,
#     LeafEPS,
#     Units,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafEPS.rds")

# # LigninPercent - TRY_87 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_87.rds"))|>
#   dplyr::mutate(
#     LigninPercent = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(LigninPercent),
#     ErrorRisk < 3
#   ) |>
#   dplyr::mutate(LigninPercent = LigninPercent/10, UnitName = "%") |> # from mg·g-1 to %
#   dplyr::select(
#     AccSpeciesName,
#     LigninPercent,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LigninPercent.rds")

# # Nleaf - TRY_14 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_14.rds"))|>
#   dplyr::mutate(
#     Nleaf = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Nleaf),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Nleaf,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Nleaf.rds")

# # Nsapwood - TRY_1229 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_1229.rds"))|>
#   dplyr::mutate(
#     Nsapwood = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Nsapwood),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Nsapwood,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Nsapwood.rds")

# # Nfineroot- TRY_475 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_475.rds"))|>
#   dplyr::mutate(
#     Nfineroot = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Nfineroot),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Nfineroot,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Nfineroot.rds")
# 
# # Vmax- TRY_186 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_186.rds"))|>
#   dplyr::mutate(
#     Vmax = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Vmax),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Vmax,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Vmax.rds")
# 
# # Jmax- TRY_269 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_269.rds"))|>
#   dplyr::mutate(
#     Jmax = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(Jmax),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     Jmax,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_Jmax.rds")

# 
# # WoodC- TRY_407 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_407.rds"))|>
#   dplyr::mutate(
#     WoodC = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(WoodC),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     WoodC,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::mutate(WoodC = WoodC/1000, Units = "gC·g-1") |> # From mg/g to g/g
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_WoodC.rds")
# 
# 
# # RERleaf- TRY_407 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_41.rds"))|>
#   dplyr::mutate(
#     RERleaf = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(RERleaf),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     RERleaf,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::mutate(RERleaf = 24.0*3600.0*(RERleaf/6.0)*(1e-6)*180.156,
#                 Units = "g gluc · g dry-1 · day-1")
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_RERleaf.rds")
# 
# 
# # SeedMass- TRY_26 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_26.rds"))|>
#   dplyr::mutate(
#     SeedMass = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(SeedMass),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     SeedMass,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_SeedMass.rds")

# # LeafAngle- TRY_3 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_3.rds"))|>
#   dplyr::filter(
#     !is.na(as.numeric(OrigValueStr)),
#   ) |>
#   dplyr::mutate(
#     LeafAngle = as.numeric(OrigValueStr)) |>
#   dplyr::mutate(Units = "degree")|>
#   dplyr::select(
#     AccSpeciesName,
#     LeafAngle,
#     Units,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_LeafAngle.rds")
# 

# 
# # SeedLongevity- TRY_26 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_33.rds"))|>
#   dplyr::mutate(
#     SeedLongevity = as.numeric(StdValue)) |>
#   dplyr::filter(
#     !is.na(SeedLongevity),
#     ErrorRisk < 3
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     SeedLongevity,
#     UnitName,
#     Reference
#   )|>
#   dplyr::rename(Units = UnitName)|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_SeedLongevity.rds")
# 

# ShadeTolerance- TRY_603 ----------------------------------------------------------------
# db_var <- readRDS(paste0(DB_path, "Sources/Kattge_et_al_2020_TRY/TRY_traits/TRY_603.rds"))|>
#   dplyr::filter(DatasetID == 49) |>
#   dplyr::mutate(
#     ShadeTolerance = as.numeric(OrigValueStr)) |>
#   dplyr::filter(
#     !is.na(ShadeTolerance)
#   ) |>
#   dplyr::select(
#     AccSpeciesName,
#     ShadeTolerance,
#     Reference
#   )|>
#   dplyr::rename(originalName = AccSpeciesName)|>
#   dplyr::mutate(
#     originalName = gsub("\u0081|", "", originalName)) |>
#   dplyr::mutate(originalName = paste0(substring(originalName,1,1), tolower(substring(originalName, 2)))) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::arrange(originalName)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Kattge_et_al_2020_ShadeTol.rds")


