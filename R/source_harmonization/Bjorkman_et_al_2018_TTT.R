#
# Bjorkman et al. (2018) - TTT
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
ttt_db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Bjorkman_et_al_2018_TTT/TTT_cleaned_dataset_v1.csv"))

# LDMC --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf dry mass per leaf fresh mass (Leaf dry matter content, LDMC)")|>
  dplyr::mutate(Trait = "LDMC",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
# Check units (mg g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*1000,
                Units = "mg g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_LDMC.rds")

# SeedMass --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Seed dry mass")|>
  dplyr::mutate(Trait = "SeedMass",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
# Check units (mg)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_SeedMass.rds")

# RootingDepth --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Rooting depth")|>
  dplyr::mutate(Trait = "Z95",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
# Check units (mm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*10,
                Units = "mm")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_Z95.rds")

# Hact --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Plant height, vegetative")|>
  dplyr::mutate(Trait = "Hact",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
# Check units (cm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*100,
                Units = "cm")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_Hact.rds")

# Nleaf --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf nitrogen (N) content per leaf dry mass")|>
  dplyr::mutate(Trait = "Nleaf",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
#Check units (mg g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_Nleaf.rds")

# LeafArea --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf area")|>
  dplyr::mutate(Trait = "LeafArea",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
#Check units (mm2)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_LeafArea.rds")

# SLA --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf area per leaf dry mass (specific leaf area, SLA)")|>
  dplyr::mutate(Trait = "SLA",
                Value = as.numeric(Value)) |>
  dplyr::filter(!is.na(Value), ErrorRisk < 3) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-ErrorRisk)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Bjorkman et al. (2018) Tundra Trait Team: A database of plant traits spanning the tundra biome. Global Ecol. Biog. 27, 1402-1411",
                DOI = "10.1111/geb.12821",
                Priority = 3)
#Check units (mm2 mg-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mm2 mg-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Bjorkman_et_al_2018_SLA.rds")

