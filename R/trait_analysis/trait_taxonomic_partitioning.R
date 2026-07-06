trait_taxonomic_partitioning<- function(harmonized_trait_path, WFO_file,
                                        trait_name) {
  species_means <- traits4models::taxon_trait_summary(harmonized_trait_path, traits =trait_name,
                                                      summary_function = "weightedmean", verbose = FALSE, progress = FALSE) |>
    dplyr::rename(originalName = acceptedName) |>
    dplyr::filter(!is.na(.data[[trait_name]]), !is.infinite(.data[[trait_name]]))
  species_complete <- traits4models::harmonize_taxonomy_WFO(species_means, WFO_file,
                                                            verbose = FALSE, progress = FALSE)
  
  df <- species_complete[, c(trait_name, "family", "genus")] |>
    dplyr::filter(!is.na(family), !is.na(genus))
  names(df)[1] <- "Value"
  list(n = nrow(df),
       result = rdacca.hp::rdacca.hp(dv = df$Value, iv = df[, c("family", "genus")]))
}
