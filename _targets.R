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
  controller = crew::crew_controller_local(workers = 2)
)

# Run the R scripts in the R/ folder with your custom functions:
tar_source("R/trait_source_harmonization/Alfaro_et_al_2023_RasgosCL.R")
tar_source("R/trait_source_harmonization/Augustine_McCulloh_2024.R")
tar_source("R/trait_source_harmonization/Avila-Lovera_Winter_2024.R")
tar_source("R/trait_source_harmonization/Baez_et_al_2022_FUNANDES.R")
tar_source("R/trait_source_harmonization/Balaguer_Romano_et_al_2026.R")
tar_source("R/trait_source_harmonization/Bartlett_et_al_2012.R")
tar_source("R/trait_source_harmonization/Bartlett_et_al_2016.R")
tar_source("R/trait_source_harmonization/Bjorkman_et_al_2018_TTT.R")
tar_source("R/trait_source_harmonization/Chianucci_et_al_2018.R")
tar_source("R/trait_source_harmonization/Copie_et_al_2025.R")
tar_source("R/trait_source_harmonization/De_Caceres_et_al_2019_CR_pDead.R")
tar_source("R/trait_source_harmonization/Diaz_et_al_2022.R")
tar_source("R/trait_source_harmonization/Duursma_et_al_2018.R")
tar_source("R/trait_source_harmonization/Eisley&Wolfe_2024.R")
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
    name = BalaguerRomano_et_al_2026,
    command = harmonize_BalaguerRomano_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Bartlett_et_al_2012,
    command = harmonize_Bartlett_et_al_2012(checkVersion = checkVersion)
  ),
  tar_target(
    name = Bartlett_et_al_2016,
    command = harmonize_Bartlett_et_al_2016(checkVersion = checkVersion)
  ),
  tar_target(
    name = Bjorkman_et_al_2018_TTT,
    command = harmonize_Bjorkman_et_al_2018_TTT(checkVersion = checkVersion)
  ),
  tar_target(
    name = Chianucci_et_al_2018,
    command = harmonize_Chianucci_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Copie_et_al_2025,
    command = harmonize_Copie_et_al_2025(checkVersion = checkVersion)
  ),
  tar_target(
    name = DeCaceres_et_al_2019,
    command = harmonize_DeCaceres_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = Diaz_et_al_2022,
    command = harmonize_Diaz_et_al_2022(checkVersion = checkVersion)
  ),
  tar_target(
    name = Duursma_et_al_2018,
    command = harmonize_Duursma_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Eisley_Wolfe_2024,
    command = harmonize_Eisley_Wolfe_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Vilagrosa_et_al_2014,
    command = harmonize_Vilagrosa_et_al_2024(checkVersion = checkVersion)
  )
)