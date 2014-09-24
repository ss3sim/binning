## This is the central R file for doing tests with ss3sim for the binning
## group. The idea is that it uses the development branch of ss3sim and any
## development versions of R functions written here. At the end of the
## project this file will be converted into one to recreate the entire
## simulation. Any intermediate code should be saved by commenting it out
## and putting it at the end of the file. (We might want to incorporate it
## into a "how to test" type document later, so it's worth saving for now).

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
load_all("../ss3sim")
## install('../ss3sim') # may need this for parallel runs??
case_folder <- 'cases'
d <- system.file("extdata", package = "ss3sim")
om <- paste0(d, "/models/cod-om")
em <- paste0(d, "/models/cod-em")
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001), nrow=100, ncol=100)
### ------------------------------------------------------------


### ------------------------------------------------------------
### Preliminary tail compression analysis with cod
## WRite the cases to file
tc.n <- 10
tc.seq <- seq(0, .25, len=tc.n)
for(i in 1:tc.n){
    tc <- tc.seq[i]
    x <- c(paste("tail_compression;", tc), "file_in; ss3.dat", "file_out; ss3.dat")
    writeLines(x, con=paste0(case_folder, "/T",i, "-cod.txt"))
}
scen.df <- data.frame(T.value=c(-.001,tc.seq), T=paste0("T", 0:tc.n))
scen <- expand_scenarios(cases=list(D=0, E=0, F=0, R=0,M=0, T=0:tc.n), species="cod")
## Run them in parallel
run_ss3sim(iterations = 1:5, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files = list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", T="T"),
           user_recdevs=user.recdevs)
## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen)
file.copy("ss3sim_scalar.csv", "results/tc_test1_scalar.csv")
file.copy("ss3sim_ts.csv", "results/tc_test1_ts.csv")
results <- read.csv("results/tc_test1_scalar.csv")
em_names <- names(results)[grep("_em", names(results))]
results_re <- as.data.frame(
    sapply(1:length(em_names), function(i)
           (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
           results[,gsub("_em", "_om", em_names[i])]
           ))
names(results_re) <- gsub("_em", "_re", em_names)
results_re$T <- results$T
results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
results_long <- reshape2::melt(results_re, "T")
results_long <- merge(scen.df, results_long)
results_long$T <- factor(results_long$T, levels=paste0("T", 0:tc.n))
## Make exploratory plots
ggplot(results_long, aes(x=T, y=value, color=T.value))+ ylab("Relative Error")+
    geom_jitter()+facet_wrap("variable", scales="fixed") + ylim(-1,1)
ggsave("plots/tc_test1.png", width=10, height=7)
## Clean up everything
unlink(scen, TRUE)
file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
rm(results, results_re, results_long, scen.df, scen, em_names, tc.seq, tc, x, i)
## End of tail compression run
### ------------------------------------------------------------

### ------------------------------------------------------------
### Preliminary lcomp constant analysis with cod
## WRite the cases to file
lc.n <- 10
lc.seq <- seq(.0001, .1, len=lc.n)
for(i in 1:lc.n){
    lc <- lc.seq[i]
    x <- c(paste("lcomp_constant;", lc), "file_in; ss3.dat", "file_out; ss3.dat")
    writeLines(x, con=paste0(case_folder, "/C",i, "-cod.txt"))
}
scen.df <- data.frame(C.value=c(lc.seq), C=paste0("C", 1:lc.n))
scen <- expand_scenarios(cases=list(D=0, E=0, F=0, R=0,M=0, C=1:lc.n), species="cod")
## Run them in parallel
run_ss3sim(iterations = 1:5, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files = list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", C="C"),
           user_recdevs=user.recdevs)
## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen)
file.copy("ss3sim_scalar.csv", "results/lc_test1_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/lc_test1_ts.csv", over=TRUE)
results <- read.csv("results/lc_test1_scalar.csv")
em_names <- names(results)[grep("_em", names(results))]
results_re <- as.data.frame(
    sapply(1:length(em_names), function(i)
           (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
           results[,gsub("_em", "_om", em_names[i])]
           ))
names(results_re) <- gsub("_em", "_re", em_names)
results_re$C <- results$C
results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
results_long <- reshape2::melt(results_re, "C")
results_long <- merge(scen.df, results_long)
results_long$C <- factor(results_long$C, levels=paste0("C", 0:lc.n))
## Make exploratory plots
ggplot(results_long, aes(x=C.value, y=value))+ylab("Relative Error")+
    geom_jitter()+facet_wrap("variable", scales="fixed") + ylim(-.25,.25)
ggsave("plots/lc_test1.png", width=10, height=7)
## Clean up everything
unlink(scen, TRUE)
file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
rm(results, results_re, results_long, scen.df, scen, em_names, lc.seq, lc, x, i)
## End of lcomp constant test run
### ------------------------------------------------------------


### ------------------------------------------------------------
## Code for testing the change_bin function to run the base model
setwd("F:/binning")
dir.create("cod-om-test")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test")
## to run the "change_bin" function
dir.create("cod-om-test-new")
files <- list.files("cod-om", full.names=TRUE)
file.copy(files,  "cod-om-test-new")
setwd("F:/binning/cod-om-test-new")
change_bin(file_in="codOM.dat", file_out="codOM.new.dat", bin_vector = c(20, 26, 29, 32, 35, 38, 41, 44, 47, 50, 53, 56, 59, 62, 65, 68, 71, 74, 77, 80, 83, 86, 89, 92, 95, 98, 101, 104, 107, 110, 113, 116, 119, 122, 125, 128, 131, 134, 137, 140, 143, 146, 149, 152), type="length", write_file = TRUE)
## End of session so clean up
unlink("cod-om-test", TRUE)
unlink("cod-om-test-new", TRUE)
## to check whether the new function works or not
bin_or <- c(0.00260219, 0.0341899, 0.279936, 0.929283, 1.20611, 0.653391, 0.520717, 1.42683, 3.00334, 4.18986, 4.12005, 3.25679, 2.71086, 2.85671, 3.25729, 3.45327, 3.38539, 3.24925, 3.1975, 3.22675, 3.26419, 3.2722, 3.2615, 3.25157, 3.24677, 3.24085, 3.22745, 3.20273, 3.16287, 3.10237, 3.01459, 2.89321, 2.73361, 2.53419, 2.29732, 2.02987, 1.74285, 1.45006, 1.16618, 0.9046, 0.675517, 0.484856, 0.334057, 0.220715, 0.325783)
bin_new <- c(0.0357928, 0.279938, 0.929293, 1.20612, 0.653397, 0.520722, 1.42684, 3.00337, 4.1899, 4.12009, 3.25683, 2.71089, 2.85673, 3.25732, 3.4533, 3.38542, 3.24928, 3.19754, 3.22678, 3.26422, 3.27223, 3.26153, 3.2516, 3.2468, 3.24088, 3.22748, 3.20276, 3.1629, 3.1024, 3.01462, 2.89323, 2.73364, 2.53421, 2.29734, 2.02989, 1.74287, 1.45007, 1.1662, 0.904609, 0.675524, 0.484861, 0.334061, 0.220717, 0.325786)
plot(1:length(bin_new), bin_or[-1], type="p")
points(1:length(bin_new), bin_new, col="red")
### ------------------------------------------------------------


### ------------------------------------------------------------
### Old testing code, leave here for now, eventually migrate to a testing
### folder in the package.


## ### ------------------------------------------------------------
## ### Code for testing the change_tail_compression
## ## Test whether cases are parsed correctly
## get_caseargs("cases", scenario = "D0-E0-F0-M0-R0-S0-T0-cod",
##              case_files = list(E = "E", D = c("index", "lcomp", "agecomp"), F =
##              "F", M = "M", R = "R", S = "S", T="T"))
## ## Run the example simulation with tail compression option
## case_folder <- 'cases'
## d <- system.file("extdata", package = "ss3sim")
## om <- paste0(d, "/models/cod-om")
## em <- paste0(d, "/models/cod-em")
## run_ss3sim(iterations = 1, scenarios =
##            c("D0-E0-F0-R0-M0-T0-cod", "D0-E0-F0-R0-M0-T1-cod"),
##            case_folder = case_folder, om_dir = om,
##            em_dir = em, case_files = list(M = "M", F = "F", D =
##     c("index", "lcomp", "agecomp"), R = "R", E = "E", T="T"))
## ## Make sure it runs with no tail compression option
## run_ss3sim(iterations = 1, scenarios =
##            c("D0-E0-F0-R0-M0-cod"),
##            case_folder = case_folder, om_dir = om,
##            em_dir = em)
## ## quickly grab results to see if any difference
## get_results_all(user_scenarios=
##                 c("D0-E0-F0-R0-M0-T0-cod",
##                   "D0-E0-F0-R0-M0-T1-cod",
##                   "D0-E0-F0-R0-M0-cod" ), over=TRUE)
## results <- read.csv("ss3sim_scalar.csv")
## results$ID <- gsub("D0-E0-F0-R0-M0-|-1", "", as.character(results$ID))
## results.long <- cbind(ID=results$ID, results[,grep("_em", names(results))])
## results.long <- reshape2::melt(results.long, "ID")
## library(ggplot2)
## ggplot(results.long, aes(x=ID, y=value))+
##     geom_point()+facet_wrap("variable", scales="free")
## results.long
## ## End of session so clean up
## unlink("D0-E0-F0-R0-M0-T0-cod", TRUE)
## unlink("D0-E0-F0-R0-M0-T1-cod", TRUE)
## unlink("D0-E0-F0-R0-M0-cod", TRUE)
## file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
## ### ------------------------------------------------------------
