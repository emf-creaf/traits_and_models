#
# Bjorkman et al. (2018) - TTT
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
ttt_db <- readr::read_csv(paste0(DB_path,"Sources/Bjorkman_et_al_2018_TTT/TTT_cleaned_dataset_v1.csv"))

# LDMC --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf dry mass per leaf fresh mass (Leaf dry matter content, LDMC)")|>
  dplyr::rename(LDMC = "Value")|>
  dplyr::mutate(LDMC = as.numeric(LDMC)) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022",
                Priority = 3)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_LDMC.rds")

# SeedMass --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Seed dry mass")|>
  dplyr::rename(SeedMass = "Value")|>
  dplyr::mutate(SeedMass = as.numeric(SeedMass)) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022",
                Priority = 3)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_SeedMass.rds")

# RootingDepth --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Rooting depth")|>
  dplyr::rename(Z95 = "Value")|>
  dplyr::mutate(Z95 = 10*as.numeric(Z95), #From cm to mm
                Units = "mm") |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022")
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_Z95.rds")

# Hact --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Plant height, vegetative")|>
  dplyr::rename(Hact = "Value")|>
  dplyr::mutate(Hact = 100*as.numeric(Hact), #From m to cm
                Units = "cm") |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022")
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_Hact.rds")

# Nleaf --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf nitrogen (N) content per leaf dry mass")|>
  dplyr::rename(Nleaf = "Value")|>
  dplyr::mutate(Nleaf = as.numeric(Nleaf)) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022")
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_Nleaf.rds")

# LeafArea --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf area")|>
  dplyr::rename(LeafArea = "Value")|>
  dplyr::mutate(LeafArea = as.numeric(LeafArea)) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022")
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_LeafArea.rds")

# SLA --------------------------------------------------
db_var <- ttt_db |>
  dplyr::select("AccSpeciesName", "Trait", "Value", "Units", "ErrorRisk") |>
  dplyr::filter(Trait == "Leaf area per leaf dry mass (specific leaf area, SLA)")|>
  dplyr::rename(SLA = "Value")|>
  dplyr::mutate(SLA = as.numeric(SLA)) |>
  dplyr::rename(originalName = "AccSpeciesName")|>
  dplyr::select(-Trait)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Thomas et al. 2022")
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Bjorkman_et_al_2018_SLA.rds")

