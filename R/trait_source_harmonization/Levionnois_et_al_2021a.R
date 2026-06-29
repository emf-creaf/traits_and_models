#
# Levionnois et al. (2021a)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Levionnois_et_al_2021a/Levionnois_et_al_2021a.xlsx")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species_binomial, "Wood density") |>
  dplyr::rename(originalName = Species_binomial,
                Value = "Wood density") |>
  dplyr::mutate(Trait = "WoodDensity",
                Units = "g cm-3")|>
  dplyr::mutate(Reference = "Levionnois et al. (2021a) Linking drought-induced xylem embolism resistance to wood anatomical traits in Neotropical trees. New Phytologist 299: 1453-1466",
                DOI = "https://doi.org/10.1111/nph.16942",
                Priority = 1,
                Level = "population") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Levionnois_et_al_2021a.rds")
