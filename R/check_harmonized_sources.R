# Checks whether already harmonized sources have harmonization problems
# This can happen when validation criteria are updated in package "traits4models"
# If detected, the harmonization scripts should be updated to solve problems

harmonized_trait_path <- "data/harmonized_trait_sources"

traits4models::check_harmonized_trait_dir(harmonized_trait_path, verbose = FALSE)
