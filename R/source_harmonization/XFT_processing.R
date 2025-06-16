#
# Choat et al. (2012) XFT
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_csv(paste0(DB_path, "data-raw/raw_trait_data/Choat_et_al_2012_XFT/XFT_full_database_download_20230926-154837.csv"))

# Variable harmonization --------------------------------------------------
XFT_all <- db |>
  dplyr::select(Genus, Species, "Height.max..m.", "Height.actual..m.", 
                "Huber.value", "SLA..cm2.g.1.", "TLP..MPa.", "Reference") |>
  dplyr::rename(Hmax = "Height.max..m.",
                Hact = "Height.actual..m.",
                Hv = "Huber.value",
                SLA = "SLA..cm2.g.1.",
                Ptlp = "TLP..MPa.",
                OriginalReference = "Reference") |>
  dplyr::mutate(Hmax = Hmax*100, #change units from m to cm
                Hact = Hact*100) |>
  dplyr::filter(!is.na(Hmax) | !is.na(Hact)| !is.na(Hv)| !is.na(SLA)| !is.na(Ptlp))|>
  tibble::as_tibble() 


XFT_stem <- db |>
  dplyr::filter(Plant.organ %in% c("s", "S")) |>
  dplyr::select(Genus, Species, 
                "P50..MPa.", "P12..MPa.", "P88..MPa.", "Slope",
                "Ks..kg.m.1.MPa.1.s.1.", "Reference") |>
  dplyr::rename(VCstem_P50 = "P50..MPa.",
                VCstem_P12 = "P12..MPa.",
                VCstem_P88 = "P88..MPa.",
                VCstem_slope = "Slope",
                Ks = "Ks..kg.m.1.MPa.1.s.1.",
                OriginalReference = "Reference")

XFT_leaf <- db |>
  dplyr::filter(Plant.organ %in% c("l", "L")) |>
  dplyr::select(NewID, Genus, Species, 
                "P50..MPa.", "P12..MPa.", "P88..MPa.", "Slope", "Reference") |>
  dplyr::rename(VCleaf_P50 = "P50..MPa.",
                VCleaf_P12 = "P12..MPa.",
                VCleaf_P88 = "P88..MPa.",
                VCleaf_slope = "Slope",
                OriginalReference = "Reference")

XFT_root <- db |>
  dplyr::filter(Plant.organ %in% c("r", "R")) |>
  dplyr::select(NewID, Genus, Species, 
                "P50..MPa.", "P12..MPa.", "P88..MPa.", "Slope", "Reference") |>
  dplyr::rename(VCroot_P50 = "P50..MPa.",
                VCroot_P12 = "P12..MPa.",
                VCroot_P88 = "P88..MPa.",
                VCroot_slope = "Slope",
                OriginalReference = "Reference")

db_var <- XFT_all |>
  dplyr::bind_rows(XFT_stem)|>
  dplyr::bind_rows(XFT_leaf)|>
  dplyr::bind_rows(XFT_root) |>
  dplyr::arrange(Genus, Species) |>
  dplyr::filter(!(Species %in% c("spp.", "sp", "sp."))) |>
  dplyr::mutate(originalName = paste0(Genus, " ", Species)) |>
  dplyr::relocate(originalName, .before = Genus) |>
  dplyr::arrange(originalName) |>
  dplyr::select(-c(Genus, Species)) |>
  dplyr::mutate(Reference = "Choat et al. (2012)",
                DOI = "https://xylemfunctionaltraits.org/",
                Priority = 2) |>
  dplyr::relocate(OriginalReference, .after = DOI)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

saveRDS(db_post, "data/harmonized_trait_sources/Choat_et_al_2012_XFT.rds")
