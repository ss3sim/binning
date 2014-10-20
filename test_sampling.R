### Development code for sampling from the new data types. CCM started
### 10/16.

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
## devtools::load_all("../ss3sim")
devtools::install('../ss3sim') # may need this for parallel runs??
library(ss3sim)
case_folder <- 'cases'
d <- system.file("extdata", package = "ss3sim")
om <- paste0(d, "/models/cod-om")
em <- paste0(d, "/models/cod-em")
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
                       nrow=100, ncol=100)
### ------------------------------------------------------------


### ------------------------------------------------------------
## Try it with empirical weight-at-age
## temp values for testing
fleets <- c(1)
years <- list(-(1913:2012))
Nsamp <- list(50)
cv <- list(.1)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
sample_wtatage(infile="wtatage.ss_new", outfile="wtatage_test.dat", fleets=fleets, years=years,
               Nsamp=Nsamp, cv=cv)
## Now run a test within ss3sim, with and without W@A data to make sure
## it's working.
scen <- expand_scenarios(cases=list(D=100, E=0, F=0, R=0,M=0, W=c(100,101)),
                         species="cod")
case_files <- list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), W="wtatage", R = "R", E = "E")
get_caseargs(folder = 'cases', scenario = scen[2],
                  case_files = case_files)$wtatage
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files=case_files)

get_results_all(user=scen)
results <- read.csv("ss3sim_scalar.csv")
results<- within(results,{
    CV_old_re <- (CV_old_Fem_GP_1_em-CV_old_Fem_GP_1_om)/CV_old_Fem_GP_1_om
    CV_young_re <- (CV_young_Fem_GP_1_em-CV_young_Fem_GP_1_om)/CV_young_Fem_GP_1_om
    L_at_Amin_re <- (L_at_Amin_Fem_GP_1_em-L_at_Amin_Fem_GP_1_om)/L_at_Amin_Fem_GP_1_om
    L_at_Amax_re <- (L_at_Amax_Fem_GP_1_em-L_at_Amax_Fem_GP_1_om)/L_at_Amax_Fem_GP_1_om
    VonBert_K_re <- (VonBert_K_Fem_GP_1_em-VonBert_K_Fem_GP_1_om)/VonBert_K_Fem_GP_1_om
})
results_re <- results[, grep("_re", names(results))]
results_re$C <- results$C
## making it long for quick plotting of all params
results_re <- reshape2::melt(results_re, "C")
plot_scalar_boxplot(results_re, vert="C", y="value", x="variable", rel=TRUE)

unlink(scen, TRUE)
file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
### ------------------------------------------------------------


### ------------------------------------------------------------
## Try it with conditional age-at-length.
## temp values for testing
fleets <- c(1,2)
years <- list(c(1998), c(1999,2001))
Nsamp <- list(50, 15)
cv <- list(.1,.3)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
infile.cal <- SS_readdat("cod-om/codOM.dat", ver=FALSE)
sample_calcomp(infile.cal, outfile="test.dat", fleets=NULL, years=years,
               Nsamp=Nsamp, cv=cv)
## Now run a test within ss3sim, with and without cal data to make sure
## it's working.
scen <- expand_scenarios(cases=list(D=100, E=0, F=0, R=0,M=0, B=100, C=c(100,101)),
                         species="cod")
case_files <- list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), C="calcomp", R = "R", E = "E", B="bin")
get_caseargs(folder = 'cases', scenario = scen[2],
                  case_files = case_files)
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=TRUE,
           parallel_iterations=TRUE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files=case_files)
get_results_all(user=scen)
results <- read.csv("ss3sim_scalar.csv")
results<- within(results,{
    CV_old_re <- (CV_old_Fem_GP_1_em-CV_old_Fem_GP_1_om)/CV_old_Fem_GP_1_om
    CV_young_re <- (CV_young_Fem_GP_1_em-CV_young_Fem_GP_1_om)/CV_young_Fem_GP_1_om
    L_at_Amin_re <- (L_at_Amin_Fem_GP_1_em-L_at_Amin_Fem_GP_1_om)/L_at_Amin_Fem_GP_1_om
    L_at_Amax_re <- (L_at_Amax_Fem_GP_1_em-L_at_Amax_Fem_GP_1_om)/L_at_Amax_Fem_GP_1_om
    VonBert_K_re <- (VonBert_K_Fem_GP_1_em-VonBert_K_Fem_GP_1_om)/VonBert_K_Fem_GP_1_om
})
results_re <- results[, grep("_re", names(results))]
results_re$C <- results$C
## making it long for quick plotting of all params
results_re <- reshape2::melt(results_re, "C")
plot_scalar_boxplot(results_re, vert="C", y="value", x="variable", rel=TRUE)

unlink(scen, TRUE)
file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
### ------------------------------------------------------------

