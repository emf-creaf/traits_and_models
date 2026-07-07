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
  list(trait = trait_name,
       n = nrow(df),
       result = rdacca.hp::rdacca.hp(dv = df$Value, iv = df[, c("family", "genus")]))
}

summarize_partitioning <-function(...) {
  args <- list(...)
  n_t <- length(args)
  df <- data.frame(trait = rep(as.character(NA), n_t), 
                   n = rep(NA, n_t), 
                   family = rep(NA, n_t), 
                   genus = rep(NA, n_t), 
                   total = rep(NA, n_t))
  for(i in 1:n_t) {
    df[i,"trait"] = args[[i]]$trait
    df[i,"n"] = args[[i]]$n
    df[i,"family"] = args[[i]]$result$Hier.part[1,3]
    df[i,"genus"] = args[[i]]$result$Hier.part[2,3]
    df[i, "total"] = args[[i]]$result$Total_explained_variation
  }
  return(df)
}