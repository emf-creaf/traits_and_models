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
  packages = c("traits4models", "openxlsx", "readxl", "dplyr", "cli", "readr", "sf"),
  controller = crew::crew_controller_local(workers = 8)
)

# Smaller data sets
tar_source("R/trait_source_harmonization/00_Compilation_FineFuelRatio.R")
tar_source("R/trait_source_harmonization/00_Compilation_Flammability.R")
tar_source("R/trait_source_harmonization/00_Compilation_ConstructionCosts.R")
tar_source("R/trait_source_harmonization/00_Compilation_Phenology.R")
tar_source("R/trait_source_harmonization/Augustine_McCulloh_2024.R")
tar_source("R/trait_source_harmonization/Avila-Lovera_Winter_2024.R")
tar_source("R/trait_source_harmonization/Balaguer_Romano_et_al_2026.R")
tar_source("R/trait_source_harmonization/Bartlett_et_al_2012.R")
tar_source("R/trait_source_harmonization/Bartlett_et_al_2016.R")
tar_source("R/trait_source_harmonization/Chianucci_et_al_2018.R")
tar_source("R/trait_source_harmonization/Copie_et_al_2025.R")
tar_source("R/trait_source_harmonization/De_Caceres_et_al_2019_CR_pDead.R")
tar_source("R/trait_source_harmonization/Duursma_et_al_2018.R")
tar_source("R/trait_source_harmonization/Eisley&Wolfe_2024.R")
tar_source("R/trait_source_harmonization/Guillemot_et_al_2022.R")
tar_source("R/trait_source_harmonization/He_et_al_2019.R")
tar_source("R/trait_source_harmonization/Henry_et_al_2019.R")
tar_source("R/trait_source_harmonization/Hoshika_et_al_2018.R")
tar_source("R/trait_source_harmonization/Huang_et_al_2024.R")
tar_source("R/trait_source_harmonization/Huang_et_al_2026.R")
tar_source("R/trait_source_harmonization/Journe_et_al_2024.R")
tar_source("R/trait_source_harmonization/Klein_et_al_2014.R")
tar_source("R/trait_source_harmonization/Krober_et_al_2014.R")
tar_source("R/trait_source_harmonization/Kunert_Tomaskova_2020.R")
tar_source("R/trait_source_harmonization/Larter_et_al_2026.R")
tar_source("R/trait_source_harmonization/Lens_et_al_2016.R")
tar_source("R/trait_source_harmonization/Levionnois_et_al_2020.R")
tar_source("R/trait_source_harmonization/Levionnois_et_al_2021a.R")
tar_source("R/trait_source_harmonization/Levionnois_et_al_2021b.R")
tar_source("R/trait_source_harmonization/Lin_et_al_2015.R")
tar_source("R/trait_source_harmonization/Liu_et_al_2019.R")
tar_source("R/trait_source_harmonization/Loram-Lourenco_et_al_2022.R")
tar_source("R/trait_source_harmonization/MartinStPaul_et_al_2017.R")
tar_source("R/trait_source_harmonization/Morris_et_al_2016.R")
tar_source("R/trait_source_harmonization/Nadal_et_al_2023.R")
tar_source("R/trait_source_harmonization/Ochoa_et_al_2024.R")
tar_source("R/trait_source_harmonization/Pan_et_al_2026.R")
tar_source("R/trait_source_harmonization/Peters_et_al_2020.R")
tar_source("R/trait_source_harmonization/Petruzzellis_et_al_2021.R")
tar_source("R/trait_source_harmonization/Pisek_Adamson_2020.R")
tar_source("R/trait_source_harmonization/Ramirez_Valiente_et_al_2020.R")
tar_source("R/trait_source_harmonization/Rimer&McAdam_2024.R")
tar_source("R/trait_source_harmonization/Rimer&McAdam_2025.R")
tar_source("R/trait_source_harmonization/Sjöman_et_al_2015.R")
tar_source("R/trait_source_harmonization/Sjöman_et_al_2018.R")
tar_source("R/trait_source_harmonization/Tavares_et_al_2023.R")
tar_source("R/trait_source_harmonization/Tavares_et_al_2026.R")
tar_source("R/trait_source_harmonization/Trueba_et_al_2026.R")
tar_source("R/trait_source_harmonization/Vilagrosa_et_al_2014.R")
tar_source("R/trait_source_harmonization/Wang_et_al_2024.R")
tar_source("R/trait_source_harmonization/Wittemann_et_al_2020.R")
tar_source("R/trait_source_harmonization/Wolfe_et_al_2023.R")
tar_source("R/trait_source_harmonization/Yan_et_al_2020.R")
tar_source("R/trait_source_harmonization/Zhao_et_al_2026.R")
tar_source("R/trait_source_harmonization/Zhu_et_al_2016.R")
tar_source("R/trait_source_harmonization/Zhu_et_al_2018.R")
tar_source("R/trait_source_harmonization/Ziegler_et_al_2019.R")
tar_source("R/trait_source_harmonization/Ziegler_et_al_2024.R")


# Larger data sets (to be run in a server)
tar_source("R/trait_source_harmonization/Alfaro_et_al_2023_RasgosCL.R")
tar_source("R/trait_source_harmonization/Baez_et_al_2022_FUNANDES.R")
tar_source("R/trait_source_harmonization/Bjorkman_et_al_2018_TTT.R")
tar_source("R/trait_source_harmonization/Falster_et_al_2021_AUSTRAITS.R")
tar_source("R/trait_source_harmonization/Diaz_et_al_2022.R")
tar_source("R/trait_source_harmonization/Guerrero_Ramirez_et_al_2021_GRooT.R")
tar_source("R/trait_source_harmonization/Kattge_et_al_2020_TRY_numeric.R")
tar_source("R/trait_source_harmonization/Kattge_et_al_2020_TRY_categorical.R")
tar_source("R/trait_source_harmonization/Ocampo_Zuleta_Pausas_Paula_2023_FLAMITS.R")
tar_source("R/trait_source_harmonization/Tavsanoglu_Pausas_2018_BROT2.R")
tar_source("R/trait_source_harmonization/TumberDavila_et_al_2022.R")
tar_source("R/trait_source_harmonization/Wang_et_al_2022_CPTD2.R")
tar_source("R/trait_source_harmonization/Wang_et_al_2025_CSTD.R")
tar_source("R/trait_source_harmonization/XFT_processing.R")
tar_source("R/trait_source_harmonization/Yebra_et_al_2024_GlobeLFMC.R")

# Allometric datasets
tar_source("R/allometry_source_harmonization/TreeBarkThicknessAllometries_AllometrApp.R")
tar_source("R/allometry_source_harmonization/TreeCrownRatioAllometries.R")
tar_source("R/allometry_source_harmonization/TreeCrownWidthAllometries.R")
tar_source("R/allometry_source_harmonization/TreeFoliarAllometries_AllometrApp.R")
tar_source("R/allometry_source_harmonization/TreeFoliarAllometries_CalvoAlvarado_et_al_2008.R")
tar_source("R/allometry_source_harmonization/TreeFoliarAllometries_Eslamdoust_et_al_2017.R")
tar_source("R/allometry_source_harmonization/TreeFoliarAllometries_Thom_et_al_2024.R")
tar_source("R/allometry_source_harmonization/ShrubCrownAreaAllometries_AllometrApp.R")
tar_source("R/allometry_source_harmonization/ShrubFineFuelBiomassAllometries_AllometrApp.R")
tar_source("R/allometry_source_harmonization/ShrubTotalBiomassAllometries_AllometrApp.R")

# Replace the target list below with your own:
list(
  tar_target(
    name = checkVersion,
    command = as.character(packageVersion("traits4models"))
  ),
  
  #
  # Smaller data sets
  #
  tar_target(
    name = Compilation_FineFuelRatio,
    command = harmonize_00_Compilation_FineFuelRatio(checkVersion = checkVersion)
  ),
  tar_target(
    name = Compilation_Flammability,
    command = harmonize_00_Compilation_Flammability(checkVersion = checkVersion)
  ),
  tar_target(
    name = Compilation_Phenology,
    command = harmonize_00_Compilation_Phenology(checkVersion = checkVersion)
  ),
  tar_target(
    name = Compilation_ConstructionCosts,
    command = harmonize_00_Compilation_ConstructionCosts(checkVersion = checkVersion)
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
    name = Duursma_et_al_2018,
    command = harmonize_Duursma_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Eisley_Wolfe_2024,
    command = harmonize_Eisley_Wolfe_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Guillemot_et_al_2022,
    command = harmonize_Guillemot_et_al_2022(checkVersion = checkVersion)
  ),
  tar_target(
    name = He_et_al_2019,
    command = harmonize_He_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = Henry_et_al_2019,
    command = harmonize_Henry_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = Hoshika_et_al_2018,
    command = harmonize_Hoshika_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Huang_et_al_2024,
    command = harmonize_Huang_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Huang_et_al_2026,
    command = harmonize_Huang_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Journe_et_al_2024,
    command = harmonize_Journe_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Klein_et_al_2014,
    command = harmonize_Klein_et_al_2014(checkVersion = checkVersion)
  ),
  tar_target(
    name = Krober_et_al_2014,
    command = harmonize_Krober_et_al_2014(checkVersion = checkVersion)
  ),
  tar_target(
    name = Kunert_Tomaskova_2020,
    command = harmonize_Kunert_Tomaskova_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Larter_et_al_2026,
    command = harmonize_Larter_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Lens_et_al_2016,
    command = harmonize_Lens_et_al_2016(checkVersion = checkVersion)
  ),
  tar_target(
    name = Levionnois_et_al_2020,
    command = harmonize_Levionnois_et_al_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Levionnois_et_al_2021a,
    command = harmonize_Levionnois_et_al_2021a(checkVersion = checkVersion)
  ),
  tar_target(
    name = Levionnois_et_al_2021b,
    command = harmonize_Levionnois_et_al_2021b(checkVersion = checkVersion)
  ),
  tar_target(
    name = Lin_et_al_2015,
    command = harmonize_Lin_et_al_2015(checkVersion = checkVersion)
  ),
  tar_target(
    name = Liu_et_al_2019,
    command = harmonize_Liu_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = LoramLourenco_et_al_2022,
    command = harmonize_LoramLourenco_et_al_2022(checkVersion = checkVersion)
  ),
  tar_target(
    name = MartinStPaul_et_al_2017,
    command = harmonize_MartinStPaul_et_al_2017(checkVersion = checkVersion)
  ),
  tar_target(
    name = Morris_et_al_2016,
    command = harmonize_Morris_et_al_2016(checkVersion = checkVersion)
  ),
  tar_target(
    name = Nadal_et_al_2023,
    command = harmonize_Nadal_et_al_2023(checkVersion = checkVersion)
  ),
  tar_target(
    name = Ochoa_et_al_2024,
    command = harmonize_Ochoa_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Pan_et_al_2026,
    command = harmonize_Pan_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Peters_et_al_2020,
    command = harmonize_Peters_et_al_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Petruzzelis_et_al_2021,
    command = harmonize_Petruzzelis_et_al_2021(checkVersion = checkVersion)
  ),
  tar_target(
    name = Pisek_Adamson_2020,
    command = harmonize_Pisek_Adamson_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = RamirezValiente_et_al_2020,
    command = harmonize_RamirezValiente_et_al_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Rimer_McAdam_2024,
    command = harmonize_Rimer_McAdam_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Rimer_McAdam_2025,
    command = harmonize_Rimer_McAdam_2025(checkVersion = checkVersion)
  ),
  tar_target(
    name = Sjoman_et_al_2015,
    command = harmonize_Sjoman_et_al_2015(checkVersion = checkVersion)
  ),
  tar_target(
    name = Sjoman_et_al_2018,
    command = harmonize_Sjoman_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Tavares_et_al_2023,
    command = harmonize_Tavares_et_al_2023(checkVersion = checkVersion)
  ),
  tar_target(
    name = Tavares_et_al_2026,
    command = harmonize_Tavares_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Trueba_et_al_2026,
    command = harmonize_Trueba_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Vilagrosa_et_al_2014,
    command = harmonize_Vilagrosa_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Wang_et_al_2024,
    command = harmonize_Wang_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = Wittemann_et_al_2020,
    command = harmonize_Wittemann_et_al_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Wolfe_et_al_2023,
    command = harmonize_Wolfe_et_al_2023(checkVersion = checkVersion)
  ),
  tar_target(
    name = Yan_et_al_2020,
    command = harmonize_Yan_et_al_2020(checkVersion = checkVersion)
  ),
  tar_target(
    name = Zhao_et_al_2026,
    command = harmonize_Zhao_et_al_2026(checkVersion = checkVersion)
  ),
  tar_target(
    name = Zhu_et_al_2016,
    command = harmonize_Zhu_et_al_2016(checkVersion = checkVersion)
  ),
  tar_target(
    name = Zhu_et_al_2018,
    command = harmonize_Zhu_et_al_2018(checkVersion = checkVersion)
  ),
  tar_target(
    name = Ziegler_et_al_2019,
    command = harmonize_Ziegler_et_al_2019(checkVersion = checkVersion)
  ),
  tar_target(
    name = Ziegler_et_al_2024,
    command = harmonize_Ziegler_et_al_2024(checkVersion = checkVersion)
  ),
  
  #
  # Larger data sets (to be run in a server)
  #
  tar_target(
    name = Baez_et_al_2022_FUNANDES,
    command = harmonize_Baez_et_al_2022_FUNANDES(checkVersion = checkVersion)
  ),
  tar_target(
    name = Bjorkman_et_al_2018_TTT,
    command = harmonize_Bjorkman_et_al_2018_TTT(checkVersion = checkVersion)
  ),
  tar_target(
    name = Choat_et_al_2012_XFT,
    command = harmonize_Choat_et_al_2012_XFT(checkVersion = checkVersion)
  ),
  tar_target(
    name = Diaz_et_al_2022,
    command = harmonize_Diaz_et_al_2022(checkVersion = checkVersion)
  ),
  tar_target(
    name = Falster_et_al_2021_AUSTRAITS,
    command = harmonize_Falster_et_al_2021_AUSTRAITS(checkVersion = checkVersion)
  ),
  tar_target(
    name = GuerreroRamirez_et_al_2021,
    command = harmonize_GuerreroRamirez_et_al_2021(checkVersion = checkVersion)
  ),
  tar_target(
    name = Kattge_et_al_2020_TRY_numeric,
    command = harmonize_Kattge_et_al_2020_TRY_numeric(checkVersion = checkVersion)
  ),
  tar_target(
    name = Kattge_et_al_2020_TRY_categorical,
    command = harmonize_Kattge_et_al_2020_TRY_categorical(checkVersion = checkVersion)
  ),
  tar_target(
    name = OcampoZuleta_et_al_2023_FLAMITS,
    command = harmonize_OcampoZuleta_et_al_2023_FLAMITS(checkVersion = checkVersion)
  ),
  tar_target(
    name = Tavsanoglu_Pausas_2018_BROT,
    command = harmonize_Tavsanoglu_Pausas_2018_BROT(checkVersion = checkVersion)
  ),
  tar_target(
    name = TumberDavila_et_al_2022,
    command = harmonize_TumberDavila_et_al_2022(checkVersion = checkVersion)
  ),
  tar_target(
    name = Wang_et_al_2022_CPTD2,
    command = harmonize_Wang_et_al_2022_CPTD2(checkVersion = checkVersion)
  ),
  tar_target(
    name = Wang_et_al_2025_CSTD,
    command = harmonize_Wang_et_al_2025_CSTD(checkVersion = checkVersion)
  ),
  tar_target(
    name = Yebra_et_al_2024_GlobeLFMC,
    command = harmonize_Yebra_et_al_2024_GlobeLFMC(checkVersion = checkVersion)
  ),
  
  ## Allometric datasets
  tar_target(
    name = TreeBarkThicknessAllometries_AllometrApp,
    command = harmonize_TreeBarkThicknessAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeCrownRatioAllometries_AllometrApp,
    command = harmonize_TreeCrownRatioAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeCrownWidthAllometries_AllometrApp,
    command = harmonize_TreeCrownWidthAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeFoliarAllometries_AllometrApp,
    command = harmonize_TreeFoliarAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeFoliarAllometries_CalvoAlvarado_et_al_2008,
    command = harmonize_TreeFoliarAllometries_CalvoAlvarado_et_al_2008(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeFoliarAllometries_Eslamdoust_et_al_2017,
    command = harmonize_TreeFoliarAllometries_Eslamdoust_et_al_2017(checkVersion = checkVersion)
  ),
  tar_target(
    name = TreeFoliarAllometries_Thom_et_al_2024,
    command = harmonize_TreeFoliarAllometries_Thom_et_al_2024(checkVersion = checkVersion)
  ),
  tar_target(
    name = ShrubCrownAreaAllometries_AllometrApp,
    command = harmonize_ShrubCrownAreaAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = ShrubFineFuelBiomassAllometries_AllometrApp,
    command = harmonize_ShrubFineFuelBiomassAllometries_AllometrApp(checkVersion = checkVersion)
  ),
  tar_target(
    name = ShrubTotalBiomassAllometries_AllometrApp,
    command = harmonize_ShrubTotalBiomassAllometries_AllometrApp(checkVersion = checkVersion)
  )
)