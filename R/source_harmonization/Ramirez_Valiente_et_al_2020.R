#
# Ramirez-Valiente et al. (2020)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Ramirez_Valiente_et_al_2020/nph16320-sup-0001-datasets1.xlsx"), sheet = 2)
sp_trans <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Ramirez_Valiente_et_al_2020/Species_translation.xlsx"))

# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::left_join(sp_trans, by="SP") |>
  dplyr::select("Name", "SLA", "Hvaluex10000", "Kleaf", "Kplant", "Ks_max") |>
  dplyr::rename(originalName = "Name",
                kplant = "Kplant",
                kleaf = "Kleaf",
                Ks = "Ks_max") |>
  dplyr::mutate(Al2As = 10000/Hvaluex10000,
                SLA = SLA/10)|>
  dplyr::arrange(originalName) |> 
  dplyr::select(-Hvaluex10000) |>
  tibble::as_tibble()

db_var$Reference <- "Ramirez-Valiente et al. (2020) Correlated evolution of morphology, gas exchange, growth rates
and hydraulics as a response to precipitation and temperature regimes in oaks (Quercus). New Phytologist 227: 794–809."
db_var$DOI <- "10.1111/nph.16320"
db_var$Priority <- 1

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Ramirez_Valiente_et_al_2020.rds")
