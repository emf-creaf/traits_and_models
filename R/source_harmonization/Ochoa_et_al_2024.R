#
# Ochoa et al. (2024)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
db_raw <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Ochoa_et_al_2024/gmin_SuppData_f.xlsx"), 
                                      sheet = "Table S3", skip = 2, n_max = 205)
def <- t(db_raw[c(1,2),])
db <- db_raw[-c(1,2),]
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species/genotypes", "gleaf,min...14", "Reference") |>
  dplyr::rename(originalName = "Species/genotypes",
                Value = "gleaf,min...14",
                OriginalReference = "Reference")|>
  dplyr::mutate(Trait = "Gswmin",
                Value = as.numeric(Value),
                Units = "mmol m-2 s-1")|> 
  dplyr::filter(!is.na(Value),
                originalName!="Eucalyptus clones")|>
  dplyr::relocate(Trait, Value, Units, .after = originalName) |>
  dplyr::mutate(Reference = "Ochoa et al. (2024) Pinpointing the causal influences of stomatal anatomy and behavior on minimum, operational, and maximum leaf surface conductance. Plant Physiology 196:51-66",
                DOI = "10.1093/plphys/kiae292",
                Priority = 1) |>
  dplyr::arrange(originalName)

# Check units (from mmol s-1 m-2 to mol s-1 m-2)
table(db_var$Units)
db_var <- db_var |>
  dplyr::mutate(Value = Value/1000,
                Units = "mol s-1 m-2")
traits4models::check_harmonized_trait(db_var)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Ochoa_et_al_2024.rds")
