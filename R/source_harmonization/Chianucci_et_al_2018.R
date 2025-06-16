#
# Chianucci et al. (2018)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Chianucci_et_al_2018/dataset_full.csv"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Genus", "Species", "Angle_degree") |>
  dplyr::rename(LeafAngle = "Angle_degree")|>
  dplyr::mutate(LeafAngle = as.numeric(LeafAngle),
                Units = "degrees") |>
  tidyr::replace_na(list(Species = ""))|>
  dplyr::mutate(originalName = stringr::str_c(Genus, Species, sep = " "))|>
  dplyr::mutate(originalName = stringr::str_trim(originalName, side = "right"))|>
  dplyr::select(-c(Genus,Species))|>
  dplyr::relocate(originalName, .before = LeafAngle) |>
  dplyr::mutate(Reference = "Chianucci F, Pisek J, Raabe K, Marchino L, Ferrara C, Corona P (2018) A dataset of leaf inclination angles for temperate and boreal broadleaf woody species. Ann. For. Sci. 75: 50",
                DOI = "10.1007/s13595-018-0730-x",
                Priority = 1) |>
  dplyr::arrange(originalName)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Chianucci_et_al_2018_LeafAngle.rds")
