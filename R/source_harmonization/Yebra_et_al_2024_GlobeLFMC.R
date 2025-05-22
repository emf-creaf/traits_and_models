#
# Yebra et al. (2024) - Globe-LFMC
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Yebra_et_al_2024_LFMC/Globe-LFMC-2.0 final.xlsx"), sheet = 2)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(`Species collected`, `LFMC value (%)`, "Reference") |>
  dplyr::rename(originalName = `Species collected`,
                LFMC = `LFMC value (%)`) |>
  dplyr::filter(!is.na(originalName)) |>
  dplyr::filter(!originalName %in% c("Unknown grass", "Unknown graminoid", "Unknown sciadion", "")) |>
  dplyr::filter(!stringr::str_detect(originalName, "\\,"))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ L\\.", ""))|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Yebra_et_al_2024_LFMC.rds")
