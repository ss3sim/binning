### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Step 0: Prepare the R workspace and generate case files
cores <- 4   # parallel cores
source("startup.R")
## Create case files dynamically for reproducibility
species <- c('cod','flatfish','yellow')
unlink('cases', TRUE)
dir.create('cases')
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Step 1: Run the OM tests for pop bins
## source("run_popbin_scenarios")

### ------------------------------------------------------------
## Step 2: Run the EM binning scenarios
D.binning <- c(2,3,5,6)
B.binning <- c(0:4, 11:14)
source("run_binning_scenarios.R"n)

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



## get_results_bias <- function(scenarios, directory=getwd()){
##     temp <- list()
##     for(sc in scenarios){
##         bias.temp <- read.table(paste0(sc,"/bias/AdjustBias.DAT"), header=FALSE, sep=" ")
##         names(bias.temp) <- c("iteration", paste0("bias", 1:5))
##         bias.temp$scenario <- sc
##         temp[[sc]] <- bias.temp
##     }
##     bias.all <- do.call(rbind, temp)
##     bias.all$converged <- apply(bias.all, 1, anyNA)
##     row.names(bias.all) <- NULL
##     bias.all.long <- melt(bias.all, id.vars=c("iteration", "scenario", "converged"))
##     return(bias.all.long)
## }
## ggplot(bias.all.long, aes(x=scenario, y=value))+geom_point() +
##     facet_wrap("variable", scales="free_y")
## scenarios.converged <- ddply(bias.all.long, .(scenario), summarize, mean(converged))
## plot(scenarios.converged)
