### Development code for sampling from the new data types. CCM started
### 10/16.


#### All possible test cases:
# 1. Length comps
# 2. Age comps
# 3. Length + age comps
# 4. Length + age comps + CAL
# 5. Length + CAL
# 6. Age + WatAge
# 7. Age + MLA
# 




## prepare workspace
source("startup.R")

## ------------------------------------------------------------
## Test all of the sampling functions to make sure they're working.

## First just age and length
scen <- expand_scenarios(cases=list(D=80, E=0, F=0), species="fla")
case_files <- list(F = "F",  E="E",  D =
    c("index", "lcomp", "agecomp"))
a <- get_caseargs(folder = 'data test cases', scenario = scen[1],
                  case_files = case_files)
devtools::load_all("../ss3sim")
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = 'data test cases', om_dir = fla_om,
           em_dir = fla_em, case_files=case_files)
unlink(scen, TRUE)
## Now add CAL data
## datfile <- SS_readdat("../ss3sim/inst/extdata/example-om/data.ss_new", verb=F)
## SS_writedat(datfile, "test.dat", over=TRUE)
scen <- expand_scenarios(cases=list(D=81, E=0, F=0, X=81), species="fla")
case_files <- list(F = "F",  E="E",  X="calcomp", D =
    c("index", "lcomp", "agecomp"))
get_caseargs(folder = 'data test cases', scenario = scen[1],
                  case_files = case_files)

devtools::load_all("../ss3sim")
unlink(scen, TRUE)
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = 'data test cases', om_dir = fla_om,
           em_dir = fla_em, case_files=case_files)

xx <- r4ss::SS_readdat("D81-E0-F0-X81-fla/1/om/ss3.dat", ver=FALSE)
nrow(xx$agecomp)
xx$N_agecomp
yy <- change_data(xx, outfile=NULL, fleets=1, years=5,
                  types=c("len","age","cal"), write=FALSE)
yy$agecomp
## ------------------------------------------------------------

### ------------------------------------------------------------
## Basic tests for sample_calcomp, of the functions external to the package
devtools::load_all("../ss3sim")

fleets <- c(1,2)
years <- list(c(91,94, 97), 94)
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
datfile <- paste0("data.ss_new")
outfile <- paste0("data_test.dat")
sample_calcomp(datfile=datfile,outfile=outfile,
               fleets=fleets, years=years)

## Not ready to run this yet, still broken
## Now run a test within ss3sim, with and without W@A data to make sure
## it's working.
scen <- expand_scenarios(cases=list(D=100, E=0, F=0),
                         species="fla")
case_files <- list(F = "F", B="bin", E="E", D =
    c("index", "lcomp", "agecomp"))
get_caseargs(folder = 'test cases', scenario = scen[1],
                  case_files = case_files)
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = 'test cases', om_dir = fla_om,
           em_dir = fla_em, case_files=case_files)

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
## Basic tests for sample_mlacomp, of the functions external to the package
devtools::load_all("../ss3sim")
fleets <- c(1)
years <- list(c(90,95, 98))
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
datfile <- paste0("data.ss_new")
ctlfile <- paste0("control.ss_new")
outfile <- paste0("mla_test.dat")
sample_wtatage(datfile=datfile,outfile=outfile,
               fleets=fleets, years=years, ctlfile=ctlfile)

x
## Not ready to run this yet, still broken
## Now run a test within ss3sim, with and without W@A data to make sure
## it's working.
scen <- expand_scenarios(cases=list(D=100, E=0, F=0, B=0, X=0:1),
                         species="fla")
case_files <- list(F = "F", B="bin", E="E", D =
    c("index", "lcomp", "agecomp"), X="mlacomp")
get_caseargs(folder = 'test cases', scenario = scen[1],
                  case_files = case_files)
run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
           parallel_iterations=FALSE,
           case_folder = 'test cases', om_dir = fla_om,
           em_dir = fla_em, case_files=case_files)

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
## Basic tests for sample_wtatage, of the functions external to the package
scen <- expand_scenarios(cases=list(D=100, E=0, F=0, B=0), species="fla")
case_files <- list(F = "F", D = c("index", "lcomp", "agecomp"), E = "E",
                   B="bin")
get_caseargs(folder = 'cases', scenario = scen[1],
                  case_files = case_files)
## ## Run a single model to get the output needed
## run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
##            parallel_iterations=FALSE,
##            case_folder = case_folder, om_dir = om,
##            em_dir = em, case_files=case_files)
fleets <- c(1)
years <- list(c(seq(1,100, by=4),100))
substr_r <- function(x, n){
  substr(x, nchar(x)-n+1, nchar(x))
}
infile <- paste0("D100-E0-F0-W1-fla/1/om","/wtatage.ss_new")
datfile <- paste0("D100-E0-F0-W1-fla/1/om","/data.ss_new")
ctlfile <- paste0("D100-E0-F0-W1-fla/1/om","/control.ss_new")
outfile <- paste0("D100-E0-F0-W1-fla/1/om","/wtatage_test.dat")
sample_wtatage(infile=infile, datfile=datfile, outfile=outfile,
               fleets=fleets, years=years, ctlfile=ctlfile)

## Not ready to run this yet, still broken
## ## Now run a test within ss3sim, with and without W@A data to make sure
## ## it's working.
## scen <- expand_scenarios(cases=list(D=100, E=0, F=0, W=0:1, B=0),
##                          species="fla")
## case_files <- list(F = "F", B="bin", E="E", D =
##     c("index", "lcomp", "agecomp"), W="wtatage" )
## get_caseargs(folder = 'test cases', scenario = scen[1],
##                   case_files = case_files)
## run_ss3sim(iterations = 1:1, scenarios = scen, parallel=FALSE,
##            parallel_iterations=FALSE,
##            case_folder = 'test cases', om_dir = fla_om,
##            em_dir = fla_em, case_files=case_files)
## get_results_all(user=scen)
## results <- read.csv("ss3sim_scalar.csv")
## results <- within(results,{
##     CV_old_re <- (CV_old_Fem_GP_1_em-CV_old_Fem_GP_1_om)/CV_old_Fem_GP_1_om
##     CV_young_re <- (CV_young_Fem_GP_1_em-CV_young_Fem_GP_1_om)/CV_young_Fem_GP_1_om
##     L_at_Amin_re <- (L_at_Amin_Fem_GP_1_em-L_at_Amin_Fem_GP_1_om)/L_at_Amin_Fem_GP_1_om
##     L_at_Amax_re <- (L_at_Amax_Fem_GP_1_em-L_at_Amax_Fem_GP_1_om)/L_at_Amax_Fem_GP_1_om
##     VonBert_K_re <- (VonBert_K_Fem_GP_1_em-VonBert_K_Fem_GP_1_om)/VonBert_K_Fem_GP_1_om
## })
## results_re <- results[, grep("_re", names(results))]
## results_re$C <- results$C
## ## making it long for quick plotting of all params
## results_re <- reshape2::melt(results_re, "C")
## plot_scalar_boxplot(results_re, vert="C", y="value", x="variable", rel=TRUE)
## unlink(scen, TRUE)
## file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
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

