#
# Alfaro et al. (2023) - RasgosCL
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
rasgoscl_db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Alfaro_et_al_2023_RasgosCL/Data/RasgosCL_longformat.csv"))
rasgoscl_ref <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Alfaro_et_al_2023_RasgosCL/Data/RasgosCL_references.csv")) |>
  dplyr::rename(OriginalReference = "Reference")

# Hmax --------------------------------------------------
db_var <- rasgoscl_db |>
  dplyr::select("accepted_species", "traitName", "traitValue", "traitUnit", "ID_reference") |>
  dplyr::filter(traitName == "Max_plant_height")|>
  dplyr::rename(Value = "traitValue")|>
  dplyr::mutate(Trait = "Hmax",
                Value = as.numeric(Value)) |>
  dplyr::rename(Units = "traitUnit")|>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::rename(OriginalReferenceID = "ID_reference")|>
  dplyr::rename(originalName = "accepted_species")|>
  dplyr::select(-traitName)|>
  dplyr::arrange(originalName) |> 
  dplyr::mutate(Reference = "Alfaro et al. (2023). Rasgos-CL: A functional trait database of Chilean woody plants. Global Ecology and Biogeography, 32, 2072–2084") |>
  dplyr::mutate(DOI = "10.1111/geb.13755")  |>
  dplyr::left_join(rasgoscl_ref, by = c("OriginalReferenceID" = "ID_reference")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::mutate(Priority = 1)

# Change units from m to cm
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value * 100,
                Units = "cm")
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Alfaro_et_al_2023_Hmax.rds")



# SeedMass --------------------------------------------------
db_var <- rasgoscl_db |>
  dplyr::select("accepted_species", "traitName", "traitValue", "traitUnit", "ID_reference") |>
  dplyr::filter(traitName == "Seed_mass")|>
  dplyr::rename(Value = "traitValue")|>
  dplyr::mutate(Trait = "SeedMass",
                Value = as.numeric(Value)) |>
  dplyr::rename(Units = "traitUnit")|>
  dplyr::relocate(Trait, .before = Value) |>
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
table(db_var$Units)
# OK!
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Alfaro_et_al_2023_SeedMass.rds")


