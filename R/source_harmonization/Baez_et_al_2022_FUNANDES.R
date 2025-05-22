#
# Baez et al. (2022) - FUNANDES
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
fun_db <- readr::read_csv(paste0(DB_path,"Sources/Baez_et_al_2022_FUNANDES/fundb_TRY_open_20220428.csv"))

# Stem-specific conductivity --------------------------------------------------
ks_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Wood_(sapwood)_specific_conductivity_(stem_specific_conductivity)")|>
  dplyr::rename(Ks = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Ks = as.numeric(Ks),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(ks_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_Ks.rds")

# Bark thickness --------------------------------------------------
bt_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Bark_thickness")|>
  dplyr::rename(BarkThickness = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(BarkThickness = as.numeric(BarkThickness),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(bt_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_BarkThickness.rds")

# Nleaf --------------------------------------------------
nl_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf_nitrogen_(N)_content_per_leaf_dry_mass")|>
  dplyr::rename(Nleaf = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(Nleaf = as.numeric(Nleaf),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(nl_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_Nleaf.rds")

# WoodDensity --------------------------------------------------
wd_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName %in% c("Stem_dry_mass_per_stem_fresh_volume_(stem_specific_density,_SSD,_wood_density)_branch", 
                                    "Stem_dry_mass_per_stem_fresh_volume_(stem_specific_density,_SSD,_wood_density)_sapwood"))|>
  dplyr::rename(WoodDensity = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(WoodDensity = as.numeric(WoodDensity),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(wd_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_WoodDensity.rds")

# LDMC --------------------------------------------------
ldmc_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName") |>
  dplyr::filter(OriginalName == "Leaf_dry_mass_per_leaf_fresh_mass_(leaf_dry_matter_content,_LDMC)")|>
  dplyr::rename(LDMC = "OrigValueStr")|>
  dplyr::mutate(LDMC = as.numeric(LDMC),
                OrigUnitStr = "mg/g",
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(ldmc_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_LDMC.rds")

# SLA --------------------------------------------------
sla_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf area per leaf dry mass (specific leaf area, SLA or 1/LMA) petiole, rhachis and midrib excluded")|>
  dplyr::rename(SLA = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(SLA = as.numeric(SLA),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(sla_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_SLA.rds")

# LeafArea --------------------------------------------------
la_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName", "OrigUnitStr") |>
  dplyr::filter(OriginalName == "Leaf_area_(in_case_of_compound_leaves:leaf,_petiole_included)")|>
  dplyr::rename(LeafArea = "OrigValueStr",
                Units = "OrigUnitStr")|>
  dplyr::mutate(LeafArea = as.numeric(LeafArea),
                Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")
db_post <- harmonize_taxonomy_WFO(la_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_LeafArea.rds")

# GrowthForm --------------------------------------------------
gf_var <- fun_db |>
  dplyr::select("SpeciesName", "OrigValueStr", "OriginalName") |>
  dplyr::filter(OriginalName == "Plant_growth_form")|>
  dplyr::rename(GrowthForm = "OrigValueStr")|>
  dplyr::mutate(Reference = "Baez et al. 2022") |>
  dplyr::select(-OriginalName) |>
  dplyr::rename(originalName = "SpeciesName")|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " indet", ""))|>
  dplyr::filter(originalName != "indet")|>
  dplyr::mutate(
    GrowthForm = dplyr::case_when(GrowthForm == "T" ~ "Tree",
                                  GrowthForm == "S" ~ "Shrub",
                                  GrowthForm == "T/S" ~ "Tree/Shrub",
                                  GrowthForm == "H" ~ "Herb",
                                  GrowthForm == "E" ~ "Other",
                                  GrowthForm == "F" ~ "Other",
                                  GrowthForm == "L" ~ "Other",
                                  GrowthForm == "P" ~ "Other")
  )
db_post <- harmonize_taxonomy_WFO(gf_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Baez_et_al_2022_GrowthForm.rds")
