#
# Balaguer-Romano et al. (2026)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Balaguer_Romano_et_al_2026/Traits_SpeciesRH.xlsx", sheet = "RH_DATA_URFM")

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "LDMC", "LMA", "Succulence", "gmin_leaf_PV", "Pi0", "Eps_ft", "psi_tlp",
                "P50", "P12", "P88", "Kmax", "Slope") |>
  dplyr::rename(originalName = Species,
                LDMC = "LDMC",
                LeafSucculence = "Succulence",
                Gswmin = "gmin_leaf_PV",
                LeafPI0 = "Pi0",
                LeafEPS = "Eps_ft",
                Ptlp = "psi_tlp",
                Ks = "Kmax",
                VCstem_P50 = "P50", 
                VCstem_P12 = "P12",
                VCstem_P88 = "P88",
                VCstem_slope = "Slope") |>
  dplyr::mutate(SLA = 1000/as.numeric(LMA), # 
                Ks = as.numeric(Ks), # kg m-1 MPa-1 s-1
                LeafSucculence = as.numeric(LeafSucculence))|>
  dplyr::mutate(Reference = "Balaguer-Romano, R., Sañé, A., Martin-StPaul, N., Ruffault, J., Gabriel, E., Castro, X., Pimont, F., Liu, X., Druel, A., Delzon, S. and De Cáceres, M. (2026), Key sources of uncertainty in process-based modeling of live fuel moisture content. New Phytologist",
                DOI = "https://doi.org/10.1111/nph.71286",
                Priority = 1) |>
  dplyr::select(-LMA) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Balaguer_Romano_et_al_2026.rds")
