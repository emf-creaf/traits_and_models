#
# Compilation Construction costs 
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_ConstructionCosts/ConstructionCosts.xlsx"), sheet =1)
db_ref <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_ConstructionCosts/ConstructionCosts.xlsx"), sheet =2)

# CCleaf --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "leaf_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(originalName = Species) |>
  dplyr::mutate(Trait = "CCleaf") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::left_join(db_ref, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
# Check units
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "g g-1")
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_CCleaf.rds")

# CCsapwood --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "sapwood_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(originalName = Species) |>
  dplyr::mutate(Trait = "CCsapwood") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::left_join(db_ref, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
# Check units
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "g g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_CCsapwood.rds")

# CCfineroot --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "fineroot_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(originalName = Species) |>
  dplyr::mutate(Trait = "CCfineroot") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::left_join(db_ref, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
# Check units
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Units = "g g-1")
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_CCfineroot.rds")
