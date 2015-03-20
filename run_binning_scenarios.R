## Source this file to run the entire set of binning scenarios
Nsim <- 50
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=D.binning, F=1, I=0,
                                  B=B.binning, E=991), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=FALSE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files,
               bias_adjust=FALSE, bias_nsim=10,
               ## admb_options= " -maxfn 1 -phase 50",
               call_change_data=TRUE)
}
## Read in results
scen.all <- expand_scenarios(cases=list(D=D.binning, F=1, I=0, B=B.binning,
                             E=991), species=species)
get_results_all(user=scen.all, parallel=TRUE, over=TRUE)
get_results_all(user=scenarios, parallel=TRUE, over=TRUE)
xx <- read.csv("ss3sim_scalar.csv")
save(xx, file="results/results_binning.sc.RData")
xx <- read.csv("ss3sim_ts.csv")
save(xx, file="results/results_binning.ts.RData")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
## unlink(scen.all, TRUE)
rm(scenarios, scen.all, Nsim, case_files)
