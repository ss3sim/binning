### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### ------------------------------------------------------------
## Step 0: Prepare the R workspace and generate case files
cores <- 5   # parallel cores
## devtools::install_github("ss3sim/ss3sim")
## devtools::install_github('r4ss/r4ss')
## sample sizes
Nsim.datapoor <- 400
Nsim.datarich <- 200
Nsim.biasruns <- 10 # only run for binning section due to poor convergence
## major cases for binning section
D.binning <- c(2,3,5,6)
B.binning <- c(0:4, 11:14)
## major cases for robust/tcomp section
D.rbtc <- D.binning
B.rbtc <- 0
species <- c('cod','flatfish','yellow-long')
source("startup.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Step 1: Run the OM tests for pop bins
scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
source("run_popbin_scenarios.R")

### ------------------------------------------------------------
## Step 2: Run the EM binning scenarios
source("run_binning_scenarios.R")

### ------------------------------------------------------------
## Step 3: Read in, process, and cleanup the data for plotting
source("load_results.R")

### ------------------------------------------------------------
## Step 4: Make plots (not in paper), figures (in paper) and tables
source("make_plots.R")
source("make_tables.R")
## use a minimum number of converged iterations for plotting scenario
## relative errors
pct.converged.min <- .5
source("make_figures.R")

