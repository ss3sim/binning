### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### TO DO before rerunning the simulation
## 1.) Drop E991 and instead use biomass at end of year
## 1.) Revisit data sets and sample sizes

### ------------------------------------------------------------
## Step 0: Prepare the R workspace and generate case files
cores <- 4   # parallel cores
devtools::install_github("ss3sim/ss3sim")
devtools::install_github('ss3sim/ss3models', ref='turn_on_cumreport_files')
## sample sizes
Nsim.datapoor <- 200
Nsim.datarich <- 100
Nsim.biasruns <- 10 # only run for binning section due to poor convergence
## major cases for binning section
D.binning <- c(2,3,5,6)
B.binning <- c(0:4, 11:14)
## major cases for robust/tcomp section
D.rbtc <- D.binning
B.rbtc <- 0
source("startup.R")
## Create case files dynamically for reproducibility
species <- c('cod','flatfish','yellow')
unlink('cases', TRUE)
dir.create('cases')
for(spp in species) {
    ## Get the F cases from the package since based on Fmsy
    file.copy(from=paste0(system.file("cases", package="ss3models"),"/F1-", spp,'.txt'), to=case_folder)
    ## write the data and binning cases
    write_cases_data(spp=spp)
    write_cases_binning(spp=spp)
}
### ------------------------------------------------------------

### ------------------------------------------------------------
## Step 1: Run the OM tests for pop bins
source("run_popbin_scenarios")

### ------------------------------------------------------------
## Step 2: Run the EM binning scenarios
source("run_binning_scenarios.R")

### ------------------------------------------------------------
## Step 3: Run the robustification and tail compression scenarios
source("run_rbtc_tests.R")

### ------------------------------------------------------------
## Step 4: Read in, process, and cleanup the data for plotting
source("load_results.R")

### ------------------------------------------------------------
## Step 5: Make plots (not in paper), figures (in paper) and tables
source("make_plots.R")
source("make_tables.R")
## use a minimum number of converged iterations for plotting scenario
## relative errors
count.min <- 10
source("make_figures.R")
