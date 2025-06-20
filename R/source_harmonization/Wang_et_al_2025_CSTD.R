#
# Wang et al. (2025) - CSTD
#

DB_path <- "./"
WFO_path <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
cstd_db <- readxl::read_xlsx(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2025_CSTD/CSTD_v1.xlsx"), sheet = 1)
cstd_ref <- readxl::read_xlsx(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2025_CSTD/CSTD_v1.xlsx"), sheet = 2)

# SeedMass --------------------------------------------------
db_var <- cstd_db |>
  dplyr::select("Species_accepted", "Trait", "Value", "Unit", "Reference") |>
  dplyr::filter(Trait == "Seed mass")|>
  dplyr::mutate(Trait = "SeedMass",
                Value = as.numeric(Value)) |>
  dplyr::rename(Units = "Unit")|>
  dplyr::rename(OriginalReferenceID = "Reference")|>
  dplyr::rename(originalName = "Species_accepted")|>
  dplyr::arrange(originalName) |> 
  dplyr::mutate(Reference = "Wang et al. 2025. Chinese Seed Trait Database: a curated resource for diaspore traits in the Chinese flora. New Phytologist.") |>
  dplyr::mutate(DOI = "10.1111/nph.70296")  |>
  dplyr::left_join(cstd_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "Name") |>
  dplyr::mutate(Priority = 1)
# Check units (mg)
table(db_var$Units)
db_var$Value[db_var$Units=="g"] <- db_var$Value[db_var$Units=="g"]*1000
db_var$Units[db_var$Units=="g"] <- "mg"
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)

saveRDS(db_post, "data/harmonized_trait_sources/Wang_et_al_2025_SeedMass.rds")

# SeedLongevity --------------------------------------------------
db_var <- cstd_db |>
  dplyr::select("Species_accepted", "Trait", "Value", "Unit", "Reference") |>
  dplyr::filter(Trait == "Seed longevity")|>
  dplyr::mutate(Trait = "SeedLongevity",
                Value = as.numeric(Value)) |>
  dplyr::rename(Units = "Unit")|>
  dplyr::rename(OriginalReferenceID = "Reference")|>
  dplyr::rename(originalName = "Species_accepted")|>
  dplyr::arrange(originalName) |> 
  dplyr::mutate(Reference = "Wang et al. 2025. Chinese Seed Trait Database: a curated resource for diaspore traits in the Chinese flora. New Phytologist.") |>
  dplyr::mutate(DOI = "10.1111/nph.70296")  |>
  dplyr::left_join(cstd_ref, by = c("OriginalReferenceID" = "ID")) |>
  dplyr::select(-OriginalReferenceID) |>
  dplyr::rename(OriginalReference = "Name") |>
  dplyr::mutate(Priority = 1)
# Harmonize units to year
table(db_var$Units)
db_var$Value[db_var$Units=="month"] <- db_var$Value[db_var$Units=="month"]/12
db_var$Value[db_var$Units=="week"] <- db_var$Value[db_var$Units=="week"]/58
db_var$Value[db_var$Units=="day"] <- db_var$Value[db_var$Units=="day"]/365
db_var$Units <- "year"
# Harmonize taxonomy
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_path)
traits4models::check_harmonized_trait(db_post)

saveRDS(db_post, "data/harmonized_trait_sources/Wang_et_al_2025_SeedLongevity.rds")


