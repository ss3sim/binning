## Source this file to run the entire set of binning scenarios
Nsim <- 1
D <- c(2,3,4,5)
B <- c(0:4, 11:14)
case_files <- list(F="F", B="em_binning", I="data",
                   D=c("index","lcomp","agecomp","calcomp"), E="E")
for(spp in species){
    scenarios <- expand_scenarios(cases=list(D=D, F=1, I=0, B=B, E=991), species=spp)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=FALSE,
               case_folder=case_folder, om_dir=ss3model(spp, "om"),
               em_dir=ss3model(spp, "em"), case_files=case_files,
               bias_adjust=FALSE, bias_nsim=10,
               call_change_data=TRUE)
}
## Read in results
scen.all <- expand_scenarios(cases=list(D=D, F=1, I=0, B=B, E=991), species=species)
get_results_all(user=scen.all, parallel=F, over=TRUE)
file.copy(c("ss3sim_ts.csv", "ss3sim_scalar.csv"), over=TRUE,
          to=c("results/results_binning.ts.csv", "results/results_binning.sc.csv"))
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
## unlink(scen.all, TRUE)

## get_results_bias <- function(scenarios, directory=getwd()){
##     temp <- list()
##     for(sc in scenarios){
##         bias.temp <- read.table(paste0(sc,"/bias/AdjustBias.DAT"), header=FALSE, sep=" ")
##         names(bias.temp) <- c("iteration", paste0("bias", 1:5))
##         bias.temp$scenario <- sc
##         temp[[sc]] <- bias.temp
##     }
##     bias.all <- do.call(rbind, temp)
##     bias.all$converged <- apply(bias.all, 1, anyNA)
##     row.names(bias.all) <- NULL
##     bias.all.long <- melt(bias.all, id.vars=c("iteration", "scenario", "converged"))
##     return(bias.all.long)
## }
## ggplot(bias.all.long, aes(x=scenario, y=value))+geom_point() +
##     facet_wrap("variable", scales="free_y")
## scenarios.converged <- ddply(bias.all.long, .(scenario), summarize, mean(converged))
## plot(scenarios.converged)
