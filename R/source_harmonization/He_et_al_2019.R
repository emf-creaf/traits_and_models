#
# He et al. (2019)
#

DB_path <- "./"
WFO_file <- paste0(DB_path, "data-raw/wfo_backbone/classification.csv")

# Read database -----------------------------------------------------------
trait_data <- readr::read_table("data-raw/raw_trait_data/He_et_al_2019/trait_data.txt") |>
  dplyr::select(-Species)
species_data <- readr::read_table("data-raw/raw_trait_data/He_et_al_2019/species_data.txt")
db <- species_data |>
  dplyr::select(Species, name, Light) |>
  dplyr::bind_cols(trait_data) |>
  dplyr::mutate(Species = paste(Species, name)) |>
  dplyr::select(-name)
# Variable harmonization --------------------------------------------------
db_var <- db |>
  dplyr::select("Species", "Light", "LLS", "LMA", "Nmass", "LDMC", "LD") |>
  dplyr::rename(originalName = "Species",
                ShadeToleranceType = "Light",
                LeafDuration = "LLS",
                LeafDensity = "LD",
                Nleaf = "Nmass")|>
  dplyr::mutate(ShadeToleranceType = tolower(ShadeToleranceType),
                SLA = 1000/as.numeric(LMA), # From g m-2 to m2 kg-1
                LeafDuration = as.numeric(LeafDuration)/56, #From weeks to year
                Nleaf = Nleaf, # mg g-1
                LeafDensity = LeafDensity, # g cm-3
                LDMC = LDMC/10) |> # % (100*g g-1) to mg g-1
  dplyr::select(-LMA) |>
  dplyr::mutate(Reference = "He et al. (2019) Leaf mechanical strength and photosynthetic capacity vary independently across 57 subtropical forest species with contrasting light requirements. New Phytologist 223: 607–618",
                DOI = "10.1111/nph.15803",
                Priority = 1) |>
  dplyr::arrange(originalName)

# Taxonomic harmonization -----------------------------------------------
db_post <- traits4models::harmonize_taxonomy_WFO(db_var, WFO_file) |>
  dplyr::mutate(checkVersion = as.character(packageVersion("traits4models")))

# Checking ----------------------------------------------------------------
traits4models::check_harmonized_trait(db_post)

# Storing -----------------------------------------------------------------
saveRDS(db_post, "data/harmonized_trait_sources/He_et_al_2019.rds")
