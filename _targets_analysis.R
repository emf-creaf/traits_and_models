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
  packages = c("rdacca.hp"),
  controller = crew::crew_controller_local(workers = 8)
)


WFO_file <- "./data-raw/wfo_backbone/classification.csv"
DB_path <- "./"
harmonized_trait_path <- paste0(DB_path,"data/harmonized_trait_sources")

tar_source("R/trait_analysis/trait_taxonomic_partitioning.R")

# Replace the target list below with your own:
list(
  ## Trait analysis
  tar_target(
    name = SLA_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "SLA")
  ),
  tar_target(
    name = LeafDensity_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "LeafDensity")
  ),
  tar_target(
    name = WoodDensity_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "WoodDensity")
  ),
  tar_target(
    name = WoodC_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "WoodC")
  ),
  tar_target(
    name = Al2As_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Al2As")
  ),
  tar_target(
    name = Ptlp_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Ptlp")
  ),
  tar_target(
    name = VCstem_P50_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "VCstem_P50")
  ),
  tar_target(
    name = VCleaf_P50_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "VCleaf_P50")
  ),
  tar_target(
    name = LeafPI0_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "LeafPI0")
  ),
  tar_target(
    name = LeafEPS_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "LeafEPS")
  ),
  tar_target(
    name = LeafAF_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "LeafAF")
  ),
  tar_target(
    name = Gswmin_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Gswmin")
  ),
  tar_target(
    name = Gswmax_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Gswmax")
  ),
  tar_target(
    name = Ks_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Ks")
  ),
  tar_target(
    name = Nleaf_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Nleaf")
  ),
  tar_target(
    name = Nsapwood_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Nsapwood")
  ),
  tar_target(
    name = Nfineroot_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Nfineroot")
  ),
  tar_target(
    name = Vmax_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Vmax")
  ),
  tar_target(
    name = Jmax_part,
    command = trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, "Jmax")
  )
)