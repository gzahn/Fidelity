# Fidelity

<img src="https://github.com/gzahn/Fidelity/blob/main/assets/sticker.png" alt="hex_sticker" width="200"/>

(Replace with better hex sticker...)

The goal of Fidelity is to provide a user-friendly tool to quantify and compare the host specificity of microbial communities. 
Our method is a three step analysis that integrates the Indicator Species Analysis (ISA) with a Community Weighted Mean (CWM) analysis. 
First, a specificity value is assigned to each taxon through the ISA. Second, a threshold is established for removing rare taxa. 
Third, community level indices are generated through a CWM analysis using all taxa that meet the rare taxa threshold. 
The resulting indices can be used to compare the specificity of microbial communities associated with certain hosts or groups (i.e. treatments, environments) in a data set.


## Installation:

```
if (!requireNamespace("devtools", quietly = TRUE))
    install.packages("devtools")
    
devtools::install_github("gzahn/Fidelity")
```

## Requirements

Depends on:

- tidyverse >= 2.0.0
- future >= 1.33.2
- future.apply >= 1.11.2

## Citation

[![DOI](https://zenodo.org/badge/1016289767.svg)](https://doi.org/10.5281/zenodo.16095120)

Zahn, G., & Neat, A. (2025). gzahn/Fidelity: Beta release (Version 0.0.0) [Computer software]. Zenodo. https://doi.org/10.5281/ZENODO.16095121



## Example usage

For a thorough walkthrough, see the [Tutorial](https://rpubs.com/neata/1337966)


```
# load Fidelity
library(Fidelity)

# LOAD DATA ####
otu <- readRDS("./data/soils_otu_low_24.rds")
groups <- readRDS("./data/soils_env_low_24.rds") %>% pluck("species")
ps <- readRDS("./data/example_physeq.RDS")

# USE FUNCTION ####
out <- Fidelity(comm = otu,
                groups = groups,
                seed = 123,
                n.perm = 99,
                pval.cutoff = 0.05,
                max.ratio = 0,
                ovp.plot = TRUE,
<<<<<<< HEAD
                rm.rare.taxa = TRUE,
=======
                rm.rare.taxa = FALSE,
>>>>>>> 3f3f30b05c96b4b3d53b9a4d1017ee63f6828b78
                allow.pa = FALSE)

# EXAMINE OUTPUT ####
out$community_specificity_index
out$taxon_specificity_index
out$isa_results
out$process_summary
out$removed_taxa


# USE FUNCTION COMPATIBLE WITH PHYLOSEQ OBJECTS####
out_ps <- Fidelity_physeq(physeq,
                groups,
                seed = 123,
                n.perm = 999,
                pval.cutoff = 0.05,
                max.ratio = 0,
                ovp.plot = TRUE,
                rm.rare.taxa = TRUE,
                allow.pa = FALSE)

# EXAMINE OUTPUT ####
out_ps$community_specificity_index
out_ps$taxon_specificity_index
out_ps$isa_results
out_ps$process_summary
out_ps$removed_taxa


```

## Detailed description of methods

<img src="https://github.com/gzahn/Fidelity/blob/main/assets/methods_poster.png" width="200"/>
