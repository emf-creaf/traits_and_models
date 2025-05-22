#
# Compilation Phenology 
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
db_budburst <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =1)
db_senescence <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =2)
biblio <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =3)

# Budburst --------------------------------------------------
db_var <- db_budburst |>
  dplyr::filter(Accepted=="Y")|>
  dplyr::rename(originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code, -Accepted, -N) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Phenology_Budburst.rds")

# Senescence --------------------------------------------------
db_var <- db_senescence |>
  dplyr::filter(Accepted=="Y")|>
  dplyr::rename(originalName = Species) |>
  dplyr::left_join(biblio, by="Ref_code") |>
  dplyr::select(-Ref_code, -Accepted, -N) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Phenology_Senescence.rds")
