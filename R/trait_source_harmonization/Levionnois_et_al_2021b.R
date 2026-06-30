#
# Levionnois et al. (2021b)
#

harmonize_Levionnois_et_al_2021b <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Levionnois_et_al_2021b/Levionnois_et_al_2021b.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::select(Species_binomial, "Height max (m)", "Leaf to sapwood area ratio (m2 m-2)",
                  "gmin (mmol m-2 s-1)", "gbark (mmol m-2 s-1)") |>
    dplyr::rename(originalName = Species_binomial,
                  Hmax = "Height max (m)",
                  Al2As = "Leaf to sapwood area ratio (m2 m-2)",
                  Gswmin = "gmin (mmol m-2 s-1)",
                  Gbark = "gbark (mmol m-2 s-1)") |>
    dplyr::mutate(Hmax = as.numeric(Hmax)*100, # From m to cm
                  Gswmin = as.numeric(Gswmin)/1000,
                  Gbark = as.numeric(Gbark)/1000)|>
    dplyr::mutate(Reference = "Levionnois et al. (2021b) Is vulnerability segmentation at the leaf-stem transition a drought resistance mechanism? A theoretical test with a trait-based model for Neotropical canopy tree species. Annals of Forest Science 78: 87",
                  DOI = "https://doi.org/10.1007/s13595-021-01094-9",
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
  saveRDS(db_post, "data/harmonized_trait_sources/Levionnois_et_al_2021b.rds")
}

