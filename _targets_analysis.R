# Created by use_targets().
# Follow the comments below to fill in this target script.
# Then follow the manual to check and run the pipeline:
#   https://books.ropensci.org/targets/walkthrough.html#inspect-the-pipeline

# Load packages required to define the pipeline:
library(targets)
library(tarchetypes)
library(tidyr)
library(tibble)

WFO_file <- "./data-raw/wfo_backbone/classification.csv"
DB_path <- "./"
harmonized_trait_path <- paste0(DB_path,"data/harmonized_trait_sources")

# Set target options:
tar_option_set(
  packages = c("rdacca.hp", "ggplot2"),
  controller = crew::crew_controller_local(workers = 8)
)

tar_source("R/trait_analysis/trait_taxonomic_partitioning.R")
tar_source("R/trait_analysis/trait_coordination.R")
tar_source("R/trait_analysis/trait_info.R")


values <- tibble(
  trait = c("SLA", "WoodC", "LeafWidth",
            "LeafDensity", "WoodDensity", "FineRootDensity", "r635",
            "conduit2sapwood", "Al2As", "Ks", "kleaf", "kplant", 
            "SRL",
            "VCstem_P50", "VCleaf_P50", "VCroot_P50",
            "VCstem_P12", "VCleaf_P12", "VCroot_P12",
            "VCstem_P88", "VCleaf_P88", "VCroot_P88",
            "LeafPI0", "LeafEPS", "LeafAF",  "Ptlp",
            "StomatalDensity", "Gswmin", "Gswmax", "Gsw_q99", "Vmax", "Jmax",
            "Nleaf", "Nsapwood", "Nfineroot")
)

trait_info_targets <- tar_map(
  values = values,
  tar_target(name = info, trait_info(harmonized_trait_path, WFO_file, trait))
)

trait_analysis_targets <- tar_map(
  values = values,
  tar_target(name = analysis, trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, trait))
)

combined_info <- tar_combine(
  combined_info_table,
  trait_info_targets[["info"]],
  command =bind_rows_info(!!!.x)
)

combined_partitioning <- tar_combine(
  combined_partitioning_summaries,
  trait_analysis_targets[["analysis"]],
  command = summarize_partitioning(!!!.x)
)

coordination <- tar_target(
  name = trait_coordination_analysis,
  command = trait_coordination(harmonized_trait_path)
)

list(trait_info_targets, 
     combined_info,
     trait_analysis_targets, 
     combined_partitioning,
     coordination
)