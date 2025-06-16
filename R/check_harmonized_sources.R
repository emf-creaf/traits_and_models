# Checks whether already harmonized sources have harmonization problems
# This can happen when validation criteria are updated in package "traits4models"
# If detected, the harmonization scripts should be updated to solve problems

files <- list.files("data/harmonized_trait_sources", full.names = TRUE)

accepted <- rep(NA, length(files))
for(i in 1:length(files)) {
  f <- files[i]
  cli::cli_li(f)
  accepted[i] <- traits4models::check_harmonized_trait(readRDS(f))
}
cli::cli_li(paste0(sum(!accepted), " files are not acceptable"))
print(files[!accepted])
