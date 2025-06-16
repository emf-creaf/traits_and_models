# Checks whether already harmonized sources have harmonization problems
# If detected, the harmonization scripts should be updated

files <- list.files("data/harmonized_trait_sources", full.names = TRUE)

for(f in files) {
  cli::cli_li(f)
  traits4models::check_harmonized_trait(readRDS(f))
}
