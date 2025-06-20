#
# Martin-StPaul et al. (2017)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db_vc <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/MartinStPaul_et_al_2017/DataBase.xlsx"), sheet = "Stem_VCurves")
db_pgs90 <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/MartinStPaul_et_al_2017/DataBase.xlsx"), sheet = "Pgs90")
db_ptlp <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/MartinStPaul_et_al_2017/DataBase.xlsx"), sheet = "Ptlp")


# StemVC ------------------------------------------------------------------
db_var <- db_vc |>
  dplyr::select("Species.binomial", "P50", "P12", "Slope", "References") |>
  dplyr::rename(originalName = "Species.binomial",
                VCstem_P50 = "P50",
                VCstem_P12 = "P12",
                VCstem_slope = "Slope",
                OriginalReference = "References") |>
  dplyr::mutate(Reference = "Martin-StPaul et al. (2017) Plant resistance to drought depends on timely stomatal closure. Ecology Letters 20, 1437-1447",
                DOI = "10.1111/ele.12851",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = "DOI")|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/MartinStPaul_et_al_2017_StemVC.rds")


# Gs_P90 -------------------------------------------------------------------
db_var <- db_pgs90 |>
  dplyr::select("Species.binomial", "ψgs90", "REFERENCES") |>
  dplyr::rename(originalName = "Species.binomial",
                Value = "ψgs90",
                OriginalReference = "REFERENCES") |>
  dplyr::mutate(Trait = "Gs_P90",
                Value = as.numeric(Value),
                Units = "MPa") |>
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::filter(!is.na(Value)) |>
  dplyr::mutate(Reference = "Martin-StPaul et al. (2017) Plant resistance to drought depends on timely stomatal closure. Ecology Letters 20, 1437-1447",
                DOI = "10.1111/ele.12851",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = "DOI")|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/MartinStPaul_et_al_2017_Gs_P90.rds")


# LeafPI0 & Ptlp -------------------------------------------------------------------
db_var <- db_ptlp |>
  dplyr::select("Species.binomial","π0", "ψtlp", "Reference") |>
  dplyr::rename(originalName = "Species.binomial",
                Ptlp = "ψtlp",
                LeafPI0 = "π0",
                OriginalReference = "Reference") |>
  dplyr::mutate(Ptlp = as.numeric(Ptlp),
                LeafPI0 = as.numeric(LeafPI0)) |>
  dplyr::filter(!is.na(Ptlp) | !is.na(LeafPI0)) |>
  dplyr::mutate(Reference = "Martin-StPaul et al. (2017) Plant resistance to drought depends on timely stomatal closure. Ecology Letters 20, 1437-1447",
                DOI = "10.1111/ele.12851",
                Priority = 1) |>
  dplyr::relocate(OriginalReference, .after = "DOI")|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/MartinStPaul_et_al_2017_LeafPI0_Ptlp.rds")
