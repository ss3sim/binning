### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
source("startup.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Create case files dynamically for reproducibility
species <- 'cod'
om.cod <- paste0("../growth_models/", species, "-om/")
em.cod <- paste0("../growth_models/", species, "-em/")
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Define and run scenarios
scenarios <- expand_scenarios(cases=list(D=100:101, E=0, F=1), species=species)
case_files <- list(F="F", E="E", D=c("index","lcomp","agecomp","calcomp"))
a <- get_caseargs(folder = case_folder, scenario = scenarios[1], case_files = case_files)
devtools::load_all("../ss3sim")
unlink(scenarios, TRUE)
run_ss3sim(iterations=1, scenarios=scenarios,
           parallel=FALSE, user_recdevs=user.recdevs,
           case_folder=case_folder, om_dir=om.cod,
           em_dir=em.cod, case_files=case_files)
## Read in results
get_results_all(dir=getwd(), user_scenarios=scenarios)
det.ts <- read.csv("ss3sim_ts.csv")
det.ts <- calculate_re(det.ts, add=TRUE)
det.sc <- read.csv("ss3sim_scalar.csv")
det.sc <- calculate_re(det.sc, add=TRUE)
plot_ts_lines(det.ts, y="SpawnBio_re", vert="D", rel=TRUE)
plot_ts_lines(det.ts, y="Recruit_0_re", vert="D", rel=TRUE)
plot_scalar_points(det.sc, x="D", y="depletion_re", rel=TRUE)
plot_scalar_points(det.sc, x="D", y="VonBert_K_Fem_GP_1_re", rel=TRUE)

### ------------------------------------------------------------


source("load_results.R")

source("make_tables.R")
source("make_figures.R")
