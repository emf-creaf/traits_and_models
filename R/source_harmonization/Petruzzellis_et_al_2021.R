#
# Petruzzelis et al 2021 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")


# Read database -----------------------------------------------------------
db <- read.csv(paste0(DB_path,"data-raw/raw_trait_data/Petruzzellis_et_al_2021/Petruzzellis_2021.csv"), sep=";", dec=".")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "TLP..MPa.", "LDMC..mg.g.1.", "WD..g.cm.3.") |>
  dplyr::rename(originalName = Species,
                Ptlp = "TLP..MPa.",
                LDMC = "LDMC..mg.g.1.",
                WoodDensity = "WD..g.cm.3.") |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Petruzzellis et al. (2021) Turgor loss point and vulnerability to xylem embolism predict species-specific risk of drought-induced decline of urban trees. Plant biology 24, 1198-1207",
                DOI = "10.1111/plb.13355",
                Priority = 1) |>
  tibble::as_tibble()

traits4models::check_harmonized_trait(db_var)
# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))


# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Petruzzellis_et_al_2021.rds")
