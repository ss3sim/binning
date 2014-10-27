print("This file installs the package and libraries, and preps the workspace")
### ------------------------------------------------------------
## Startup the working environment
## ## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
require(doParallel)
registerDoParallel(cores = 4)
require(foreach)
getDoParWorkers()
## Install the package from our local git repository, which is usually a
## development branch. You need to pull down any changes into the branch
## before running this command.
devtools::install('../ss3sim') # may need this for parallel runs??
devtools::load_all("../ss3sim")
library(ss3sim)
case_folder <- 'cases'
d <- system.file("extdata", package = "ss3sim")
fla_om <- "../age_select/fla-om/"
fla_em <- "../age_select/fla-em/"
cod_om <- "../age_select/cod-om/"
cod_em <- "../age_select/cod-em/"
## om <- paste0(d, "/models/cod-om")
## em <- paste0(d, "/models/cod-em")
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
### ------------------------------------------------------------
