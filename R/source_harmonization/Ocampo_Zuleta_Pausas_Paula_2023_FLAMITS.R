#
# Ocampo-Zuleta, Pausas & Paula (2023) - FLAMITS
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
flamits_db <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Ocampo_Zuleta_Pausas_Paula_et_al_2023_FLAMITS/data_file.csv"), 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
flamits_ref <- readr::read_delim(paste0(DB_path,"data-raw/raw_trait_data/Ocampo_Zuleta_Pausas_Paula_et_al_2023_FLAMITS/source_file.csv"), 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

traits <-sort(unique(flamits_db$var_name))

# HeatContent --------------------------------------------------
db_var <- flamits_db |>
  dplyr::filter(fuel_type=="live", plant_part =="leaves", predrying=="yes")|>
  dplyr::select("taxon_name", "var_name", "var_value", "source_ID") |>
  dplyr::filter(var_name == "calorific value (kcal/kg)")|>
  dplyr::rename(Value = "var_value")|>
  dplyr::mutate(Trait = "HeatContent",
                Value = 4.18400*as.numeric(Value), 
                Units = "kJ kg-1") |> # From kcal/kg to kJ/kg
  dplyr::relocate(Trait, .before = Value) |>
  dplyr::left_join(flamits_ref[,c("source_ID", "reference")], by="source_ID") |>
  dplyr::select(-source_ID) |>
  dplyr::rename(originalName = "taxon_name",
                OriginalReference = "reference")|>
  dplyr::select(-var_name)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)|>
  dplyr::mutate(Reference = "Ocampo-Zuleta et al. (2018) FLAMITS: A global database of plant flammability traits. Global Ecology & Biogeography 33, 412-135") |>
  dplyr::mutate(DOI = "10.1111/geb.13799") |>
  dplyr::relocate(OriginalReference, .after = "DOI") |>
  dplyr::mutate(Priority = 1)
traits4models::check_harmonized_trait(db_var)
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))
traits4models::check_harmonized_trait(db_post)
saveRDS(db_post, "data/harmonized_trait_sources/Ocampo_Zuleta_Pausas_Paula_2023_FLAMITS_HeatContent.rds")
