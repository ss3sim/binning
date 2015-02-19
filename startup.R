message("This file installs the package and libraries, and preps the workspace")
### ------------------------------------------------------------
## Startup the working environment
## ## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
library("doParallel")
registerDoParallel(cores = 2)
library("foreach")
message(paste(getDoParWorkers(), "cores have been registered for",
    "parallel processing."))
## Install the package from our local git repository, which is usually a
## development branch. You need to pull down any changes into the branch
## before running this command.
## d <- system.file("extdata", package = "ss3sim")
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.05),
                       nrow=100, ncol=100)
### ------------------------------------------------------------
