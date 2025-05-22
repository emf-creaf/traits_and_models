#
# Morris et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Morris_et_al_2016/nph13737-sup-0002-tables1.xlsx"), sheet = 2)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species name", "Radial and Axial Parenchyma (%)", "Source") |>
  dplyr::rename(originalName = "Species name",
                conduit2sapwood = "Radial and Axial Parenchyma (%)",
                Reference = "Source") |>
  dplyr::mutate(conduit2sapwood = 1 - (conduit2sapwood/100)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp", ""))|>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Morris_et_al_2016.rds")
