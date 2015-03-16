### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Step 0: Prepare the R workspace and generate case files
cores <- 4   # parallel cores
source("startup.R")
## Create case files dynamically for reproducibility
species <- c('cod','flatfish','yellow')
source("write_casefiles.R")
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
source("make_figures.R")


