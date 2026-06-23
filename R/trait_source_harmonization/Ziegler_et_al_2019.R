#
# Ziegler et al. (2019)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Ziegler_et_al_2019/Ziegler_et_al_2019.xlsx")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species_binomial, "Height max (m)",
                "P50stem", "slope stem",
                "gmin (mmol m-2 s-1)", "TLP (MPa)") |>
  dplyr::rename(originalName = Species_binomial,
                Hmax = "Height max (m)",
                VCstem_P50 = "P50stem",
                VCstem_slope = "slope stem",
                Ptlp = "TLP (MPa)",
                Gswmin = "gmin (mmol m-2 s-1)") |>
  dplyr::mutate(Hmax = as.numeric(Hmax)*100, # From m to cm
                Gswmin = as.numeric(Gswmin)/1000)|>
  dplyr::mutate(Reference = "Ziegler et al. 2019. Large hydraulic safety margins protect Neotropical canopy rainforest tree species against hydraulic failure during drought. Annals of Forest Science 76: 115",
                DOI = "https://doi.org/10.1007/s13595-019-0905-0",
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
saveRDS(db_post, "data/harmonized_trait_sources/Ziegler_et_al_2019.rds")
