#
# Rimer & McAdam 2024
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- openxlsx::read.xlsx(paste0(DB_path, "data-raw/raw_trait_data/Rimer_McAdam_2024/Within-leaf_variation_in_embolism_resistance_is_not_a_rule_in_compound-leaved_angiosperms.xlsx"), sheet = 2)


# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select(Species, Organ, "P.12.(MPa)", "P.50.(MPa)", "P.88.(MPa)") |>
  dplyr::mutate(Species = dplyr::case_match(Species, 
                                            "Charmaerysta fasciculata" ~ "Chamaecrista fasciculata",
                                            .default = Species)) |>
  dplyr::filter(Organ %in% c("Whole Leaf", "Leaf")) |>
  dplyr::rename(originalName = "Species",
                VCleaf_P12 = "P.12.(MPa)",
                VCleaf_P50 = "P.50.(MPa)",
                VCleaf_P88 = "P.88.(MPa)") |>
  dplyr::select(-Organ) |>
  dplyr::mutate(Reference = "Rimer IM & McAdam SAM (2024) Within-leaf variation in embolism resistance is not a rule for compound-leaved angiosperms. J. Am. Bot. 111, e16447",
                DOI = "10.1002/ajb2.16447",
                Priority = 1) |>
  tibble::as_tibble()

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Rimer&McAdam_2024.rds")
