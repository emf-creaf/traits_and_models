#
# Zhu et al. (2018)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Zhu_et_al_2018/tpy013supplementarydata_appendix2_raw_data.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, SLA, LD, ptlp, P50leaf, P50branch, Source) |>
  dplyr::rename(originalName = Species,
                LeafDensity = LD,
                Ptlp = ptlp,
                VCleaf_P50 = P50leaf,
                VCstem_P50 = P50branch,
                OriginalReference = Source) |>
  dplyr::mutate(SLA = SLA/10) |>  # cm2·g-1 to m2·kg-1
  dplyr::arrange(originalName) |>
  dplyr::mutate(Reference = "Zhu et al. (2018). Leaf turgor loss point is correlated with drought tolerance and leaf
carbon economics traits. Tree Physiol. 38, 658-663",
                DOI = "10.1093/treephys/tpy013", 
                Priority = 3) |>
  dplyr::relocate(OriginalReference, .after = DOI) |>
  tibble::as_tibble()

db_var$Priority[db$Source=="this study"] <- 1
db_var$OriginalReference[db$Source=="this study"] <- NA

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Zhu_et_al_2018.rds")
