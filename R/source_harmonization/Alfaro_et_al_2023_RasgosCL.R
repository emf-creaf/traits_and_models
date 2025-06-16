#
# Alfaro et al. (2023) - RasgosCL
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
rasgoscl_db <- read_csv(paste0(DB_path, "data-raw/raw_trait_data/Alfaro_et_al_2023_RasgosCL/Data/RasgosCL_longformat.csv"))
rasgoscl_ref <- read_csv(paste0(DB_path, "data-raw/raw_trait_data/Alfaro_et_al_2023_RasgosCL/Data/RasgosCL_references.csv")) |>
  dplyr::rename(OriginalReference = "Reference")

# Hmax --------------------------------------------------
db_var <- rasgoscl_db |>
  dplyr::select("accepted_species", "traitName", "traitValue", "traitUnit", "ID_reference") |>
  dplyr::filter(traitName == "Max_plant_height")|>
  dplyr::rename(Hmax = "traitValue")|>
  dplyr::mutate(Hmax = as.numeric(Hmax)) |>
  dplyr::rename(Units = "traitUnit")|>
  dplyr::rename(OriginalReferenceID = "ID_reference")|>
  dplyr::rename(originalName = "accepted_species")|>
  dplyr::select(-traitName)|>
  dplyr::arrange(originalName) |> 
  dplyr::mutate(Reference = "Alfaro et al. (2023). Rasgos-CL: A functional trait database of Chilean woody plants. Global Ecology and Biogeography, 32, 2072–2084") |>
  dplyr::mutate(DOI = "10.1111/geb.13755")  |>
  dplyr::left_join(rasgoscl_ref, by = c("OriginalReferenceID" = "ID_reference")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::mutate(Priority = 1)
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)

saveRDS(db_post, "data/harmonized_trait_sources/Alfaro_et_al_2023_Hmax.rds")



# SeedMass --------------------------------------------------
db_var <- rasgoscl_db |>
  dplyr::select("accepted_species", "traitName", "traitValue", "traitUnit", "ID_reference") |>
  dplyr::filter(traitName == "Seed_mass")|>
  dplyr::rename(SeedMass = "traitValue")|>
  dplyr::mutate(SeedMass = as.numeric(SeedMass)) |>
  dplyr::rename(Units = "traitUnit")|>
  dplyr::rename(OriginalReferenceID = "ID_reference")|>
  dplyr::rename(originalName = "accepted_species")|>
  dplyr::select(-traitName)|>
  dplyr::arrange(originalName) |> 
  dplyr::mutate(Reference = "Alfaro et al. (2023). Rasgos-CL: A functional trait database of Chilean woody plants. Global Ecology and Biogeography, 32, 2072–2084") |>
  dplyr::mutate(DOI = "10.1111/geb.13755")  |>
  dplyr::left_join(rasgoscl_ref, by = c("OriginalReferenceID" = "ID_reference")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::mutate(Priority = 1)
# Harmonize units to mg
# OK!
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)

saveRDS(db_post, "data/harmonized_trait_sources/Alfaro_et_al_2023_SeedMass.rds")


