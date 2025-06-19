#
# Baez et al. (2022) - FUNANDES
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
fun_db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Baez_et_al_2022_FUNANDES/fundb_TRY_open_20220428.csv"))

# Stem-specific conductivity --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Wood_(sapwood)_specific_conductivity_(stem_specific_conductivity)")|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "Ks",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units (kg m-1 MPa-1 s-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "kg m-1 MPa-1 s-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_Ks.rds")

# Bark thickness --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Bark_thickness")|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "BarkThickness",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units (mm)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_BarkThickness.rds")

# Nleaf --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf_nitrogen_(N)_content_per_leaf_dry_mass")|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "Nleaf",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units (mg g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_Nleaf.rds")

# WoodDensity --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName %in% c("Stem_dry_mass_per_stem_fresh_volume_(stem_specific_density,_SSD,_wood_density)_branch", 
                                    "Stem_dry_mass_per_stem_fresh_volume_(stem_specific_density,_SSD,_wood_density)_sapwood"))|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "WoodDensity",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "g cm-3")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_WoodDensity.rds")

# LDMC --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName") |>
  dplyr::filter(OriginalName == "Leaf_dry_mass_per_leaf_fresh_mass_(leaf_dry_matter_content,_LDMC)")|>
  dplyr::rename(Value = "OrigValueStr")|>
  dplyr::mutate(Trait = "LDMC",
                Value = as.numeric(Value),
                Units = "mg g-1", # Force units
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units (mg g-1)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_LDMC.rds")

# SLA --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf area per leaf dry mass (specific leaf area, SLA or 1/LMA) petiole, rhachis and midrib excluded")|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "SLA",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
#Check units (mm mg-1)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_SLA.rds")

# LeafArea --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf_area_(in_case_of_compound_leaves:leaf,_petiole_included)")|>
  dplyr::rename(Value = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Trait = "LeafArea",
                Value = as.numeric(Value),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
# Check units (mm2)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_LeafArea.rds")

# GrowthForm --------------------------------------------------
db_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName") |>
  dplyr::filter(OriginalName == "Plant_growth_form")|>
  dplyr::rename(Value = "OrigValueStr")|>
  dplyr::mutate(Trait = "GrowthForm",
                Units = as.character(NA),
                Reference = "Baez et al. (2022) FunAndes - A functional trait database of Andean plants. Scientific Data 9: 511",
                DOI = "10.1038/s41597-022-01626-6",
                Priority = 1) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")|>
  dplyr::mutate(
    Value = dplyr::case_when(Value == "T" ~ "Tree",
                                  Value == "S" ~ "Shrub",
                                  Value == "T/S" ~ "Tree/Shrub",
                                  Value == "H" ~ "Herb",
                                  Value == "E" ~ "Other",
                                  Value == "F" ~ "Other",
                                  Value == "L" ~ "Other",
                                  Value == "P" ~ "Other")
  )
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Baez_et_al_2022_GrowthForm.rds")
