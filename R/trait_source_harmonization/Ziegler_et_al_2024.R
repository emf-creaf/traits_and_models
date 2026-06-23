#
# Ziegler et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Ziegler_et_al_2024/Ziegler_et_al_2024.xlsx")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species_binomial, "P50leaf", "slope leaf",
                "P50stem", "slope stem",
                "gmin (mmol m-2 s-1)", "TLP (MPa)",
                "Leaf to sapwood area ratio (m2 m-2)", "LMA (g m-2)") |>
  dplyr::rename(originalName = Species_binomial,
                VCleaf_P50 = "P50leaf",
                VCleaf_slope = "slope leaf",
                VCstem_P50 = "P50stem",
                VCstem_slope = "slope stem",
                Ptlp = "TLP (MPa)",
                Al2As = "Leaf to sapwood area ratio (m2 m-2)",
                SLA = "LMA (g m-2)",
                Gswmin = "gmin (mmol m-2 s-1)") |>
  dplyr::mutate(SLA = 1000/as.numeric(SLA), # From m to cm
                Gswmin = as.numeric(Gswmin)/1000)|>
  dplyr::mutate(Reference = "Ziegler et al. 2024. Residual water losses mediate the trade-off between growth and drought survival across saplings of 12 tropical rainforest tree species with contrasting hydraulic strategies. Journal of Experimental Botany",
                DOI = "https://doi.org/10.1093/jxb/erae159",
                Priority = 1) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Ziegler_et_al_2024.rds")
