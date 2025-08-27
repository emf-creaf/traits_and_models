#
# Rimer & McAdam 2025
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Rimer_McAdam_2025/Rimer_&_McAdam_2025_table_1.xlsx"), sheet = 1)

db$Species <- unlist(lapply(strsplit(db$Species, " "), function(x) {paste(x[[1]], x[[2]])}))
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, "Maximum.plant.height.(cm)", "P50.(MPa)", "OP.(MPa)", "TLP.(MPa)", "LMA.(g.m−2)") |>
  dplyr::filter(Species != "Solidago canadensis") |>
  dplyr::rename(originalName = "Species",
                Hmax = "Maximum.plant.height.(cm)",
                LeafPI0 = "OP.(MPa)",
                VCleaf_P50 = "P50.(MPa)",
                Ptlp = "TLP.(MPa)",
                LMA = "LMA.(g.m−2)") |>
  dplyr::mutate(SLA = 1000/LMA) |> # From g m-2 to m2 kg-1
  dplyr::select(-LMA) |>
  dplyr::mutate(Reference = "Rimer & McAdam (2025) Temporally disjunct herbaceous species differ in leaf embolism resistance. New Phytol. 247: 2630-2646",
                DOI = "10.1111/nph.70335",
                Priority = 1) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Rimer&McAdam_2025.rds")
