#
# Compilation Construction costs 
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/00_compilation_ConstructionCosts/ConstructionCosts.xlsx"), sheet =1)
biblio <- readxl::read_excel(paste0(DB_path,"Sources/00_compilation_ConstructionCosts/ConstructionCosts.xlsx"), sheet =2)

# CCleaf --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "leaf_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(CCleaf = "Value",
                originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/00_compilation_CCleaf.rds")

# CCsapwood --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "sapwood_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(CCsapwood = "Value",
                originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/00_compilation_CCsapwood.rds")

# CCfineroot --------------------------------------------------
db_var <- db |>
  dplyr::filter(Trait == "fineroot_construction_costs") |>
  dplyr::select(Species, Value, Units, Ref_code) |>
  dplyr::rename(CCfineroot = "Value",
                originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/00_compilation_CCfineroot.rds")
