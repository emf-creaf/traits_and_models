#
# Henry et al. (2019)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Henry_et_al_2019/41467_2019_11006_MOESM3_ESM.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "gmin", "gmax s", "LMA", "πTLP", "ψgs20 s", "ψgs50 s", "ψgs80 s", "πo") |>
  dplyr::rename(originalName = Species,
                Gswmax = "gmax s",
                Gswmin = "gmin",
                SLA = "LMA",
                LeafPI0 = "πo",
                Ptlp = "πTLP",
                Gs_P20 = "ψgs20 s",
                Gs_P50 = "ψgs50 s",
                Gs_P80 = "ψgs80 s") |>
  dplyr::mutate(Gswmax = Gswmax/1000) |> # mmol to mol
  dplyr::mutate(Gswmin = Gswmin/1000) |> # mmol to mol
  dplyr::mutate(SLA = 1000/SLA) |> # g·m-2 to m2·kg-1
  dplyr::mutate(LeafPI0 = -1*LeafPI0) |> # From -MPa to MPa
  dplyr::mutate(Ptlp = -1*Ptlp) |> # From -MPa to MPa
  dplyr::mutate(Gs_P20 = -1*Gs_P20) |> # From -MPa to MPa
  dplyr::mutate(Gs_P50 = -1*Gs_P50) |> # From -MPa to MPa
  dplyr::mutate(Gs_P80 = -1*Gs_P80) |> # From -MPa to MPa
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Henry et al. (2019) A stomatal safety-efficiency trade-off constrains reponses to leaf dehydration. Nature communications.",
                DOI = "10.1038/s41467-019-11006-1",
                Priority = 1) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing ----------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Henry_et_al_2019.rds")
