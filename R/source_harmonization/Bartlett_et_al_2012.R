#
# Bartlett et al. (2012)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
fn_bartlett <- file.path(DB_path, "data-raw/raw_trait_data/Bartlett_et_al_2012/Bartlett_2012_ELE_data.xlsx")
db <- openxlsx::read.xlsx(fn_bartlett, rowNames = FALSE) 

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "πo.(MPa)", "ε.(MPa)", "af", "πtlp.(MPa)", "Reference") |>
  dplyr::rename(originalName = Species,
                LeafPI0 = "πo.(MPa)",
                LeafEPS = "ε.(MPa)",
                LeafAF = af,
                Ptlp = "πtlp.(MPa)") |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""),
                Priority = 2)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Bartlett_et_al_2012.rds")
