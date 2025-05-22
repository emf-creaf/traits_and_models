#
# Ocampo-Zuleta, Pausas & Paula (2023) - FLAMITS
#
source("Rscripts/helpers.R")

DB_path <- "./"
WFO_path <- "./"

# Read database -----------------------------------------------------------
flamits_db <- readr::read_delim(paste0(DB_path,"Sources/Ocampo_Zuleta_Pausas_Paula_et_al_2023_FLAMITS/data_file.csv"), 
                             delim = ";", escape_double = FALSE, trim_ws = TRUE)
biblio <- readr::read_delim(paste0(DB_path,"Sources/Ocampo_Zuleta_Pausas_Paula_et_al_2023_FLAMITS/source_file.csv"), 
                            delim = ";", escape_double = FALSE, trim_ws = TRUE)

traits <-sort(unique(flamits_db$var_name))
# HeatContent --------------------------------------------------"
db_var <- flamits_db |>
  dplyr::filter(fuel_type=="live", plant_part =="leaves", predrying=="yes")|>
  dplyr::select("taxon_name", "var_name", "var_value", "source_ID") |>
  dplyr::filter(var_name == "calorific value (kcal/kg)")|>
  dplyr::rename(HeatContent = "var_value")|>
  dplyr::mutate(HeatContent = 4.18400*as.numeric(HeatContent), Units = "kJ/kg") |> # From kcal/kg to kJ/kg
  dplyr::left_join(biblio[,c("source_ID", "reference")], by="source_ID") |>
  dplyr::select(-source_ID) |>
  dplyr::rename(originalName = "taxon_name",
                Reference = "reference")|>
  dplyr::select(-var_name)|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ ssp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ spp\\.", ""))|>
  dplyr::mutate(originalName = stringr::str_replace(originalName, "\\ var\\.", ""))|>
  dplyr::arrange(originalName)
db_post <- harmonize_taxonomy_WFO(db_var, WFO_path)
saveRDS(db_post, "Products/harmonized/Ocampo_Zuleta_Pausas_Paula_2023_FLAMITS_HeatContent.rds")
