### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
devtools::install_github("ss3sim/ss3sim")
devtools::install_github('ss3sim/ss3models')
source("startup.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Create case files dynamically for reproducibility
## file.copy(from=paste0("../ss3models/cases/", c("F0-yel", "F1-yel", "F2-yel"), ".txt"),
##           to=paste0("cases", c("F0-yel", "F1-yel", "F2-yel"), ".txt"))
species <- c('cod')
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Initial runs for  scenarios for data binning cases
scenarios.E <- expand_scenarios(cases=list(D=1:6, F=1, I=0, B=1:3, E=991), species=species)
scenarios.I <- expand_scenarios(cases=list(D=1:6, F=1, I=1:3, B=0, E=991), species=species)
scenarios <- c(scenarios.E, scenarios.I)
## scenarios=scenarios.E
scenarios <- subset(scenario.counts, replicates==2, select=scenario)
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
## unlink(scenarios, TRUE)
Nsim <- 20
run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=FALSE,
           case_folder=case_folder, om_dir=ss3model(species, "om"),
           em_dir=ss3model(species, "em"), case_files=case_files, call_change_data=TRUE)
## Read in results
get_results_all(user=scenarios, parallel=TRUE, over=F)
file.copy(c("ss3sim_ts.csv", "ss3sim_scalar.csv"), over=TRUE,
          to=c("results/results.ts.csv", "results/results.sc.csv"))
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))



source("load_results.R")
source("make_plots.R")
source("make_tables.R")
source("make_figures.R")


