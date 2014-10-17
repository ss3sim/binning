### Development code for sampling from the new data types. CCM started
### 10/16.

### ------------------------------------------------------------
## Startup the working environment
## ## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
library(devtools)
library(r4ss)
library(ggplot2)
## install.packages(c("doParallel", "foreach"))
require(doParallel)
registerDoParallel(cores = 4)
require(foreach)
getDoParWorkers()
## Install the package from our local git repository, which is usually a
## development branch. You need to pull down any changes into the branch
## before running this command.
## load_all("../ss3sim")
install('../ss3sim') # may need this for parallel runs??
library(ss3sim)
case_folder <- 'cases'
d <- system.file("extdata", package = "ss3sim")
om <- paste0(d, "/models/fla-om")
em <- paste0(d, "/models/fla-em")
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
                       nrow=100, ncol=100)
### ------------------------------------------------------------


## First try it with conditional age-at-length
