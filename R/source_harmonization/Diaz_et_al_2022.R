#
# Diaz et al 2022 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path,"data-raw/raw_trait_data/Diaz_et_al_2022/Species_mean_traits.xlsx"), sheet = 1)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species.name.standardized.against.TPL, "Leaf.area.(mm2)", "Nmass.(mg/g)", "LMA.(g/m2)", "Plant.height.(m)", "Diaspore.mass.(mg)", "LDMC.(g/g)", "SSD.combined.(mg/mm3)") |>
  dplyr::rename(originalName = Species.name.standardized.against.TPL,
                LeafArea = "Leaf.area.(mm2)",
                Nleaf = "Nmass.(mg/g)",
                LMA = "LMA.(g/m2)",
                Hact = "Plant.height.(m)",
                SeedMass = "Diaspore.mass.(mg)",
                LDMC = "LDMC.(g/g)",
                WoodDensity = "SSD.combined.(mg/mm3)",
                ) |>
  dplyr::mutate(SLA = 1000/LMA, # m2/kg
                Hact = 100*Hact, # cm
                LDMC = LDMC*1000, # mg g-1
                originalName = stringr::str_replace(originalName, " sp\\.", ""),
                Reference = "Díaz et al. (2022). The global spectrum of plant form and function: enhanced  species-level trait dataset. Scientific Data 9:755.",
                DOI = "10.1038/s41597-022-01774-9",
                Priority = 2)|>
  dplyr::select(-LMA)|>
  tibble::as_tibble()


# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Diaz_et_al_2022.rds")
