### Development code for sampling from the new data types. CCM started
### 10/16.

## prepare workspace
source("startup.R")

### ------------------------------------------------------------
## Try it with empirical weight-at-age
## temp values for testing
## Run a single model to get the output needed
scen <- expand_scenarios(cases=list(D=100, E=0, F=0, B=0), species="fla")
case_files <- list(F = "F", D = c("index", "lcomp", "agecomp"), E = "E",
                   B="bin")
get_caseargs(folder = 'cases', scenario = scen[1],
                  case_files = case_files)
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files=case_files)
fleets <- c(1)
years <- list(1:100)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
infile <- "wtatage.ss_new"
datfile <- "data.ss_new"
ctlfile <- "control.ss_new"
outfile <- "wtatage_test.dat"

sample_wtatage(infile=infile, datfile=datfile, outfile=outfile,
               fleets=fleets, years=years,
               Nsamp=Nsamp, cv=cv)


plot(c(10.0087, 20.7434, 40.1687, 42.9212, 49.3674, 42.0366, 47.7564, 40.6817, 51.1055, 43.166, 43.2739, 43.5727, 48.3906, 36.9926, 48.2435, 62.694, 52.1705, 45.0109, 43.2761, 47.2093, 49.3134, 62.3076, 33.286, 47.9778, 50.1149))

## Now run a test within ss3sim, with and without W@A data to make sure
## it's working.


scen <- expand_scenarios(cases=list(D=100, E=0, F=0, R=0, W=c(100),
                         species="fla")
case_files <- list(F = "F", D =
    c("index", "lcomp", "agecomp"), W="wtatage", R = "R", E = "E")
get_caseargs(folder = 'cases', scenario = scen[1],
                  case_files = case_files)$wtatage
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files=case_files)

get_results_all(user=scen)
results <- read.csv("ss3sim_scalar.csv")
results <- within(results,{
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

