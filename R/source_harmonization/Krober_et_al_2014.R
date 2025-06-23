#
# Kröber et al. (2014)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readr::read_delim(paste0(DB_path, "data-raw/raw_trait_data/Krober_et_al_2014/pone.0109211.s002.txt"), 
                 delim = "\t", escape_double = FALSE, 
                 trim_ws = TRUE)

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "PSI50", "KS", "WOODDENS", "SLA", "LDMC", "LA", "LNC") |>
  dplyr::rename(originalName = "Species",
                VCstem_P50 = "PSI50",
                Ks = "KS",
                WoodDensity = "WOODDENS",
                SLA = "SLA",
                LDMC = "LDMC", 
                LeafArea = "LA",
                Nleaf = "LNC")|>
  dplyr::mutate(VCstem_P50 = as.numeric(VCstem_P50),
                Ks = as.numeric(Ks),
                WoodDensity = as.numeric(WoodDensity),
                SLA = as.numeric(SLA),
                LDMC = as.numeric(LDMC),
                LeafArea = as.numeric(LeafArea),
                Nleaf = as.numeric(Nleaf)) |> 
  dplyr::mutate(Reference = "Kröber et al. (2014) Linking Xylem Hydraulic Conductivity and Vulnerability to the Leaf Economics Spectrum—A Cross-Species Study of 39 Evergreen and Deciduous Broadleaved Subtropical Tree Species. PLoS ONE 9: e109211",
                DOI = "10.1371/journal.pone.0109211",
                Priority = 1) |>
  dplyr::arrange(originalName)

db_var$originalName<- unlist(lapply(strsplit(db_var$originalName, " "), function(y) paste(y[1:2], collapse = " ")))

traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Krober_et_al_2014.rds")
