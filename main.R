### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
### Step 1:
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
library(devtools)
## devtools::install_github("ss3sim/ss3sim")
## devtools::install_github('ss3sim/ss3models')
## install("../ss3sim")
## install("../ss3models")
source("startup.R")
## Create case files dynamically for reproducibility
species <- c('cod','flatfish','yellow')
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Step 2: Run the binning scenarios
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
Nsim <- 1
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=1:6, F=1, I=0, B=c(0:3, 11:13), E=991), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=F, parallel_iterations=FALSE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files,
               call_change_data=TRUE, admb_options=" -maxfn 1")
}
## Read in results
get_results_all(user=scenarios, parallel=TRUE, over=TRUE)
file.copy(c("ss3sim_ts.csv", "ss3sim_scalar.csv"), over=TRUE,
          to=c("results/results.ts.csv", "results/results.sc.csv"))
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
unlink(scenarios, TRUE)


## Run the robustification and tail compression tests. Results written to
## results folder automatically.
## source("run_rbtc_tests.R")

source("load_results.R")
source("make_plots.R")
source("make_tables.R")
source("make_figures.R")



