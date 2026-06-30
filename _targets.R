# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(tidyr)

# Set target options:
tar_option_set(
  packages = c("traits4models", "readxl", "dplyr", "cli", "readr", "sf"),
  controller = crew::crew_controller_local(workers = 3)
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source("R/trait_source_harmonization/Alfaro_et_al_2023_RasgosCL.R")
tar_source("R/trait_source_harmonization/Augustine_McCulloh_2024.R")
tar_source("R/trait_source_harmonization/Avila-Lovera_Winter_2024.R")
tar_source("R/trait_source_harmonization/Baez_et_al_2022_FUNANDES.R")
tar_source("R/trait_source_harmonization/De_Caceres_et_al_2019_CR_pDead.R")
tar_source("R/trait_source_harmonization/Vilagrosa_et_al_2014.R")


# Replace the target list below with your own:
list(
  tar_target(
    name = checkVersion,
    command = as.character(packageVersion("traits4models"))
  ),
  tar_target(
    name = Alfaro_et_al_2023,
    command = harmonize_Alfaro_et_al_2023(checkVersion = checkVersion)
  ),
  tar_target(
    name = Augustine_McCulloh_2024,
    command = harmonize_Augustine_McCulloh_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = AvilaLovera_Winter_2024,
    command = harmonize_AvilaLovera_Winter_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Baez_et_al_2022_FUNANDES,
    command = harmonize_Baez_et_al_2022_FUNANDES(checkVersion = checkVersion)
  ),
  tar_target(
    name = DeCaceres_et_al_2019,
    command = harmonize_DeCaceres_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = Vilagrosa_et_al_2014,
    command = harmonize_Vilagrosa_et_al_2024(checkVersion = checkVersion)
  )
)