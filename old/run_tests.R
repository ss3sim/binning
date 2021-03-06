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
devtools::install("../../ss3sim")
devtools::install("../../ss3models")
## install('../ss3sim') # may need this for parallel runs??
library(ss3sim)
library(ss3models)
## source("get-results.R")
# fla_om <- "../growth_models/fla-om/"
# fla_em <- "../growth_models/fla-em/"
# col_om <- "../growth_models/cos-om/"
# col_em <- "../growth_models/cos-em/"
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
### ------------------------------------------------------------

# ### ------------------------------------------------------------
# ## Use a function to write the case files, for reproducibility, modified
# ## from Kelli's version
# file.remove(list.files("conference cases2", full.names=TRUE))
# source("createcasefiles.R")
# bin.n <- 4
# bin.seq <- seq(2, 15, len=bin.n)
# for(i in 1:bin.n){
    # x <- c(paste("bin_vector; list(len=seq(2, 86, by=", bin.seq[i],"))"),
            # "type;len", "pop_bin;NULL")
    # writeLines(x, con=paste0("conference cases2/bin",i, "-fla.txt"))
    # x <- c(paste("bin_vector; list(len=seq(20, 150, by=", bin.seq[i],"))"),
            # "type;len", "pop_bin;NULL")
    # writeLines(x, con=paste0("conference cases2/bin",i, "-cos.txt"))
# }
# scen.df <- data.frame(B.width=bin.seq, B=paste0("B", 1:bin.n))

# ### ------------------------------------------------------------
# ### Preliminary bin analysis with cod across multiple data types
# ## Write the cases to file
# my.casefiles <-
    # list(A = "agecomp", E = "E", F = "F", X = "mlacomp",
         # I = "index", L = "lcomp", R = "R", B="bin")
# scen.fla <-
    # expand_scenarios(list(A = 0:1, L = 0:1, X = c(0), E = 1, B=1:bin.n,
                          # F = c(0), I = c(0), R = c(0)), species = "fla")
# scen.cos <-
    # expand_scenarios(list(A = 0:1, L = 0:1, X = c(0), E = 1, B=1:bin.n,
                          # F = c(0), I = c(0), R = c(0)), species = "cos")
# ## scen.det <-
# ##     expand_scenarios(list(A = 99, L = 99, X = c(0), E = 0, B=1:bin.n,
# ##                           F = c(0), I = 99, R = c(0)), species = "fla")
# get_caseargs("conference cases2", scenario = scen.fla[1],
             # case_files = my.casefiles)
# get_caseargs("conference cases2", scenario = scen.cos[1],
             # case_files = my.casefiles)

# run_ss3sim(iterations = 11:25, scenarios = scen.fla, parallel=TRUE,
           # case_folder = "conference cases2", om_dir = fla_om,
           # em_dir = fla_em, case_files = my.casefiles)
# run_ss3sim(iterations = 1:1, scenarios = scen.cos, parallel=TRUE,
           # case_folder = "conference cases2", om_dir = col_om,
           # em_dir = col_em, case_files = my.casefiles)
# ## unlink(scen.fla, TRUE)
# ## unlink(scen.cos, TRUE)


# ## ## Look at a couple of models closer using r4ss
# ## res.list <- NULL
# ## for(i in 1:length(scen)){
# ##     res.list[[i]] <- SS_output(paste0(scen[i], "/1/em"), covar=FALSE)
# ## }
# ## for(i in 1:length(scen)){
# ##     SSplotComps(res.list[[i]], print=TRUE)
# ## }
# ## for(i in 1:length(scen)){
# ##     SS_plots(res.list[[i]], png=TRUE, uncer=F, html=F)
# ## }

# ## Read in the results and convert to relative error in long format
# get_results_all(user_scenarios=scen.fla, over=FALSE)
# get_results_all(user_scenarios=scen.col, over=FALSE)
# get_results_all(over=TRUE)
# file.copy("ss3sim_scalar.csv", "results/bin_datatest_scalar.csv", over=TRUE)
# file.copy("ss3sim_ts.csv", "results/bin_datatest_ts.csv", over=TRUE)
# results <- read.csv("results/bin_datatest_scalar.csv")
# em_names <- names(results)[grep("_em", names(results))]
# results_re <- as.data.frame(
    # sapply(1:length(em_names), function(i)
           # (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
           # results[,gsub("_em", "_om", em_names[i])]
            # ))
# names(results_re) <- gsub("_em", "_re", em_names)
# write.csv(results_re, "results_re_datatest.csv")
# results_re$B <- results$B
# results_re$L <- results$L
# results_re$A <- results$A
# results_re$replicate <- results$replicate
# results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
# results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
# results_re <- results_re[,
                         # names(results_re)[-grep("NLL",names(results_re))]]
# results_re <- merge(scen.df, results_re)
# results_re$B.width <- factor(results_re$B.width)
# results_long <- reshape2::melt(results_re, c("B","A","L","replicate"))
# results_long <- merge(scen.df, results_long)
# #results_long$B <- factor(results_long$B, levels=paste0("B", 1:bin.n))
# width <- 7; height <- 4.5
# g <- plot_scalar_boxplot(results_re, x="B", y="SSB_MSY_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_MSY.png", g, width=width, height=height)
# g <- plot_scalar_boxplot(results_re, x="B", y="L_at_Amin_Fem_GP_1_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_Lmin.png", g, width=width, height=height)
# g <- plot_scalar_boxplot(results_re, x="B", y="L_at_Amax_Fem_GP_1_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_Linf.png", g, width=width, height=height)
# g <- plot_scalar_boxplot(results_re, x="B", y="VonBert_K_Fem_GP_1_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_vbK.png", g, width=width, height=height)
# g <- plot_scalar_boxplot(results_re, x="B", y="CV_young_Fem_GP_1_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_CVyoung.png", g, width=width, height=height)
# g <- plot_scalar_boxplot(results_re, x="B", y="CV_old_Fem_GP_1_re",
                    # horiz="A", vert="L", relative=TRUE) + xlab("Bin width")
# ggsave("plots/boxplots_CVold.png", g, width=width, height=height)

# pairs(results_re[,c(7:11)], ylim=c(-1,1))
# g <- plot_scalar_boxplot(results, x="B", y="RunTime")

# ## Make exploratory plots
# ggplot(results_long, aes(x=B.width, y=value))+ ylab("relative error")+
    # geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    # xlab("bin width")
# ggsave("plots/bin_test_cod_D0.png", width=9, height=5)
# ggplot(subset(results_long, D=="D1"), aes(x=B.width, y=value, colour=D))+ ylab("relative error")+
    # geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    # xlab("bin width")
# ggsave("plots/bin_test_cod_D1.png", width=9, height=5)

## ## Clean up everything
## unlink(scen, TRUE)
## file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
## rm(results, results_re, results_long, scen.df, scen, em_names, bin.seq, bin.n, x, i)
## ## End of tail compression run
### ------------------------------------------------------------




## ### ------------------------------------------------------------
## ### Preliminary bin analysis with cod
## ## WRite the cases to file
## bin.n <- 5
## bin.seq <- seq(2, 15, len=bin.n)
## for(i in 1:bin.n){
##     x <- c(paste("bin_vector; seq(20, 150, by=", bin.seq[i],")"),
##             "type;len", "pop_bin;NULL")
##     writeLines(x, con=paste0(case_folder, "/B",i, "-cod.txt"))
## }
## (args <- ss3sim:::get_args('cases/B4-cod.txt'))
## (args <- ss3sim:::get_args('cases/lencomp1-cod.txt'))
## scen.df <- data.frame(B.value=bin.seq, B=paste0("B", 1:bin.n))
## scen <- expand_scenarios(cases=list(D=0:1, E=0, F=0, R=0,M=0, B=1:bin.n),
##                          species="cod")
## run_ss3sim(iterations = 1:1, scenarios = scen, parallel=TRUE,
##            case_folder = case_folder, om_dir = om,
##            em_dir = em, case_files = list(M = "M", F = "F", D =
##     c("index", "lcomp", "agecomp"), R = "R", E = "E", B="B"))
## ## Read in the results and convert to relative error in long format
## get_results_all(user_scenarios=scen, over=TRUE)
## file.copy("ss3sim_scalar.csv", "results/bin_test1_scalar.csv", over=TRUE)
## file.copy("ss3sim_ts.csv", "results/bin_test1_ts.csv", over=TRUE)
## results <- read.csv("results/bin_test1_scalar.csv")
## em_names <- names(results)[grep("_em", names(results))]
## results_re <- as.data.frame(
##     sapply(1:length(em_names), function(i)
##            (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
##            results[,gsub("_em", "_om", em_names[i])]
##             ))
## names(results_re) <- gsub("_em", "_re", em_names)
## results_re$B <- results$B
## results_re$D <- results$D
## results_re$replicate <- results$replicate
## results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
## results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
## results_re <- results_re[, names(results_re)[-grep("NLL",names(results_re))]]
## results_long <- reshape2::melt(results_re, c("B", "D","replicate"))
## results_long <- merge(scen.df, results_long)
## results_long$B <- factor(results_long$B, levels=paste0("B", 1:bin.n))
## ## Make exploratory plots
## ggplot(subset(results_long, D=="D0"), aes(x=B.value, y=value, colour=D))+ ylab("relative error")+
##     geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
##     xlab("bin width")
## ggsave("plots/bin_test_cod_D0.png", width=9, height=5)
## ggplot(subset(results_long, D=="D1"), aes(x=B.value, y=value, colour=D))+ ylab("relative error")+
##     geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
##     xlab("bin width")
## ggsave("plots/bin_test_cod_D1.png", width=9, height=5)

## ## Clean up everything
## unlink(scen, TRUE)
## file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
## rm(results, results_re, results_long, scen.df, scen, em_names, bin.seq, bin.n, x, i)
## ## End of tail compression run
## ### ------------------------------------------------------------



### ------------------------------------------------------------
### Preliminary tail compression analysis with cod
## WRite the cases to file

case_folder = "F:\\ss3sim_projects\\binning\\cases\\"
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
           case_folder = case_folder, om_dir = om,
           em_dir = em, case_files = list(M = "M", F = "F", D =
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

## ### ------------------------------------------------------------
## ### Preliminary lcomp constant analysis with cod
## ## WRite the cases to file
## lc.n <- 10
## lc.seq <- seq(1e-7, .1, len=lc.n)
## for(i in 1:lc.n){
##     lc <- lc.seq[i]
##     x <- c(paste("lcomp_constant;", lc), "file_in; ss3.dat", "file_out; ss3.dat")
##     writeLines(x, con=paste0(case_folder, "/C",i, "-cod.txt"))
## }
## ## (xx <- get_args("cases/C1-cod.txt"))
## ## add_nulls(xx, c("lcomp_constant", "file_in", "file_out"))
## scen.df <- data.frame(C.value=c(lc.seq), C=paste0("C", 1:lc.n))
## scen <- expand_scenarios(cases=list(D=0, E=0, F=0, R=0,M=0, C=1:lc.n), species="cod")
## ## Run them in parallel
## run_ss3sim(iterations = 1:10, scenarios = scen, parallel=TRUE,
##            case_folder = case_folder, om_dir = om,
##            em_dir = em, case_files = list(M = "M", F = "F", D =
##     c("index", "lcomp", "agecomp"), R = "R", E = "E", C="C"))
## ## Read in the results and convert to relative error in long format
## get_results_all(user_scenarios=scen)
## file.copy("ss3sim_scalar.csv", "results/lc_test1_scalar.csv", over=TRUE)
## file.copy("ss3sim_ts.csv", "results/lc_test1_ts.csv", over=TRUE)
## results <- read.csv("results/lc_test1_scalar.csv")
## em_names <- names(results)[grep("_em", names(results))]
## results_re <- as.data.frame(
##     sapply(1:length(em_names), function(i)
##            (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
##            results[,gsub("_em", "_om", em_names[i])]))
## names(results_re) <- gsub("_em", "_re", em_names)
## results_re$replicate <- results$replicate
## results_re$C <- results$C
## results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
## results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
## results_re <- results_re[,names(results_re)[-grep("NLL",names(results_re))]]
## results_long <- reshape2::melt(results_re, c("C", "replicate"))
## results_long <- merge(scen.df, results_long)
## results_long$C <- factor(results_long$C, levels=paste0("C", 0:lc.n))
## ## Make exploratory plots
## ggplot(results_long, aes(x=C.value, y=value))+ylab("relative error")+
##     geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
##     xlab("robustification constant value")
## ggsave("plots/lc_test1.png", width=10, height=7)
## ## Clean up everything
## unlink(scen, TRUE)
## file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
## rm(results, results_re, results_long, scen.df, scen, em_names, lc.seq, lc, x, i)
## ## End of lcomp constant test run
## ### ------------------------------------------------------------




## ### ------------------------------------------------------------
## ### Old testing code, leave here for now, eventually migrate to a testing
## ### folder in the package.


## ## ### ------------------------------------------------------------
## ## ### Code for testing the change_tail_compression
## ## ## Test whether cases are parsed correctly
## ## get_caseargs("cases", scenario = "D0-E0-F0-M0-R0-S0-T0-cod",
## ##              case_files = list(E = "E", D = c("index", "lcomp", "agecomp"), F =
## ##              "F", M = "M", R = "R", S = "S", T="T"))
## ## ## Run the example simulation with tail compression option
## ## case_folder <- 'cases'
## ## d <- system.file("extdata", package = "ss3sim")
## ## om <- paste0(d, "/models/cod-om")
## ## em <- paste0(d, "/models/cod-em")
## ## run_ss3sim(iterations = 1, scenarios =
## ##            c("D0-E0-F0-R0-M0-T0-cod", "D0-E0-F0-R0-M0-T1-cod"),
## ##            case_folder = case_folder, om_dir = om,
## ##            em_dir = em, case_files = list(M = "M", F = "F", D =
## ##     c("index", "lcomp", "agecomp"), R = "R", E = "E", T="T"))
## ## ## Make sure it runs with no tail compression option
## ## run_ss3sim(iterations = 1, scenarios =
## ##            c("D0-E0-F0-R0-M0-cod"),
## ##            case_folder = case_folder, om_dir = om,
## ##            em_dir = em)
## ## ## quickly grab results to see if any difference
## ## get_results_all(user_scenarios=
## ##                 c("D0-E0-F0-R0-M0-T0-cod",
## ##                   "D0-E0-F0-R0-M0-T1-cod",
## ##                   "D0-E0-F0-R0-M0-cod" ), over=TRUE)
## ## results <- read.csv("ss3sim_scalar.csv")
## ## results$ID <- gsub("D0-E0-F0-R0-M0-|-1", "", as.character(results$ID))
## ## results.long <- cbind(ID=results$ID, results[,grep("_em", names(results))])
## ## results.long <- reshape2::melt(results.long, "ID")
## ## library(ggplot2)
## ## ggplot(results.long, aes(x=ID, y=value))+
## ##     geom_point()+facet_wrap("variable", scales="free")
## ## results.long
## ## ## End of session so clean up
## ## unlink("D0-E0-F0-R0-M0-T0-cod", TRUE)
## ## unlink("D0-E0-F0-R0-M0-T1-cod", TRUE)
## ## unlink("D0-E0-F0-R0-M0-cod", TRUE)
## ## file.remove("ss3sim_scalar.csv", "ss3sim_ts.csv")
## ## ### ------------------------------------------------------------
