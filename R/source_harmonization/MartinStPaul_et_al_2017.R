#
# Martin-StPaul et al. (2017)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/MartinStPaul_et_al_2017/DataBase.xlsx"), sheet = "ALL")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "Ptlp", "P50", "P12", "Slope", "Pgs90") |>
  dplyr::rename(originalName = Species,
                Ptlp = "Ptlp",
                VCstem_P50 = "P50",
                VCstem_P12 = "P12",
                VCstem_slope = "Slope",
                Gs_P90 = "Pgs90") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference <- "Martin-StPaul et al. 2017"
db_var$DOI <- "10.1111/ele.12851"
db_var$Priority <- 1

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing ----------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/MartinStPaul_et_al_2017.rds")
