#
# Vilagrosa et al. (2014)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path, "Sources/Villagrosa_et_al_2014/villagrosa2014.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::rename(originalName = Species,
                Ptlp = "TLP") |>
  dplyr::mutate(Ptlp = as.numeric(Ptlp),
                Reference = "Vilagrosa et al. (2014). Physiological differences explain the co-existence of different
regeneration strategies in Mediterranean ecosystems. New Phytologist 201: 1277–1288.",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Vilagrosa_et_al_2014.rds")
