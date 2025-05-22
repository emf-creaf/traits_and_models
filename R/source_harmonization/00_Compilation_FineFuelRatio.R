#
# Compilation FineFuelRatio 
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_FineFuelRatio/FineFuelRatio.xlsx"), sheet =1)

# r635 --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, r635) |>
  dplyr::rename(originalName = Species) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_FineFuelRatio.rds")
