## Source this file to run the entire set of binning scenarios

## We split up the data poor and rich b/c to have different sample sizes
## since data poor converged a lot slower for our MARE metric
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"))
for(spp in species){
    Nsim <- Nsim.datarich
    scenarios <- expand_scenarios(cases=list(D=c(2,3), F=1, I=0,
                                  B=B.binning), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=FALSE,
               case_folder=case_folder, om_dir=om.paths[spp],
               em_dir=em.paths[spp], case_files=case_files,
               bias_adjust=TRUE, bias_nsim=20,
               ## admb_options= " -maxfn 1 -phase 50",
               call_change_data=TRUE)
}
for(spp in species){
    Nsim <- Nsim.datapoor
    scenarios <- expand_scenarios(cases=list(D=c(5,6), F=1, I=0,
                                  B=B.binning), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=FALSE,
               case_folder=case_folder, om_dir=om.paths[spp],
               em_dir=em.paths[spp], case_files=case_files,
               bias_adjust=TRUE, bias_nsim=20,
               ## admb_options= " -maxfn 1 -phase 50",
               call_change_data=TRUE)
}
## Read in results
scenarios.binning.all <-
    expand_scenarios(cases=list(D=D.binning, F=1, I=0, B=B.binning),
                     species=species)
get_results_all(user=scenarios.binning.all, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
saveRDS(xx, file="results/results_binning.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
saveRDS(xx, file="results/results_binning.ts.RData")
## file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
## unlink(scen.all, TRUE)
rm(xx, scenarios, Nsim, case_files)
