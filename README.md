
# Traits and models

## Introduction

### About this repository

**Origin**: This repository intends to support the collaborative work
started in a PsiHub workshop held in Avignon (9-11th April 2025).

**Aim**: By drawing knowledge from experts in measuring plant traits,
the repository aims to facilitate the task of estimating functional
parameters in process-based forest models from plant trait data sources.

**Sections**: The repository contains three different sections that can
be useful independently:

- **I. Harmonization of trait data sources**: Bringing species names to
  accepted taxon entities and harmonizing trait definitions and units.
  Later these harmonized sources can be used to fill parameter values
  for a large number of species.
- **II. Trait-trait relationships**: Compiling published relationships
  between traits, to be later used in parameter imputation strategies
  when information is missing.
- **III. Traits and model parameterization assumptions**: This tries to
  bring awareness on the assumptions made by modellers when adopting
  parameter estimation strategies, and whether these assumptions are met
  or not for different plant traits.

### How to contribute to this repository

People interested in contributing with information to any of the three
sections of the repository should adhere to the following protocol:

1.  **Fork** the *emf-creaf/traits_and_models* repository into his/her
    own GitHub account and create a local copy. This should be done only
    once.
2.  **Make changes** on the local copy of the forked repository
    (e.g. adding new scripts for harmonization of a new source or
    modifying repository excel files in `data-raw`).
3.  **Push changes** in the local repository to the forked one.
4.  Create a **pull request** of the forked repository so that
    changes/additions can be integrated to the main repository in
    *emf-creaf/traits_and_models*.
5.  Subsequent work should be preceded by a **re-synchronization** of
    the forked repository, so that changes made by other users are
    available.

### Related package

Package [**traits4models**](https://emf-creaf.github.io/traits4models)
is being developed to assist harmonization. This package should be
installed for the correct use of the scripts in this repository.

Package **trait4models** has also the table `HarmonizedTraitDefinition`,
which contains the definitions and required notation and units for all
traits to be harmonized.

## I. Trait source harmonization

This sections aims to help in the collective effort of gathering and
harmonizing trait data sources.

### I.1 Raw trait data

File *data-raw/trait_data_source_list.xlsx* contains a list of trait
database sources currently considered for harmonization.

Raw trait databases are expected to be located in sub-folders of
*data-raw/raw_trait_data*
(e.g. *data-raw/raw_trait_data/Bartlett_et_al_2016*).

**IMPORTANT NOTE**: Trait sources should not be stored in the GitHub
repository (i.e. *data-raw/raw_trait_data* is listed in the *.gitignore*
file). They are meant to be downloaded from online data repositories
(supplementary material, Zenodo databases, …) and stored locally.

### I.2 Harmonizing scripts

Each script is used to process the harmonization of a different data
set. R scripts are located in a sub-folder of *R/source_harmonization*
(e.g. *R/source_harmonization/Bartlett_et_al_2016.R*).

Any given script should have the following sections:

1)  Read database from *raw-data/raw_trait_data/\[source\]*.
2)  Variable harmonization (notation, units), according to
    `HarmonizedTraitDefinition`.
3)  Taxonomic harmonization, using function
    `traits4models::harmonize_taxonomy_WFO()`.
4)  Checking data base, using function
    `traits4models::check_harmonized_trait()`.
5)  Storing in folder *data/harmonized_trait_sources/\[source\]*.

If a data base contains more than one trait, steps \[1-5\] can be
conducted as shown. Alternatively, steps \[2-5\] can be conducted
repeatedly for different traits. This can be more efficient to avoid
large amounts of missing values when processing large data bases.

### I.3 Harmonized trait data

The output of harmonization should be stored as an *.rds* or *.csv* file
in *data/harmonized_trait_sources*
(e.g. *data/harmonized_trait_sources/Bartlett_et_al_2016.rds*).

**IMPORTANT NOTE**: Harmonized trait data not be stored in the GitHub
repository (i.e. *data-raw/raw_trait_data* is listed in the *.gitignore*
file). They are meant to be stored locally but can be exchanged between
users of the repository by contacting the person who performed the
harmonization.

## II. Trait-trait relationships

This section is meant to provide a compilation of trait-trait
relationships, including their scope (taxonomic, bioclimatic, etc.) of
validity, their statistical support and physiological interpretation.

A data base of trait-trait relationships is stored in file
*data-raw/trait_relationships.xlsx*.

This information should be useful for modellers to devise imputation
strategies for missing data, while taking into account the limitations
of the relationship employed.

## III. Traits and assumptions in parameter estimation

This section tries to raise awareness on the assumptions made by
modellers when adopting parameter estimation strategies, and whether
these assumptions are met or not for different plant traits. It will
contain:

- Definitions of the assumptions most commonly made by modellers (either
  explicitly or implicitly).
- A database of bibliographic sources regarding the empirical evidence
  to support these assumptions. This is stored in file
  *data-raw/trait_hypothesis_support.xlsx*.
