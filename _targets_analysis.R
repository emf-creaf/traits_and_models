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
  packages = c("rdacca.hp"),
  controller = crew::crew_controller_local(workers = 2)
)

tar_source("R/trait_analysis/trait_taxonomic_partitioning.R")
tar_source("R/trait_analysis/trait_coordination.R")


values <- tibble(
  trait = c("SLA", "WoodC", "LeafWidth",
            "LeafDensity", "WoodDensity", "FineRootDensity", "r635",
            "conduit2sapwood", "Al2As", "Ks", "kleaf", 
            "SRL",
            "VCstem_P50", "VCleaf_P50", "VCroot_P50",
            "LeafPI0", "LeafEPS", "LeafAF",  "Ptlp",
            "StomatalDensity", "Gswmin", "Gswmax", "Vmax", "Jmax",
            "Nleaf", "Nsapwood", "Nfineroot")
)

trait_analysis_targets <- tar_map(
  values = values,
  tar_target(name = analysis, trait_taxonomic_partitioning(harmonized_trait_path, WFO_file, trait))
)
combined <- tar_combine(
  combined_summaries,
  trait_analysis_targets[["analysis"]],
  command = summarize_partitioning(!!!.x)
)

list(trait_analysis_targets, 
     combined,
     tar_target(
       name = trait_coordination_analysis,
       command = trait_coordination(harmonized_trait_path)
     ))