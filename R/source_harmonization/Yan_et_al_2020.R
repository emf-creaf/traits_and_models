#
# Yan et al. (2020)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_xlsx(paste0(DB_path,"data-raw/raw_trait_data/Yan_et_al_2020/rsbl20200456_si_002.xlsx")) 

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, Kleaf, P50leaf, Source) |>
  dplyr::rename(originalName = Species,
                kleaf = Kleaf,
                VCleaf_P50 = P50leaf,
                OriginalReference = Source) |>
  # dplyr::filter(!is.na(originalName)) |>
  # dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  # dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::arrange(originalName)  |>
  dplyr::mutate(Reference = "Yan et al. (2020). Leaf hydraulic safety margin and safety efficiency trade-off across angiosperm woody species. Biology Letters 16",
                DOI = "10.1098/rsbl.2020.0456", 
                Priority = 3) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()

db_var$Priority[db_var$OriginalReference=="This study"] <- 1
db_var$OriginalReference[db_var$OriginalReference=="This study"] <- NA

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Yan_et_al_2020.rds")
