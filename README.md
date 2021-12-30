# Praznik: High performance information-based feature selection — computational experiments

This repository contains the code used to generate figures and table in the paper [*Praznik: High performance information-based feature selection*](https://doi.org/10.1016/j.softx.2021.100819) by [Miron B. Kursa](https://orcid.org/0000-0001-7672-648X), presenting the R package [praznik](https://cran.r-project.org/package=praznik).

## Contents

Figure 1, scalability of the JMI method selecting 50 features from the Dorothea data, can be reproduced with `figure-1-jmi.R` file.
By default, it will use the cached results from `bench_jmi.RDS` file; use `bench-jmi.R` to re-run the benchmark.
Machine with at least 96 cores is needed.

Figure 2, comparison between I(X_i;Y) and I(X_i;Y|X_Rel7) calculated on the MadelonD data, can be reproduced with `figure-2-mi-cmi.R` file.

Figure 3, graphs corresponding to pairwise matrices of various information scores calculated on the Iris data, can be reproduced with `figure-3-graphs.R` file.
This script requires the [graphviz](https://graphviz.org/) package and produces each sub-figure as a separate PDF.

Table 1, speed comparison between praznik, [infotheo](https://cran.r-project.org/package=infotheo) and [FSelectorRcpp](https://cran.r-project.org/package=FSelectorRcpp) packages, can be reproduced with `table-1-speed-benchmark.R` file.

Table 2, comparison between selection from various methods on MadelonD data, can be reproduced with `table-2-selections.R` file.

## Datasets

The repository contains the `dorothea.RDS` file with the [*DOROTHEA* dataset](https://archive.ics.uci.edu/ml/datasets/Dorothea) from the NIPS 2003 feature selection challenge.
