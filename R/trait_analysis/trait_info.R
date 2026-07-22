trait_info<- function(harmonized_trait_path, WFO_file,
                                        trait_name) {
  if(trait_name=="Gsw_q99") {
    species_means <- traits4models::taxon_trait_summary(harmonized_trait_path, traits ="Gsw",
                                                        summary_function = "n", verbose = FALSE, progress = FALSE) |>
      dplyr::rename(originalName = acceptedName) |>
      dplyr::filter(!is.na(.data[["Gsw"]]), !is.infinite(.data[["Gsw"]])) |>
      dplyr::mutate(Trait = trait_name)
  } else {
    species_means <- traits4models::taxon_trait_summary(harmonized_trait_path, traits =trait_name,
                                                        summary_function = "n", verbose = FALSE, progress = FALSE) |>
      dplyr::rename(originalName = acceptedName) |>
      dplyr::filter(!is.na(.data[[trait_name]]), !is.infinite(.data[[trait_name]])) |>
      dplyr::mutate(Trait = trait_name)
  }
  names(species_means)[2] <- "n_records"
  
  species_cat <- traits4models::taxon_trait_summary(harmonized_trait_path, traits = c("LifeForm", "GrowthForm", "LeafSize", "LeafShape", "PhenologyType", "PhotosyntheticPathway", "WoodPorosityType"),
                                                    taxon_selection = species_means$originalName,
                                                    summary_function = "mode", verbose = FALSE, progress = FALSE)|>
    dplyr::rename(originalName = acceptedName)
  
  species_means <- species_means |>
    dplyr::left_join(species_cat, by="originalName")
  
  species_complete <- traits4models::harmonize_taxonomy_WFO(species_means, WFO_file,
                                                            verbose = FALSE, progress = FALSE)
  
  species_complete <- species_complete |>
    dplyr::left_join(traits4models:::fam_data, by = c("family"="Family"))
  
  return(species_complete)
}

bind_rows_info <-function(...) {
  df <- dplyr::bind_rows(...)
  saveRDS(df, "data/trait_info.rds")
  return(df)
}