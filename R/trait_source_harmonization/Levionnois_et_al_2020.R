#
# Levionnois et al. (2020)
#

harmonize_Levionnois_et_al_2020 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Levionnois_et_al_2020/Levionnois_et_al_2020.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::select(Species_binomial, "Height max (m)", "P50leaf", "slope leaf") |>
    dplyr::rename(originalName = Species_binomial,
                  Hmax = "Height max (m)",
                  VCleaf_P50 = "P50leaf", 
                  VCleaf_slope = "slope leaf") |>
    dplyr::mutate(Hmax = as.numeric(Hmax)*100, # From m to cm 
                  VCleaf_P50 = as.numeric(VCleaf_P50), 
                  VCleaf_slope = as.numeric(VCleaf_slope))|>
    dplyr::mutate(Reference = "Levionnois et al. (2020) Vulnerability and hydraulic segmentations at the stem–leaf  transition: coordination across Neotropical trees. New Phytologist 228: 512-524",
                  DOI = "https://doi.org/10.1111/nph.16723",
                  Priority = 1) |>
    dplyr::arrange(originalName) |>
    tibble::as_tibble()
  traits4models::check_harmonized_trait(db_var)
  
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Levionnois_et_al_2020.rds")
  
}
