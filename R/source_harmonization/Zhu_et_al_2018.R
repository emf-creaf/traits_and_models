#
# Zhu et al. (2018)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"Sources/Zhu_et_al_2018/tpy013supplementarydata_appendix2_raw_data.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, SLA, LD, ptlp, P50leaf, P50branch, Source) |>
  dplyr::rename(originalName = Species,
                LeafDensity = LD,
                Ptlp = ptlp,
                VCleaf_P50 = P50leaf,
                VCstem_P50 = P50branch,
                Reference = Source) |>
  dplyr::mutate(SLA = SLA/10) |>  # cm2·g-1 to m2·kg-1
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var$Reference[db_var$Reference=="this study"] <- "Zhu et al. 2018"
db_var$Priority <- 3

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Zhu_et_al_2018.rds")
