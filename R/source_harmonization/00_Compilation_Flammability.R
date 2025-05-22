#
# Compilation Flammability 
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/00_compilation_Flammability/Flammability.xlsx"), sheet =1)
biblio <- readxl::read_excel(paste0(DB_path,"Sources/00_compilation_Flammability/Flammability.xlsx"), sheet =2)

# HeatContent --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "high_calorific_value") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(HeatContent = "Value",
                originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/00_compilation_Flammability_HeatContent.rds")

# SAV --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "surface_area_volume") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(SAV = "Value",
                originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/00_compilation_Flammability_SAV.rds")

