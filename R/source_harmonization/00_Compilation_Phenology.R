#
# Compilation Phenology 
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db_budburst <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =1)
db_senescence <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =2)
db_biblio <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/00_compilation_LeafPhenology/LeafPhenology.xlsx"), sheet =3)

# Budburst --------------------------------------------------
db_var <- db_budburst |>
  dplyr::filter(Accepted=="Y")|>
  dplyr::rename(originalName = Species) |>
  dplyr::left_join(db_biblio, by="Ref_code") |>
  dplyr::select(-Ref_code, -Accepted, -N) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Phenology_Budburst.rds")

# Senescence --------------------------------------------------
db_var <- db_senescence |>
  dplyr::filter(Accepted=="Y")|>
  dplyr::mutate(xsen = as.integer(xsen),
                ysen = as.integer(ysen)) |>
  dplyr::rename(originalName = Species) |>
  dplyr::left_join(db_biblio, by="Ref_code") |>
  dplyr::select(-Ref_code, -Accepted, -N) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(DOI = as.character(NA),
                Priority = 1) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/00_compilation_Phenology_Senescence.rds")
