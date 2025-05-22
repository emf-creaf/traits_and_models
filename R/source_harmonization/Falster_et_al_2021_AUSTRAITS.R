#
# Falster et al. (2021) - AUSTRAITS
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
aus_db <- readr::read_csv(paste0(DB_path,"Sources/Falster_et_al_2021_AusTraits/austraits-5.0.0/traits.csv"))
methods_db <- readr::read_csv(paste0(DB_path,"Sources/Falster_et_al_2021_AusTraits/austraits-5.0.0/methods.csv"))

traits <- sort(unique(aus_db$trait_name))

# LifeForm --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "life_form")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(Reference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "dataset_id") |>
  dplyr::filter(trait_name == "life_form")|>
  dplyr::rename(LifeForm = "value")|>
  dplyr::mutate(
    LifeForm = dplyr::case_when(
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Cha|Hemiphanerophyte)")) ~ "Chamaephyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hemic)")) ~ "Hemicryptophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
      stringr::str_detect(tolower(LifeForm), stringr::regex("(?i)(thero|tero)")) ~ "Therophyte",
      TRUE ~ LifeForm
    )
  ) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::select(-trait_name)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LifeForm.rds")


# # LeafShape --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_shape")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_shape")|>
#   dplyr::rename(LeafShape = "value")|>
#   dplyr::mutate(
#     LeafShape = dplyr::case_when(
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(cordate|cordate lanceolate|broad)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(deltoid|elliptical|elliptical lanceolate|lanceolate|oval)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(orbicular|oblanceolate|oblong|elliptical oblong|elliptical obovate|obovate|ovate lanceolate|ovate|obcordate)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(falcate|fishtail|hastate|orbicular|ovate bipinnate|palmate)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(palmatifid|pinnatifid|quinquelobate|runcinate|sagittate|septemlobate)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(rhomboid|spatulate|trilobate|tulip shaped)")) ~ "Broad",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(linear lanceolate|linear|lanceolate linear)")) ~ "Linear",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(terete|linear terete)")) ~ "Needle",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(triangular)")) ~ "Scale",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(spines)")) ~ "Spines",
#       stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(succulent)")) ~ "Succulent"
#     )
#   ) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafShape.rds")

# # LeafDuration --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_lifespan")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_lifespan")|>
#   dplyr::rename(LeafDuration = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafDuration = as.numeric(LeafDuration)/12, Units = "yr") |> # From mo to yr
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafDuration.rds")


# # LeafArea --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_area")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_area")|>
#   dplyr::rename(LeafArea = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafArea = as.numeric(LeafArea)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafArea.rds")


# LeafAngle --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_inclination_angle")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(Reference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_inclination_angle")|>
  dplyr::rename(LeafAngle = "value")|>
  dplyr::mutate(LeafAngle = as.numeric(LeafAngle),
                Units = "degrees") |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::select(-trait_name)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafAngle.rds")

# # SRL --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "root_specific_root_length")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "root_specific_root_length")|>
#   dplyr::rename(SRL = "value",
#                 Units = "unit")|>
#   dplyr::mutate(SRL = 100*as.numeric(SRL), Units = "cm/g") |> # From m/g to cm/g
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_SRL.rds")

# # Ks - Stem-specific conductivity --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "stem_specific_hydraulic_conductivity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "stem_specific_hydraulic_conductivity")|>
#   dplyr::rename(Ks = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Ks = as.numeric(Ks)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Ks.rds")
# 
# # StemEPS - Stem modulus of elasticity --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "xylem_modulus_of_elasticity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "xylem_modulus_of_elasticity")|>
#   dplyr::rename(StemEPS = "value",
#                 Units = "unit")|>
#   dplyr::mutate(StemEPS = as.numeric(StemEPS)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_StemEPS.rds")
# 
# # Wood density --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "wood_density")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "wood_density")|>
#   dplyr::rename(WoodDensity = "value",
#                 Units = "unit")|>
#   dplyr::mutate(WoodDensity = as.numeric(WoodDensity)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_WoodDensity.rds")
# 
# # Leaf density --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_density")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_density")|>
#   dplyr::rename(LeafDensity = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafDensity = as.numeric(LeafDensity)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafDensity.rds")

# # Leaf width --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_width")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_width")|>
#   dplyr::rename(LeafWidth = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafWidth = 0.1*as.numeric(LeafWidth), # From mm to cm
#                 Units = "cm") |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafWidth.rds")
# 
# 
# 
# # Seed mass --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "seed_dry_mass")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "seed_dry_mass")|>
#   dplyr::rename(SeedMass = "value",
#                 Units = "unit")|>
#   dplyr::mutate(SeedMass = as.numeric(SeedMass)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_SeedMass.rds")
# 

# # SLA/LMA --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_mass_per_area")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_mass_per_area")|>
#   dplyr::rename(SLA = "value",
#                 Units = "unit")|>
#   dplyr::mutate(SLA = 1000/as.numeric(SLA),
#                 Units = "mm2·mg-1") |> # From LMA to SLA (from g/m2 to mm2/mg)
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_SLA.rds")
# 
# 

# # Hact --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "plant_height")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "plant_height")|>
#   dplyr::rename(Hact = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Hact = as.numeric(Hact)*100,
#                 Units = "cm") |> # From m to cm
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Hact.rds")

# # StemEPS --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "stem_modulus_of_elasticity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "stem_modulus_of_elasticity")|>
#   dplyr::rename(StemEPS = "value",
#                 Units = "unit")|>
#   dplyr::mutate(StemEPS = as.numeric(StemEPS)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_StemEPS.rds")
# 
# # Al2As --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "huber_value")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "huber_value")|>
#   dplyr::rename(Al2As = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Al2As = 1.0/as.numeric(Al2As)) |> # From Hv mm2/mm-2 to Al2As m2/m-2
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Al2As.rds")
# # VCstem_P50 --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "water_potential_50percent_lost_conductivity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "water_potential_50percent_lost_conductivity")|>
#   dplyr::rename(VCstem_P50 = "value",
#                 Units = "unit")|>
#   dplyr::mutate(VCstem_P50 = as.numeric(VCstem_P50)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_VCstem_P50.rds")
# 
# # VCstem_P12 --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "water_potential_12percent_lost_conductivity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "water_potential_12percent_lost_conductivity")|>
#   dplyr::rename(VCstem_P12 = "value",
#                 Units = "unit")|>
#   dplyr::mutate(VCstem_P12 = as.numeric(VCstem_P12)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_VCstem_P12.rds")
# 
# 
# # VCstem_P88 --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "water_potential_88percent_lost_conductivity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "water_potential_88percent_lost_conductivity")|>
#   dplyr::rename(VCstem_P88 = "value",
#                 Units = "unit")|>
#   dplyr::mutate(VCstem_P88 = as.numeric(VCstem_P88)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_VCstem_P88.rds")
# 
# 
# # Nsapwood --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "stem_N_per_dry_mass")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "stem_N_per_dry_mass")|>
#   dplyr::rename(Nsapwood = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Nsapwood = as.numeric(Nsapwood)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Nsapwood.rds")
# 
# # LeafPI0 --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "osmotic_potential_at_full_turgor")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "osmotic_potential_at_full_turgor")|>
#   dplyr::rename(LeafPI0 = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafPI0 = as.numeric(LeafPI0)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafPI0.rds")
# 
# # LeafEPS --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "bulk_modulus_of_elasticity")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "bulk_modulus_of_elasticity")|>
#   dplyr::rename(LeafEPS = "value",
#                 Units = "unit")|>
#   dplyr::mutate(LeafEPS = as.numeric(LeafEPS)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_LeafEPS.rds")

# # Vmax --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_photosynthesis_Vcmax_per_area_25C")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_photosynthesis_Vcmax_per_area_25C")|>
#   dplyr::rename(Vmax = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Vmax = as.numeric(Vmax)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Vmax.rds")
# 
# # Jmax --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_photosynthesis_Jmax_per_area_25C")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(Reference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_photosynthesis_Jmax_per_area_25C")|>
#   dplyr::rename(Jmax = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Jmax = as.numeric(Jmax)) |> 
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)
# db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
# saveRDS(db_post, "Products/harmonized/Falster_et_al_2021_Jmax.rds")

