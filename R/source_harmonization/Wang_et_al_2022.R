#
# Wang et al. (2022) - CPTD 2
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
chem <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2022_CPTD/CPTD/Chemical traits.csv"))
photo <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2022_CPTD/CPTD/Photosynthetic traits.csv"))
morpho <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2022_CPTD/CPTD/Morphometric traits.csv"))
hydra <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2022_CPTD/CPTD/Hydraulic Trait.csv"))

# Variable harmonization --------------------------------------------------
chem_var <- chem |>
  dplyr::select("SAMPLE ID", SLA, LDMC, Nmass) |>
  dplyr::rename(Nleaf = Nmass) |>
  dplyr::filter(!(is.na(SLA) | is.na(LDMC) | is.na(Nleaf)))
photo_var <- photo |>
  dplyr::select("SAMPLE ID", Vcmax, Jmax) |>
  dplyr::rename(Vmax = Vcmax) |>
  dplyr::filter(!(is.na(Vmax) | is.na(Jmax)))
morpho_var <- morpho |>
  dplyr::select("SAMPLE ID", `Leaf size`, `Leaf shape`) |>
  dplyr::rename(LeafSize = `Leaf size`,
                LeafShape = `Leaf shape`) |>
  dplyr::filter(!(is.na(LeafSize) | is.na(LeafShape)))|>
  dplyr::mutate(
    LeafShape = dplyr::case_when(
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(cordate|cordate-lanceolate|broad)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(deltoid|elliptic|elliptic-lanceolate|lanceolate|oval)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(orbicular|oblanceolate|oblong|obovate|ovate-lanceolate|ovate|obcordate)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(falcate|fishtail|hastate|orbicular|ovate-bipinnate|palmate)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(palmatifid|pinnatifid|quinquelobate|runcinate|sagittate|septemlobate)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(rhomboid|spatulate|trilobate|tulip-shaped)")) ~ "Broad",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(linear-lanceolate|linear)")) ~ "Linear",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(acicular|needle)")) ~ "Needle",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(triangular)")) ~ "Scale",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(spines)")) ~ "Spines",
      stringr::str_detect(tolower(LeafShape), stringr::regex("(?i)(succulent)")) ~ "Succulent"
    )
  )
hydra_var <- hydra |>
  dplyr::select("SAMPLE ID", `vH`, `Ks`, WD, Ptlp) |>
  dplyr::rename(WoodDensity = WD) |>
  dplyr::mutate(Al2As = 1/vH) |>
  dplyr::select(-vH)

db_var <- chem_var |>
  dplyr::full_join(photo_var, by="SAMPLE ID")|>
  dplyr::full_join(morpho_var, by="SAMPLE ID")|>
  dplyr::full_join(hydra_var, by="SAMPLE ID")

db_var$Reference <- "Wang et al. 2022"
db_var$Priority <- 3

# Taxonomic harmonization -----------------------------------------------
species <- readr::read_csv(paste0(DB_path,"data-raw/raw_trait_data/Wang_et_al_2022_CPTD/CPTD/Species translations.csv"))
species_2 <- species |>
  dplyr::rename(oriGenus = `Field-identified Genus`) |>
  dplyr::rename(oriSpecies = `Field-identified Species`)
species_2$oriSpecies[species_2$oriSpecies=="sp"] =""
species_2$oriSpecies[species_2$oriSpecies=="sp."] =""
species_2 <- species_2 |>
  dplyr::mutate(originalName = paste0(oriGenus, " ",oriSpecies)) |>
  dplyr::select(originalName, `SAMPLE ID`) |>
  dplyr::filter(!startsWith(originalName, "Unidendified"))|>
  dplyr::filter(!(originalName %in% c("Unknown fern NA", "Unknown grass NA", "unknown")))|>
  dplyr::arrange(originalName) |>
  tibble::as_tibble()

db_var2 <- species_2 |> 
  dplyr::right_join(db_var, by=c("SAMPLE ID")) |>
  dplyr::select(-c("SAMPLE ID"))

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var2, WFO_file)

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/Wang_et_al_2022_CPTD.rds")
