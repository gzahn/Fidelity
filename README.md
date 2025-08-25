# specifiR

<img src="https://github.com/gzahn/specifiR/blob/main/assets/sticker.png" alt="hex_sticker" width="200"/>

(Replace with better hex sticker...)

The goal of SpecifiR is to provide a user-friendly tool to quantify and compare the host specificity of microbial communities. 
Our method is a three step analysis that integrates the Indicator Species Analysis (ISA) with a Community Weighted Mean (CWM) analysis. 
First, a specificity value is assigned to each taxon through the ISA. Second, a threshold is established for removing rare taxa. 
Third, community level indices are generated through a CWM analysis using all taxa that meet the rare taxa threshold. 
The resulting indices can be used to compare the specificity of microbial communities associated with certain hosts or groups (i.e. treatments, environments) in a data set.


## Installation:

```
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
    
devtools::install_github("gzahn/specifiR")
```

## Requirements

Depends on:

- tidyverse >= 2.0.0
- future >= 1.33.2
- future.apply >= 1.11.2

## Citation

[![DOI](https://zenodo.org/badge/1016289767.svg)](https://doi.org/10.5281/zenodo.16095120)

Zahn, G., & Neat, A. (2025). gzahn/specifiR: Beta release (Version 0.0.0) [Computer software]. Zenodo. https://doi.org/10.5281/ZENODO.16095121



## Example usage
```
# load specifiR
library(specifiR)

# LOAD DATA ####
otu <- readRDS("./data/soils_otu_low_24.rds")
groups <- readRDS("./data/soils_env_low_24.rds") %>% pluck("species")
ps <- readRDS("./data/example_physeq.RDS")

# USE FUNCTION ####
out <- specifiR(comm = otu,
                groups = groups,
                seed = 123,
                n.perm = 999,
                pval.cutoff = 0.05,
                max.ratio = 0,
                ovp.plot = TRUE,
                rm.rare.taxa = TRUE)

# EXAMINE OUTPUT ####
out$community_specificity_index
out$taxon_specificity_index
out$isa_results
out$process_summary
out$removed_taxa

```

## Detailed description of methods

<img src="https://github.com/gzahn/specifiR/blob/main/assets/methods_poster.png" width="200"/>
