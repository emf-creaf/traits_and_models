#
# Compilation Flammability 
#
DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_Flammability/Flammability.xlsx"), sheet =1)
db_ref <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_Flammability/Flammability.xlsx"), sheet =2)

# HeatContent --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "high_calorific_value") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(HeatContent = "Value",
                originalName = Species) |>
  dplyr::left_join(db_ref, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Flammability_HeatContent.rds")

# SAV --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "surface_area_volume") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(SAV = "Value",
                originalName = Species) |>
  dplyr::left_join(db_ref, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Flammability_SAV.rds")

