#
# Liu et al. (2019)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Liu_et_al_2019/aav1332_table_s1.xlsx"), sheet = "full_data")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, `Life form`, Hmax, Hact, Ks, Kl, P50, TLP, AlAs, WD) |>
  dplyr::rename(originalName = Species,
                GrowthForm = "Life form",
                VCstem_P50 = P50,
                Ptlp = TLP,
                WoodDensity = WD,
                Al2As = AlAs) |>
  dplyr::mutate(
    GrowthForm = dplyr::case_when(GrowthForm == "T" ~ "Tree",
                                  GrowthForm == "S" ~ "Shrub")
  )|>
  dplyr::mutate(Hmax = Hmax * 100) |> # m to cm
  dplyr::mutate(Hact = Hact * 100) |> # m to cm
  dplyr::mutate(Al2As = Al2As * 10000) |> # m2·cm-2 to m2·m-2
  dplyr::filter(!is.na(originalName)) |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ sp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference <- "Liu et al. 2019"
db_var$Priority <- 2

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing ----------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Liu_et_al_2019.rds")
