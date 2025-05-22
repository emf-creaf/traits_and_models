#
# Huang et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "WFO_Backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_xls(paste0(DB_path, "Sources/Huang_et_al_2024/Huang_et_al.__2024-Journal_of_ecology_Supplementary_Data.xls"), 
                       sheet="Table 3", na = c("—"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "AL/AS","P50stem", "P50leaf", "Ψtlp", "WD") |>
  dplyr::rename(originalName = Species,
                VCstem_P50 = "P50stem",
                VCleaf_P50 = "P50leaf",
                Ptlp = "Ψtlp",
                Al2As = "AL/AS",
                WoodDensity = "WD") |>
  dplyr::mutate(Al2As = 10000*Al2As) |>
  dplyr::mutate(Reference = "Huang et al. (2024). Vulnerability segmentation is vital to hydraulic strategy of tropical–subtropical woody plants. Journal of Ecology",
                DOI = "10.1111/1365-2745.14421",
                Priority = 2)|>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "Products/harmonized/Huang_et_al_2024.rds")
