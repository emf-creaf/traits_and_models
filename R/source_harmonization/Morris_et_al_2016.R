#
# Morris et al. (2016)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Morris_et_al_2016/nph13737-sup-0002-tables1.xlsx"), sheet = 2)
db_ref <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Morris_et_al_2016/nph13737-sup-0002-tables1.xlsx"), sheet = 3)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species name", "Radial and Axial Parenchyma (%)", "Source") |>
  dplyr::rename(originalName = "Species name",
                conduit2sapwood = "Radial and Axial Parenchyma (%)",
                OriginalReferenceID = "Source") |>
  dplyr::filter(!is.na(conduit2sapwood)) |>
  dplyr::mutate(conduit2sapwood = 1 - (conduit2sapwood/100)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp", ""))|>
  dplyr::mutate(Reference = "Morris et al. (2016) A global analysis of parenchyma tissue fractions in secondary xylem of seed plants. New Phytologist 209, 1553-1565") |>
  dplyr::mutate(DOI = "10.1111/nph.13737")  |>
  dplyr::left_join(db_ref, by = c("OriginalReferenceID" = "Source ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "Full reference") |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName) |> 
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Morris_et_al_2016.rds")
