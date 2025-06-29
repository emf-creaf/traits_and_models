#
# Wolfe et al. (2023)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Wolfe_et_al_2023/pce14524-sup-0002-tables_s1_and_s2.xlsx"), sheet = "Table S2")

# kleaf --------------------------------------------------
db_var <- db |>
  dplyr::select(species, "Kleaf", "Kleaf source") |>
  dplyr::rename(originalName = species,
                Value = "Kleaf",
                OriginalReference = "Kleaf source") |>
  dplyr::mutate(Trait = "kleaf",
                Value = as.numeric(Value),
                Units = "mmol m-2 s-1 MPa-1") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Wolfe et al. (2022). Leaves as bottlenecks: The contribution of tree leaves to hydraulic resistance within the soil−plant−atmosphere continuum. Plant Cell & Env. 46: 736-746",
                DOI = "10.1111/pce.14524") |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::mutate(Priority = 1)|>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Wolfe_et_al_2023_Kleaf.rds")


# kplant --------------------------------------------------
db_var <- db |>
  dplyr::select(species, "ktotal", "Ktotal source") |>
  dplyr::rename(originalName = species,
                Value = "ktotal",
                OriginalReference = "Ktotal source") |>
  dplyr::mutate(Trait = "kplant",
                Value = as.numeric(Value),
                Units = "mmol m-2 s-1 MPa-1") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Wolfe et al. (2022). Leaves as bottlenecks: The contribution of tree leaves to hydraulic resistance within the soil−plant−atmosphere continuum. Plant Cell & Env. 46: 736-746",
                DOI = "10.1111/pce.14524") |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  dplyr::mutate(Priority = 1)|>
  tibble::as_tibble()
db_var$OriginalReference[db_var$OriginalReference=="present study"] <- NA
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Wolfe_et_al_2023_Kplant.rds")
