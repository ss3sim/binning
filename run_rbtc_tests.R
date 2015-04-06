## To test the tail compression
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"))
## unlink(scenarios, TRUE)
# scenarios <- scenarios[! scenarios %in% list.dirs(getwd(),recursive=F, full.names =F)]
Nsim <- Nsim.datarich
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=c(2,3), F=1, I=11:14, B=0), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=TRUE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files)
}
Nsim <- Nsim.datapoor
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=c(5,6), F=1, I=11:14, B=0), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=TRUE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files)
}
## Read in results
scenarios.tcomp.all <- expand_scenarios(cases=list(D=c(2,3,5,6), F=1, I=11:14, B=0), species=species)
get_results_all(user=scenarios.tcomp.all, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
saveRDS(xx, file="results/results_tcomp.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
saveRDS(xx, file="results/results_tcomp.ts.RData")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))

Nsim <- Nsim.datarich
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=c(2,3), F=1, I=21:24, B=0), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=TRUE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files)
}
Nsim <- Nsim.datapoor
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=c(5,6), F=1, I=21:24, B=0), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=TRUE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files)
}
## Read in results
scenarios.robust.all <- expand_scenarios(cases=list(D=c(2,3,5,6), F=1, I=11:14, B=0), species=species)
get_results_all(user=scenarios.robust.all, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
saveRDS(xx, file="results/results_robust.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
saveRDS(xx, file="results/results_robust.ts.RData")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))

## clean up work space
rm(xx, scenarios, Nsim, case_files)
