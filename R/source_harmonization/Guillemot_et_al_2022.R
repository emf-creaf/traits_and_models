#
# Guillemot et al. (2022)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Guillemot_et_al_2022/TAB_FINAL_GUILLEMOTetal.xlsx"), sheet = 2)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(species, "TLP", "P50", "LMA", "leaf_size", "Leaf_N", "Wood_density", "Seed_mass", "max_height") |>
  dplyr::rename(originalName = species,
                SLA = "LMA",
                Ptlp = "TLP",
                VCstem_P50 = "P50",
                LeafArea = "leaf_size",
                Nleaf = "Leaf_N",
                WoodDensity = "Wood_density",
                SeedMass = "Seed_mass",
                Hmax = "max_height") |>
  dplyr::mutate(SLA = 1000/SLA) |> # g·m-2 to m2·kg-1
  dplyr::mutate(Hmax = Hmax*100) |> # m to cm
  dplyr::arrange(originalName) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\_", " "))|>
  tibble::as_tibble()

db_var$Reference <- "Guillemot et al. 2022"
db_var$Priority <- 2

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Guillemot_et_al_2022.rds")
