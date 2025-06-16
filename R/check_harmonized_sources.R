# Checks whether already harmonized sources have harmonization problems
# This can happen when validation criteria are updated in package "traits4models"
# If detected, the harmonization scripts should be updated to solve problems

files <- list.files("data/harmonized_trait_sources", full.names = TRUE)

for(f in files) {
  cli::cli_li(f)
  traits4models::check_harmonized_trait(readRDS(f))
}
