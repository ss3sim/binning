## To test the tail compression
scenarios <- expand_scenarios(cases=list(D=5, F=1, I=11:15, B=c(1,2,3), E=991), species=species)
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
## unlink(scenarios, TRUE)
Nsim <- 25
run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=FALSE,
           case_folder=case_folder, om_dir=ss3model(species, "om"),
           em_dir=ss3model(species, "em"), case_files=case_files, call_change_data=TRUE)
## Read in results
get_results_all(user=scenarios, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
saveRDS(xx, file="results/results_tcomp.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
saveRDS(xx, file="results/results_tcomp.ts.RData")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))

## To test the robustification constant
scenarios <- expand_scenarios(cases=list(D=5, F=1, I=21:25, B=c(1,2,3), E=991), species=species)
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
## unlink(scenarios, TRUE)
Nsim <- 25
run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=FALSE,
           case_folder=case_folder, om_dir=ss3model(species, "om"),
           em_dir=ss3model(species, "em"), case_files=case_files, call_change_data=TRUE)
## Read in results
get_results_all(user=scenarios, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
saveRDS(xx, file="results/results_robust.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
saveRDS(xx, file="results/results_robust.ts.RData")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))

## clean up work space
rm(xx, scenarios, Nsim, case_files)
