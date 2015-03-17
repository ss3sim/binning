## This file loads libraries, and preps the workspace

### ------------------------------------------------------------
## Startup the working environment
## ## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
case_folder <- 'cases'
## devtools::install_github("ss3sim/ss3sim")
## devtools::install_github('ss3sim/ss3models')
## install("../ss3sim")
## install("../ss3models")
library(ss3sim)
library(ss3models)
library(reshape2)
library(r4ss)
library(ggplot2)
library(devtools)
library(plyr)
library(doParallel)
registerDoParallel(cores = cores)
library("foreach")
message(paste(getDoParWorkers(), "cores have been registered for",
    "parallel processing."))
### ------------------------------------------------------------
