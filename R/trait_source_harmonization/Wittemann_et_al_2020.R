#
# Wittemann et al. (2020)
#

harmonize_Wittemann_et_al_2020 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel("data-raw/raw_trait_data/Wittemann_et_al_2023/Wittemann_et_al_2023.xlsx")
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::select(Species_binomial,
                  "P50leaf", "slope leaf",
                  "P50stem", "slope stem",
                  "gmin (mmol m-2 s-1)", "gbark (mmol m-2 s-1)",
                  "TLP (MPa)") |>
    dplyr::rename(originalName = Species_binomial,
                  VCleaf_P50 = "P50leaf",
                  VCleaf_slope = "slope leaf",
                  VCstem_P50 = "P50stem",
                  VCstem_slope = "slope stem",
                  Ptlp = "TLP (MPa)",
                  Gswmin = "gmin (mmol m-2 s-1)",
                  Gbark = "gbark (mmol m-2 s-1)") |>
    dplyr::mutate(Gswmin = as.numeric(Gswmin)/1000,
                  Gbark = as.numeric(Gbark)/1000)|>
    dplyr::mutate(Reference = "Wittemann et al. 2020. Plasticity and implications of water-use traits in contrasting tropical tree species under climate change. Physiologia Plantarum 176:e14326",
                  DOI = "https://doi.org/10.1111/ppl.14326",
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
  saveRDS(db_post, "data/harmonized_trait_sources/Witteman_et_al_2020.rds")
}

