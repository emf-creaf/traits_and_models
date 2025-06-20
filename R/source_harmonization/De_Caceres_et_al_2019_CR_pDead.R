#
# De Cáceres et al. (2019) - CR and pDead
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
fn <- file.path(DB_path, "data-raw/raw_trait_data/DeCaceres_et_al_2019_CR_pDead/Shrub_Pdead_CR.txt")
db <- readr::read_delim(fn)

# Variable harmonization --------------------------------------------------
db_var <- db[1:27,] |>
  dplyr::select(Name, "CR.mean", "Pdead.mean") |>
  dplyr::rename(originalName = Name,
                CrownRatio = "CR.mean",
                pDead = "Pdead.mean") |>
  dplyr::mutate(originalName = stringr::str_replace(originalName, " sp\\.", ""))|>
  dplyr::mutate(Reference = "De Cáceres et al. (2019). Scaling-up individual-level allometric equations to predict stand-level fuel loading in Mediterranean shrublands. Ann. For. Sci. 76: 87",
                DOI = "10.1007/s13595-019-0873-4",
                Priority = 1) |>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

# To remove authors
db_var$originalName <- unlist(lapply(db_var$originalName, function(x) {paste(strsplit(x, " ")[[1]][1:2], collapse = " ")}) )

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = packageVersion("traits4models"))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/De_Caceres_et_al_2019_CR_pDead.rds")
