#
# Kunert & Tomaskova (2020)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Kunert_Tomaskova_2020/Kunert_TLP_DB2020.xlsx"), sheet = 1)
db_ref <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Kunert_Tomaskova_2020/Kunert_TLP_DB2020.xlsx"), sheet = 2)
db <- db |>
  dplyr::left_join(db_ref)
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species.name, TLP_Mpa) |>
  dplyr::rename(originalName = "Species.name",
                Ptlp = "TLP_Mpa") |>
  dplyr::mutate(Ptlp = as.numeric(Ptlp),
                Reference = "Kunert N, Tomaskova I (2020) Leaf turgor loss point at full hydration for 41 native and introduced tree and shrub species from Central Europe. J Plant Ecol
13:754–756.",
                DOI = "10.1093/jpe/rtaa059",
                Priority = 1)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Kunert_Tomaskova_2020.rds")
