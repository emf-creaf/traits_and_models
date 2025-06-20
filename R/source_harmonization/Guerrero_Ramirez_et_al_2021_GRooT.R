#
# Guerrero-Ramirez et al. (2021) - GRooT
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
groot_db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Guerrero_Ramirez_et_al_2021_GRooT/GRooTFullVersion.csv"))

# Rooting depth --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Rooting_depth")|>
  dplyr::rename(Trait = "traitName",
                Value = "traitValue",
                OriginalReference = references)|>
  dplyr::mutate(Trait = "Z95",
                Value = as.numeric(Value)*1000,
                Units = "mm") |> # from m to mm
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Trait) |>
  dplyr::mutate(Reference = "Guerrero-Ramírez et al. (2021) Global root traits (GRooT) database. Global Ecol Biogeogr. 30,25-37",
                DOI = "10.1111/geb.13179",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::arrange(originalName)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_RootingDepth.rds")

# SRL --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Specific_root_length")|>
  dplyr::rename(Trait = "traitName",
                Value = "traitValue",
                OriginalReference = references)|>
  dplyr::mutate(Trait = "SRL",
                Value = as.numeric(Value)*100,# from m/g to cm/g
                Units = "cm g-1") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::relocate(Units, .after = Value) |>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Value) |>
  dplyr::mutate(Reference = "Guerrero-Ramírez et al. (2021) Global root traits (GRooT) database. Global Ecol Biogeogr. 30,25-37",
                DOI = "10.1111/geb.13179",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::arrange(originalName)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_SRL.rds")

# FineRootDensity --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Root_tissue_density")|>
  dplyr::rename(Trait = "traitName",
                Value = "traitValue",
                OriginalReference = references)|>
  dplyr::mutate(Trait = "FineRootDensity",
                Value = as.numeric(Value),
                Units = "g cm-3") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::relocate(Units, .after = Value) |>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Value) |>
  dplyr::mutate(Reference = "Guerrero-Ramírez et al. (2021) Global root traits (GRooT) database. Global Ecol Biogeogr. 30,25-37",
                DOI = "10.1111/geb.13179",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::arrange(originalName)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_FineRootDensity.rds")


# # Nfineroot --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Root_N_concentration")|>
  dplyr::rename(Trait = "traitName",
                Value = "traitValue",
                OriginalReference = references)|>
  dplyr::mutate(Trait = "Nfineroot",
                Value = as.numeric(Value),
                Units = "mg g-1") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::relocate(Units, .after = Value) |>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Trait) |>
  dplyr::mutate(Reference = "Guerrero-Ramírez et al. (2021) Global root traits (GRooT) database. Global Ecol Biogeogr. 30,25-37",
                DOI = "10.1111/geb.13179",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::arrange(originalName)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_Nfineroot.rds")
