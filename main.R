### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### ------------------------------------------------------------
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
source("startup.R")

### ------------------------------------------------------------

### ------------------------------------------------------------
## Create case files dynamically for reproducibility
species <- 'fla'
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Define and run scenarios
scenarios <- expand_scenarios(cases=list(D=100:101, E=0, F=0), species=species)
case_files <- list(F = "F",  E="E",  D= c("index","lcomp","agecomp",
                                     "calcomp"))
a <- get_caseargs(folder = case_folder, scenario = scenarios[1],
                  case_files = case_files)
unlink(scenarios, TRUE)
devtools::load_all("../ss3sim")
run_ss3sim(iterations = 1, scenarios = scenarios, parallel=FALSE,
           case_folder = case_folder, om_dir = cod_om,
           em_dir = cod_em, case_files=case_files)

source("load_results.R")

source("make_tables.R")
source("make_figures.R")
