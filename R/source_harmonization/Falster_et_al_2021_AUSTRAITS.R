#
# Falster et al. (2021) - AUSTRAITS
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
aus_db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Falster_et_al_2021_AusTraits/austraits-5.0.0/traits.csv"))
methods_db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Falster_et_al_2021_AusTraits/austraits-5.0.0/methods.csv"))

traits <- sort(unique(aus_db$trait_name))


falster_ref <- "Falster et al. (2021) AusTraits, a curated plant trait database for the Australian flora. Scientific Data 8:254"
falster_doi <- "10.1038/s41597-021-01006-6"
# 
# # LifeForm --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "life_form")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(OriginalReference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "dataset_id") |>
#   dplyr::filter(trait_name == "life_form")|>
#   dplyr::rename(Value = "value")|>
#   dplyr::mutate(
#     Trait = "LifeForm",
#     Value = dplyr::case_when(
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Cha|Hemiphanerophyte)")) ~ "Chamaephyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Crypt|geo)")) ~ "Cryptophyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(Epi|liana)")) ~ "Epiphyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(hemic)")) ~ "Hemicryptophyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(hydro|helo)")) ~ "Hydrophyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(phaner|shrub|tree)")) ~ "Phanerophyte",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(thero|tero)")) ~ "Therophyte",
#       TRUE ~ Value
#     ),
#     Units = as.character(NA)
#   ) |>
#   dplyr::relocate(Trait, .before = Value) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id) |>
#   dplyr::mutate(Reference = falster_ref,
#                 DOI = falster_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LifeForm.rds")
# 
# 
# # LeafShape --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_shape")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(OriginalReference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_shape")|>
#   dplyr::rename(Value = "value")|>
#   dplyr::mutate(
#     Trait = "LeafShape",
#     Value = dplyr::case_when(
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(cordate|cordate lanceolate|broad)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(deltoid|elliptical|elliptical lanceolate|lanceolate|oval)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(orbicular|oblanceolate|oblong|elliptical oblong|elliptical obovate|obovate|ovate lanceolate|ovate|obcordate)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(falcate|fishtail|hastate|orbicular|ovate bipinnate|palmate)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(palmatifid|pinnatifid|quinquelobate|runcinate|sagittate|septemlobate)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(rhomboid|spatulate|trilobate|tulip shaped)")) ~ "Broad",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(linear lanceolate|linear|lanceolate linear)")) ~ "Linear",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(terete|linear terete)")) ~ "Needle",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(triangular)")) ~ "Scale",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(spines)")) ~ "Spines",
#       stringr::str_detect(tolower(Value), stringr::regex("(?i)(succulent)")) ~ "Succulent"
#     ),
#     Units = as.character(NA)
#   ) |>
#   dplyr::relocate(Trait, .before = Value) |>
#   dplyr::filter(!is.na(Value)) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)|>
#   dplyr::mutate(Reference = falster_ref,
#                 DOI = falster_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafShape.rds")
# 
# # LeafDuration --------------------------------------------------
# db_methods <- methods_db |>
#   dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
#   dplyr::filter(trait_name == "leaf_lifespan")|>
#   dplyr::select(-trait_name) |>
#   dplyr::rename(OriginalReference = "source_primary_citation")
# db_var <- aus_db |>
#   dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
#   dplyr::filter(trait_name == "leaf_lifespan")|>
#   dplyr::rename(Value = "value",
#                 Units = "unit")|>
#   dplyr::mutate(Trait = "LeafDuration",
#                 Value = as.numeric(Value)) |> # From mo to yr
#   dplyr::relocate(Trait, .before = Value) |>
#   dplyr::rename(originalName = "taxon_name")|>
#   dplyr::select(-trait_name)|>
#   dplyr::arrange(originalName) |>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
#   dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
#   dplyr::left_join(db_methods, by = "dataset_id")|>
#   dplyr::select(-dataset_id)|>
#   dplyr::mutate(Reference = falster_ref,
#                 DOI = falster_doi,
#                 Priority = 1) |>
#   dplyr::relocate(OriginalReference, .after = DOI)
# # Check units (year)
# table(db_var$Units)
# db_var <- db_var |>
#   dplyr::mutate(Value = Value/12,
#                 Units = "year")
# db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
#   dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
# traits4models::check_harmonized_trait(db_post)
# saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafDuration.rds")
# 

# LeafArea --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_area")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation") |>
  unique()
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_area")|>
  dplyr::rename(Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "LeafArea",
                Value = as.numeric(Value)) |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::select(-trait_name)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mm2)
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafArea.rds")


# LeafAngle --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_inclination_angle")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_inclination_angle")|>
  dplyr::rename(Value = "value")|>
  dplyr::mutate(Trait = "LeafAngle",
                Value = as.numeric(Value),
                Units = "degree") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::select(-trait_name)|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units
table(db_var$Units)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafAngle.rds")

# SRL --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "root_specific_root_length")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "root_specific_root_length")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait  = "SRL",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)

# Check units (cm g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = 100*Value,
                Units = "cm g-1") # From m/g to cm/g
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_SRL.rds")

# Ks - Stem-specific conductivity --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "stem_specific_hydraulic_conductivity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "stem_specific_hydraulic_conductivity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Ks",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (kg m-1 MPa-1 s-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "kg m-1 MPa-1 s-1")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Ks.rds")

# StemEPS - Stem modulus of elasticity --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "xylem_modulus_of_elasticity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "xylem_modulus_of_elasticity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "StemEPS",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_StemEPS.rds")

# Wood density --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "wood_density")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation") |>
  unique()
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "wood_density")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "WoodDensity",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mg mm-3)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg mm-3")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_WoodDensity.rds")

# Leaf density --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_density")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_density")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "LeafDensity",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mg mm-3)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg mm-3")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafDensity.rds")

# Leaf width --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_width")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_width")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "LeafWidth",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (cm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*0.1,
                Units = "cm")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafWidth.rds")


# Seed mass --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "seed_dry_mass")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "seed_dry_mass")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "SeedMass",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mg)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_SeedMass.rds")

# SLA/LMA --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_mass_per_area")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")|>
  unique()
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_mass_per_area")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "SLA",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mm mg-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = 1000/Value,
                Units = "mm2 mg-1") # From LMA to SLA (from g/m2 to mm2/mg)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_SLA.rds")

# Hact --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "plant_height")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "plant_height")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Hact",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (cm)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value*100,
                Units = "cm") # From m to cm
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Hact.rds")


# Al2As --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "huber_value")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")|>
  unique()
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "huber_value")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Al2As",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (m2 m-2)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = 1/Value,
                Units = "m2 m-2") # From Hv mm2/mm-2 to Al2As m2/m-2
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Al2As.rds")

# VCstem_P50 --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "water_potential_50percent_lost_conductivity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "water_potential_50percent_lost_conductivity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "VCstem_P50",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_VCstem_P50.rds")

# VCstem_P12 --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "water_potential_12percent_lost_conductivity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "water_potential_12percent_lost_conductivity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "VCstem_P12",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_VCstem_P12.rds")


# VCstem_P88 --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "water_potential_88percent_lost_conductivity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "water_potential_88percent_lost_conductivity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "VCstem_P88",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_VCstem_P88.rds")


# Nsapwood --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "stem_N_per_dry_mass")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "stem_N_per_dry_mass")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Nsapwood",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (mg g-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "mg g-1")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Nsapwood.rds")

# LeafPI0 --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "osmotic_potential_at_full_turgor")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "osmotic_potential_at_full_turgor")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "LeafPI0",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafPI0.rds")

# LeafEPS --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "bulk_modulus_of_elasticity")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "bulk_modulus_of_elasticity")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "LeafEPS",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (MPa)
table(db_var$Units)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_LeafEPS.rds")

# Vmax --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_photosynthesis_Vcmax_per_area_25C")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_photosynthesis_Vcmax_per_area_25C")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Vmax",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (umol m-2 s-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "umol m-2 s-1")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Vmax.rds")

# Jmax --------------------------------------------------
db_methods <- methods_db |>
  dplyr::select("dataset_id", "trait_name", "source_primary_citation") |>
  dplyr::filter(trait_name == "leaf_photosynthesis_Jmax_per_area_25C")|>
  dplyr::select(-trait_name) |>
  dplyr::rename(OriginalReference = "source_primary_citation")
db_var <- aus_db |>
  dplyr::select("taxon_name", "trait_name", "value", "unit", "dataset_id") |>
  dplyr::filter(trait_name == "leaf_photosynthesis_Jmax_per_area_25C")|>
  dplyr::rename(Trait = "trait_name",
                Value = "value",
                Units = "unit")|>
  dplyr::mutate(Trait = "Jmax",
                Value = as.numeric(Value)) |>
  dplyr::rename(originalName = "taxon_name")|>
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ subsp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::left_join(db_methods, by = "dataset_id")|>
  dplyr::select(-dataset_id)|>
  dplyr::mutate(Reference = falster_ref,
                DOI = falster_doi,
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI)
# Check units (umol m-2 s-1)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "umol m-2 s-1")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Falster_et_al_2021_Jmax.rds")
