#
# Petruzzelis et al 2021 -----
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")
# 
# DB_path <- "/Users/nicolasmartin/Documents/Developpement/"
# WFO_path <- "/Users/nicolasmartin/Documents/Developpement/"

# Read database -----------------------------------------------------------
db <- read.csv(paste0(DB_path,"Sources/Petruzzellis_et_al_2021/Petruzzellis_2021.csv"), sep=";", dec=".")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "TLP..MPa.", "LDMC..mg.g.1.", "WD..g.cm.3.") |>
  dplyr::rename(originalName = Species,
                Ptlp = "TLP..MPa.",
                LDMC = "LDMC..mg.g.1.",
                WoodDensity = "WD..g.cm.3.") |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference <- "Petruzzellis et al. 2021"
db_var$Priority <- 1

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Petruzzellis_et_al_2021.rds")
