#
# Compilation FineFuelRatio 
#
DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")


# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_FineFuelRatio/FineFuelRatio.xlsx"), sheet =1)

# r635 --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, r635, Source) |>
  dplyr::rename(originalName = Species,
                Reference = Source) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_FineFuelRatio.rds")
