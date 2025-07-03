#
# Nadal et al. (2023)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db_raw <- readr::read_delim(paste0(DB_path, "data-raw/raw_trait_data/Nadal_et_al_2023/Nadal_et_al_2023_Eco_Lett_DRYAD.csv"), 
                     delim = ";", escape_double = FALSE, trim_ws = TRUE, na = "n/a")
def <- t(db_raw[c(1,2),])
db <- db_raw[-c(1,2),]
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "LMA", "LD", "Nmass", "ε*", "πtlp", "πo", "fapo") |>
  dplyr::rename(originalName = "Species",
                LeafDensity = "LD",
                Nleaf = "Nmass",
                LeafEPS = "ε*",
                Ptlp = "πtlp",
                LeafPI0 = "πo",
                LeafAF = "fapo")|>
  dplyr::mutate(SLA = 1000/as.numeric(LMA), # From g m-2 to m2 kg-1
                Nleaf = as.numeric(Nleaf), # mg g-1
                LeafDensity = as.numeric(LeafDensity),
                LeafEPS = as.numeric(LeafEPS),
                LeafAF = as.numeric(LeafAF),
                LeafPI0 = as.numeric(LeafPI0),
                Ptlp = as.numeric(Ptlp))|> # g cm-3
  dplyr::select(-LMA) |>
  dplyr::mutate(Reference = "Nadal et al. (2023) Incorporating pressure–volume traits into the leaf economics spectrum. Ecology Letters 26:549-562",
                DOI = "10.1111/ele.14176",
                Priority = 1) |>
  dplyr::arrange(originalName)

traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Nadal_et_al_2023.rds")
