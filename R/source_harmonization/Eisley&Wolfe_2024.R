#
# Eisley & Wolfe 2024
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Eisley&Wolfe_2024/Eisley&Wolfe_2024.xlsx"), sheet = 1)


# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(binomial, TLP) |>
  dplyr::rename(originalName = "binomial",
                Ptlp = "TLP") |>
  dplyr::mutate(Ptlp = as.numeric(Ptlp),
                Reference = "Eisley AM & Wolfe BT (2024) Leaf turgor loss point varies among tree species, habitats, and seasons in a bottomland hardwood forest. Trees 38:263–272",
                Priority = 1) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Eisley&Wolfe_2024.rds")
