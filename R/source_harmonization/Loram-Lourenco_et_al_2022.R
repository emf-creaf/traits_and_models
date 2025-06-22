#
# Loram-Lourenco et al. (2022)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel("data-raw/raw_trait_data/Loram-Lourenco_et_al_2022/Data_from_Loram-Lourenço_et_al..xlsx", 
                             sheet = "Data from Loram-Lourenço et al.")

db_spp <- data.frame(species = c("A_othonianum","C_brasiliense","C_americana",
                                 "D_alata","S_dysentericus","H_chrysotrichus",
                                 "H_courbaril", "R_montana", "S_lutea",
                                 "X_aromatica"),
                     species_long = c("Anacardium occidentale", "Caryocar brasiliense", "Curatella americana",
                                      "Dypterix alata", "Eugenia dysenterica", "Handroanthus albus",
                                      "Hymenaea courbaril", "Roupala montana", "Spondias mombin",
                                      "Xylopia aromatica"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::left_join(db_spp) |>
  dplyr::select("species_long", "gbark", "gleaf_res", "Kstem") |>
  dplyr::rename(originalName = "species_long",
                Gbark = "gbark",
                Gswmin = "gleaf_res",
                Ks = "Kstem")|>
  dplyr::mutate(Reference = "Loram-Lourenço et al (2022) Variations in bark structural properties affect both water loss and carbon economics in neotropical savanna trees in the Cerrado region of Brazil. Journal of Ecology 110:1826-1843",
                DOI = "10.1111/1365-2745.13908",
                Priority = 1) |>
  dplyr::arrange(originalName)

traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Loram-Lourenco_et_al_2024.rds")
