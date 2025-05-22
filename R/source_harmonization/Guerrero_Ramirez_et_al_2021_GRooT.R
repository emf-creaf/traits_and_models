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
  dplyr::rename(Z95 = "traitValue",
                Reference = references)|>
  dplyr::mutate(Z95 = as.numeric(Z95)*1000,
                Units = "mm") |> # from m to mm
  dplyr::select(-traitName)|>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Z95) |>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName)

db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_RootingDepth.rds")

# SRL --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Specific_root_length")|>
  dplyr::rename(SRL = "traitValue",
                Reference = references)|>
  dplyr::mutate(SRL = as.numeric(SRL)*100,# from m/g to cm/g
                Units = "cm/g") |> 
  dplyr::select(-traitName)|>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = SRL) |>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_SRL.rds")

# FineRootDensity --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Root_tissue_density")|>
  dplyr::rename(FineRootDensity = "traitValue",
                Reference = references)|>
  dplyr::mutate(FineRootDensity = as.numeric(FineRootDensity),
                Units = "g/cm3") |> 
  dplyr::select(-traitName)|>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = FineRootDensity) |>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_FineRootDensity.rds")


# Nfineroot --------------------------------------------------
db_var <- groot_db |>
  dplyr::select("genus", "species", "infraspecific", "traitName", "traitValue", "references") |>
  dplyr::filter(traitName == "Root_N_concentration")|>
  dplyr::rename(Nfineroot = "traitValue",
                Reference = references)|>
  dplyr::mutate(Nfineroot = as.numeric(Nfineroot),
                Units = "mg/g") |> 
  dplyr::select(-traitName)|>
  tidyr::replace_na(list(species = "", infraspecific = ""))|>
  dplyr::mutate(originalName = stringr::str_c(genus, species, infraspecific, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(genus,species, infraspecific))|>
  dplyr::relocate(originalName, .before = Nfineroot) |>
  dplyr::relocate(Units, .before = Reference) |>
  dplyr::mutate(Priority = 1) |>
  dplyr::arrange(originalName)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Guerrero_Ramirez_et_al_2021_GRooT_Nfineroot.rds")
