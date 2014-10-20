## This is the central R file for running simulations for the binning
## group.

### ------------------------------------------------------------
## Startup the working environment
## ## Update the development tools, if you haven't recently
## update.packages(c('r4ss','knitr', 'devtools', 'roxygen2'))
## Load the neccessary libraries
library(devtools)
require(doParallel)
registerDoParallel(cores = 4)
require(foreach)
getDoParWorkers()
## Install the package from our local git repository, which is usually a
## development branch. You need to pull down any changes into the branch
## before running this command.
## load_all("../ss3sim")
install('../ss3sim') # may need this for parallel runs??
library(ss3sim)
case_folder <- 'cases'
d <- system.file("extdata", package = "ss3sim")
fla.om <- paste0(d, "/models/fla-om")
fla.em <- paste0(d, "/models/fla-em")
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
### ------------------------------------------------------------

### ------------------------------------------------------------
## Bin analysis across multiple data types
## Write the cases to file
bin.n <- 5
bin.seq <- floor(seq(8, 40, len=bin.n))
for(i in 1:bin.n){
    x <- c(paste("bin_vector; list(len=seq(2, 86, length.out=", bin.seq[i],"))"),
            "type;len", "pop_bin;NULL")
    writeLines(x, con=paste0(case_folder, "/bin",i, "-fla.txt"))
}
scen.df <- data.frame(B.value=bin.seq, B=paste0("B", 1:bin.n))
scen <- expand_scenarios(cases=list(D=c(2:3), E=0:1, F=0, R=0,M=0, B=1:bin.n),
                         species="fla")
case_files <-  list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", B="bin")
get_caseargs(folder = 'cases', scenario = scen[2],
                  case_files = case_files)

run_ss3sim(iterations = 1:15, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = fla.om,
           em_dir = fla.em, case_files=case_files)
## Look at a couple of models closer using r4ss
res.list <- NULL
for(i in 1:length(scen)){
    res.list[[i]] <- SS_output(paste0(scen[i], "/1/em"), covar=FALSE)
}
for(i in 1:length(scen)){
    SSplotComps(res.list[[i]], print=TRUE)
}
for(i in 1:length(scen)){
    SS_plots(res.list[[i]], png=TRUE, uncer=F, html=F)
}

for(i in 1:length(scen)){
    file.copy(paste0(scen[i],
                     "/1/emcomp_lenfit_sex1mkt0aggregated across time.png"), paste0("plots/lencompfit_", scen[i], ".png"))
    file.copy(paste0(scen[i],
                     "/1/em/plots/data_plot.png"), paste0("plots/data_", scen[i], ".png"))
}

## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen, over=TRUE)
file.copy("ss3sim_scalar.csv", "results/bin_fla_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/bin_fla_ts.csv", over=TRUE)
results <- read.csv("results/bin_fla_scalar.csv")
results <- within(results,{
    CV_old_re <- (CV_old_Fem_GP_1_em-CV_old_Fem_GP_1_om)/CV_old_Fem_GP_1_om
    CV_young_re <- (CV_young_Fem_GP_1_em-CV_young_Fem_GP_1_om)/CV_young_Fem_GP_1_om
    L_at_Amin_re <- (L_at_Amin_Fem_GP_1_em-L_at_Amin_Fem_GP_1_om)/L_at_Amin_Fem_GP_1_om
    L_at_Amax_re <- (L_at_Amax_Fem_GP_1_em-L_at_Amax_Fem_GP_1_om)/L_at_Amax_Fem_GP_1_om
    VonBert_K_re <- (VonBert_K_Fem_GP_1_em-VonBert_K_Fem_GP_1_om)/VonBert_K_Fem_GP_1_om
    depletion_re <- (depletion_em-depletion_om)/depletion_om
})
results_re <- calculate_re(results, FALSE)
results_re <- results[, grep("_re", names(results))]
results_re$B <- results$B;results_re$D <- results$D;results_re$E <- results$E
results_re$replicate <- results$replicate
results_long <- reshape2::melt(results_re, c("E","B", "D","replicate"))
results_long <- merge(scen.df, results_long)
results_long$B.value <- factor(results_long$B.value, levels=bin.seq)
## Make exploratory plots
plot_scalar_boxplot(results_long, x="B.value", y="value", vert="variable", horiz2="D",
                   horiz="E", rel=F, axes.free=TRUE) + xlab("# of length bins") +
                                         ylab("relative error")+ ylim(-.7, .-3)

ggsave("plots/bin_fla.png", width=9, height=5)


## Clean up everything
unlink(scen, TRUE)
file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
rm(results, results_re, results_long, scen.df, scen, em_names, bin.seq, bin.n, x, i)
## End of bin structure runs
### ------------------------------------------------------------





### ------------------------------------------------------------
### Tail compression analysis with cod
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
## RUns parallel=F but not TRUE??????
run_ss3sim(iterations = 1:10, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = fla.om,
           em_dir = fla.em, case_files = list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", T="T"))
## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen)
file.copy("ss3sim_scalar.csv", "results/tc_test1_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/tc_test1_ts.csv", over=TRUE)
results <- read.csv("results/tc_test1_scalar.csv")
em_names <- names(results)[grep("_em", names(results))]
results_re <- as.data.frame(
    sapply(1:length(em_names), function(i)
           (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
           results[,gsub("_em", "_om", em_names[i])]
           ))
names(results_re) <- gsub("_em", "_re", em_names)
results_re$replicate <- results$replicate
results_re$T <- results$T
results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
results_re <- results_re[, names(results_re)[-grep("NLL",names(results_re))]]
results_long <- reshape2::melt(results_re, c("T", "replicate"))
results_long <- merge(scen.df, results_long)
results_long$T <- factor(results_long$T, levels=paste0("T", 0:tc.n))
## Make exploratory plots
ggplot(results_long, aes(x=T.value, y=value))+ ylab("relative error")+
    geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    xlab("tail compression value")
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
lc.seq <- seq(1e-7, .1, len=lc.n)
for(i in 1:lc.n){
    lc <- lc.seq[i]
    x <- c(paste("lcomp_constant;", lc), "file_in; ss3.dat", "file_out; ss3.dat")
    writeLines(x, con=paste0(case_folder, "/C",i, "-cod.txt"))
}
## (xx <- get_args("cases/C1-cod.txt"))
## add_nulls(xx, c("lcomp_constant", "file_in", "file_out"))
scen.df <- data.frame(C.value=c(lc.seq), C=paste0("C", 1:lc.n))
scen <- expand_scenarios(cases=list(D=0, E=0, F=0, R=0,M=0, C=1:lc.n), species="cod")
## Run them in parallel
run_ss3sim(iterations = 1:10, scenarios = scen, parallel=TRUE,
           case_folder = case_folder, om_dir = fla.om,
           em_dir = fla.em, case_files = list(M = "M", F = "F", D =
    c("index", "lcomp", "agecomp"), R = "R", E = "E", C="C"))
## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen)
file.copy("ss3sim_scalar.csv", "results/lc_test1_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/lc_test1_ts.csv", over=TRUE)
results <- read.csv("results/lc_test1_scalar.csv")
em_names <- names(results)[grep("_em", names(results))]
results_re <- as.data.frame(
    sapply(1:length(em_names), function(i)
           (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
           results[,gsub("_em", "_om", em_names[i])]))
names(results_re) <- gsub("_em", "_re", em_names)
results_re$replicate <- results$replicate
results_re$C <- results$C
results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
results_re <- results_re[,names(results_re)[-grep("NLL",names(results_re))]]
results_long <- reshape2::melt(results_re, c("C", "replicate"))
results_long <- merge(scen.df, results_long)
results_long$C <- factor(results_long$C, levels=paste0("C", 0:lc.n))
## Make exploratory plots
ggplot(results_long, aes(x=C.value, y=value))+ylab("relative error")+
    geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    xlab("robustification constant value")
ggsave("plots/lc_test1.png", width=10, height=7)
## Clean up everything
unlink(scen, TRUE)
file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
rm(results, results_re, results_long, scen.df, scen, em_names, lc.seq, lc, x, i)
## End of lcomp constant test run
### ------------------------------------------------------------
