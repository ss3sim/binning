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


## First try it with conditional age-at-length. Make a copy of hte input
## file to see how the change_bin function works on it.
file.copy("cod-om/codOM.dat", "codOM.dat")
dev_help("change_bins")

## Took this manually from the length comps and age comps
len_vector <- c(10, 53, 70, 83, 94, 101, 107, 111, 114, 117, 120, 123, 125,
                127, 130, 132, 135, 138, 142, 148, 200)
age_vector <- as.numeric(1:15)
change_bin("codOM.dat", "codOM_cal.dat", bin_vector=age_vector,
           type="cal")
change_bin("codOM.dat", "codOM_age.dat", bin_vector=age_vector,
           type="age")
infile.age <- SS_readdat("codOM_age.dat", verbose=FALSE)
infile.cal <- SS_readdat("codOM_cal.dat", verbose=FALSE)
str(infile.age$agecomp)
str(infile.cal$agecomp)

## temp values for testing
fleets <- c(1,2)
years <- list(c(1998), c(1999,2001))
Nsamp <- list(50, 15)
cv <- list(.1,.3)
## substr_r <- function(x, n){
##   substr(x, nchar(x)-n+1, nchar(x))
## }

sample_calcomp(infile.cal, outfile="test.dat", fleets=NULL, years=years,
               Nsamp=Nsamp, cv=cv)
SS_readdat("test.dat")$agecomp
