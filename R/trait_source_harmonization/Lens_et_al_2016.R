#
# Lens et al. (2016)
#
# We remove values from Choat et al. 2012 (XFT) to avoid duplicate records

harmonize_Lens_et_al_2016 <- function(DB_path = "./", checkVersion = as.character(packageVersion("traits4models"))) {
  WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")
  
  # Read database -----------------------------------------------------------
  db <- readxl::read_excel(paste0(DB_path,"data-raw/raw_trait_data/Lens_et_al_2016/Lens_2016_P50_all_species_updated_FINAL_version3.xlsx"))
  # Add measurement method from table S1
  Table_S1_FULL <- readr::read_csv("data-raw/raw_trait_data/Lens_et_al_2016/Table_S1_FULL.csv")
  db <- db |>
    dplyr::left_join(Table_S1_FULL[,c("Species", "Method used")], by=c("species...4" = "Species"))
  
  # Variable harmonization --------------------------------------------------
  db_var <- db |>
    dplyr::filter(reference != "Choat et al. 2012") |> # We remove values from Choat et al. 2012 (XFT) to avoid duplicate records
    dplyr::select("species...4", "P50", "reference", "Method used") |>
    dplyr::rename(originalName = "species...4",
                  Value = "P50",
                  OriginalReference = "reference",
                  Method = "Method used") |>
    dplyr::mutate(Trait = "VCstem_P50",
                  Units = "MPa",
                  Level = "population", 
                  Method = dplyr::case_when(
                    Method=="acoustic emission" ~ "AE",
                    Method=="bench dehydration" ~ "DH",
                    Method=="cavitron" ~ "CA",
                    Method=="static centrifuge" ~ "CE",
                    Method=="whole shoot vacuum pressure" ~ NA,
                    TRUE ~ NA
                  )) |>
    dplyr::relocate(Trait, .before = Value) |>
    dplyr::relocate(Method, .after = Units) |>
    dplyr::mutate(Reference = "Lens et al. (2016) Herbaceous angiosperms are not more vulnerable to drought-induced embolism than angiosperm trees. Plant Physiology 172, 661-667",
                  DOI = "10.1104/pp.16.00829",
                  Priority = 1) |>
    dplyr::relocate(OriginalReference, .after = "DOI")|>
    dplyr::arrange(originalName) |>
    tibble::as_tibble()
  db_var$OriginalReference[db_var$OriginalReference=="this study"] <- NA
  traits4models::check_harmonized_trait(db_var)
  
  # Taxonomic harmonization -----------------------------------------------
  db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
    dplyr::mutate(checkVersion = checkVersion)
  
  # Checking ----------------------------------------------------------------
  traits4models::check_harmonized_trait(db_post)
  
  # Storing -----------------------------------------------------------------
  saveRDS(db_post, "data/harmonized_trait_sources/Lens_et_al_2016.rds")
}

