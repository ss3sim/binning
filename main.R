### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
devtools::install('../ss3sim') # may need this for parallel runs??
## devtools::load_all("../ss3sim")
library(ss3sim)
source("startup.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Create case files dynamically for reproducibility

species <- 'cod'
om.cod <- paste0("../growth_models/", species, "-om/")
em.cod <- paste0("../growth_models/", species, "-em/")
source("write_casefiles.R")
### ------------------------------------------------------------

## ### ------------------------------------------------------------
## ## Deterministic scenarios for data cases used
## scenarios <- expand_scenarios(cases=list(D=100:102, E=0, F=1), species=species)
## case_files <- list(F="F", E="E", D=c("index","lcomp","agecomp","calcomp"))
## a <- get_caseargs(folder = case_folder, scenario = scenarios[1], case_files = case_files)
## ## devtools::load_all("../ss3sim")
## ## devtools::install("../ss3sim"); library(ss3sim)
## ## unlink(scenarios, TRUE)
## run_ss3sim(iterations=1:5, scenarios=scenarios,
##            parallel=TRUE, user_recdevs=user.recdevs,
##            case_folder=case_folder, om_dir=om.cod,
##            em_dir=em.cod, case_files=case_files)
## ## Read in results
## get_results_all(dir=getwd(), user_scenarios=scenarios, parallel=TRUE, over=TRUE)
## det.ts <- calculate_re(read.csv("ss3sim_ts.csv"), add=TRUE)
## det.sc <- calculate_re(read.csv("ss3sim_scalar.csv"), add=TRUE)
## write.csv(det.ts, "results/det.ts.csv")
## write.csv(det.sc, "results/det.sc.csv")
## file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
## ### ------------------------------------------------------------


### ------------------------------------------------------------
## Deterministic scenarios for data binning cases
scenarios.E <- expand_scenarios(cases=list(D=100, E=0, F=1, I=0, B=1:2),
                                species=species)
scenarios.I <- expand_scenarios(cases=list(D=100, E=0, F=1, I=1:2, B=0),
                                species=species)
scenarios <- rbind(scenarios.E, scenarios.I)
case_files <- list(F="F", E="E", B="em_binning", I="data", D=c("index","lcomp","agecomp","calcomp"))
devtools::load_all("../ss3sim")
unlink(scenarios, TRUE)
run_ss3sim(iterations=1:10, scenarios=scenarios,
           parallel=TRUE, user_recdevs=user.recdevs,
           case_folder=case_folder, om_dir=om.cod,
           em_dir=em.cod, case_files=case_files, call_change_data=TRUE)
## Read in results
get_results_all(dir=getwd(), user_scenarios=scenarios, parallel=TRUE, over=TRUE)
det.bin.ts <- calculate_re(read.csv("ss3sim_ts.csv"), add=TRUE)
det.bin.sc <- calculate_re(read.csv("ss3sim_scalar.csv"), add=TRUE)
write.csv(det.bin.ts, "results/det.bin.ts.csv")
write.csv(det.bin.sc, "results/det.bin.sc.csv")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
### ------------------------------------------------------------



source("load_results.R")

source("make_tables.R")
source("make_figures.R")
