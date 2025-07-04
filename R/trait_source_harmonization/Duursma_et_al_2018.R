#
# Duursma et al. (2018)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
fn_duursma <- file.path(DB_path, "data-raw/raw_trait_data/Duursma_et_al_2018/gmindatabase.csv")
db <- readr::read_csv(fn_duursma)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(species, "gmin", "citation") |>
  dplyr::rename(originalName = species,
                Value = "gmin",
                OriginalReference = "citation") |>
  dplyr::mutate(Trait = "Gswmin",
                Value = Value/1000, # From mmol to mol
                Units = "mol s-1 m-2") |> 
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(Reference = "Duursma et al. (2018) On the minimum leaf conductance: its role in models of plant water use, and ecological and environmental controls. New Phytologist 221, 693-705",
                DOI = "10.1111/nph.15395", 
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Duursma_et_al_2018.rds")
