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
library(ss3sim)
## source("get-results.R")
fla_om <- "../growth_models/fla-om/"
fla_em <- "../growth_models/fla-em/"
col_om <- "../growth_models/cos-om/"
col_em <- "../growth_models/cos-em/"
## ## devtool tasks
## devtools::document('../ss3sim')
## devtools::run_examples("../ss3sim")
## devtools::check('../ss3sim', cran=TRUE)
## user.recdevs <- matrix(data=rnorm(100^2, mean=0, sd=.001),
##                        nrow=100, ncol=100)
### ------------------------------------------------------------

### ------------------------------------------------------------
## Use a function to write the case files, for reproducibility, modified
## from Kelli's version
file.remove(list.files("conference cases2", full.names=TRUE))
source("createcasefiles.R")
bin.n <- 4
bin.seq <- seq(2, 15, len=bin.n)
for(i in 1:bin.n){
    x <- c(paste("bin_vector; list(len=seq(2, 86, by=", bin.seq[i],"))"),
            "type;len", "pop_bin;NULL")
    writeLines(x, con=paste0("conference cases2/bin",i, "-fla.txt"))
    x <- c(paste("bin_vector; list(len=seq(20, 150, by=", bin.seq[i],"))"),
            "type;len", "pop_bin;NULL")
    writeLines(x, con=paste0("conference cases2/bin",i, "-cos.txt"))
}
scen.df <- data.frame(B.width=bin.seq, B=paste0("B", 1:bin.n))

### ------------------------------------------------------------
### Preliminary bin analysis with cod across multiple data types
## Write the cases to file
## NOTE: Case E1 is to estimate everything, which is what we want.
my.casefiles <-
    list(A = "agecomp", E = "E", F = "F", X = "mlacomp",
         I = "index", L = "lcomp", R = "R", B="bin")
scen.fla <-
    expand_scenarios(list(A = 0:1, L = 0:1, X = c(0), E = 0, B=1:bin.n,
                          F = c(0), I = c(0), R = c(0)), species = "fla")
scen.fla2 <-
    expand_scenarios(list(A = 0:1, L = 0:1, X = c(0), E = 1, B=1:bin.n,
                          F = c(0), I = c(0), R = c(0)), species = "fla")
scen.cos <-
    expand_scenarios(list(A = 0:1, L = 0:1, X = c(0), E = 1, B=1:bin.n,
                          F = c(0), I = c(0), R = c(0)), species = "cos")
## scen.det <-
##     expand_scenarios(list(A = 99, L = 99, X = c(0), E = 0, B=1:bin.n,
##                           F = c(0), I = 99, R = c(0)), species = "fla")
get_caseargs("conference cases2", scenario = scen.fla[1],
             case_files = my.casefiles)
get_caseargs("conference cases2", scenario = scen.cos[1],
             case_files = my.casefiles)

run_ss3sim(iterations = 11:25, scenarios = scen.fla, parallel=TRUE,
           case_folder = "conference cases2", om_dir = fla_om,
           em_dir = fla_em, case_files = my.casefiles)
run_ss3sim(iterations = 2:25, scenarios = scen.cos, parallel=TRUE,
           case_folder = "conference cases2", om_dir = col_om,
           em_dir = col_em, case_files = my.casefiles)
## unlink(scen.fla, TRUE)
## unlink(scen.cos, TRUE)

## Read in the results and convert to relative error in long format
get_results_all(user_scenarios=scen.fla, over=TRUE)
file.copy("ss3sim_scalar.csv", "results/conference_fla1_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/conference_fla1_ts.csv", over=TRUE)
get_results_all(user_scenarios=scen.fla2, over=FALSE)
file.copy("ss3sim_scalar.csv", "results/conference_fla2_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/conference_fla2_ts.csv", over=TRUE)
get_results_all(user_scenarios=scen.cos, over=TRUE)
file.copy("ss3sim_scalar.csv", "results/conference_cos_scalar.csv", over=TRUE)
file.copy("ss3sim_ts.csv", "results/conference_cos_ts.csv", over=TRUE)

get_results_all(over=FALSE)
results.fla <- read.csv("results/conference_fla1_scalar.csv")
results.fla2 <- read.csv("results/conference_fla2_scalar.csv")
results.cos <- read.csv("results/conference_cos_scalar.csv")
results <- plyr::rbind.fill(results.fla, results.fla2, results.cos)
levels(results$species) <- c("flatfish", "cod")
levels(results$L) <- c("Fishery+Survey Lengths", "Fishery Lengths")
levels(results$A) <- c("Fishery+Survey Ages", "No Ages")
## I switched E cases mid run so the first 10 iterations of fla w/ E0 need
## to be converted to E1 to match the rest of the rsults.
results$log_max_grad <- log(results$max_grad)
results_re <- calculate_re(results)
## em_names <- names(results)[grep("_em", names(results))]
## results_re <- as.data.frame(
##     sapply(1:length(em_names), function(i)
##            (results[,em_names[i]]- results[,gsub("_em", "_om", em_names[i])])/
##            results[,gsub("_em", "_om", em_names[i])]
##             ))
## names(results_re) <- gsub("_em", "_re", em_names)
## results_re$B <- results$B
## results_re$L <- results$L
## results_re$A <- results$A
## results_re$max_grad <- results$max_grad
## results_re$logmaxgrad <- log(results_re$max_grad)
## results_re$params_on_bound <- results$params_on_bound_em
## results_re$species <- results$species
## results_re$replicate <- results$replicate
## ## results_re <- results_re[sapply(results_re, function(x) any(is.finite(x)))]
## ## results_re <- results_re[sapply(results_re, function(x) !all(x==0))]
## ## results_re <- results_re[,
## ##                          names(results_re)[-grep("NLL",names(results_re))]]
scen.df$B.width <- round(scen.df$B.width,0)
results_re <- merge(scen.df, results_re)
results_re$B.width <- factor(results_re$B.width)
## results_long <- reshape2::melt(results_re, c("B.width","A","L","replicate", "species"))
## results_long <- merge(scen.df, results_long)
#results_long$B <- factor(results_long$B, levels=paste0("B", 1:bin.n))

width <- 7; height <- 4.5
df <- subset(results_re, max_grad<.1 & params_on_bound_em<1)
df <- results_re
g <- plot_scalar_points(results, x="B", y="RunTime", color="log_max_grad",
                    vert="L", horiz="A", vert2="species")
ggsave("plots/conference_points_runtime.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="SSB_MSY_re", vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
    ylab("Relative Error: MSY")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_MSY.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="L_at_Amin_Fem_GP_1_re",vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
        ylab("Relative Error: Lmin")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_Lmin.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="L_at_Amax_Fem_GP_1_re",vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
    ylab("Relative Error: Linf")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_Linf.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="VonBert_K_Fem_GP_1_re",vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
    ylab("Relative Error: VB k")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_vbK.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="CV_young_Fem_GP_1_re",vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
    ylab("Relative Error: CV young")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_CVyoung.png", g, width=width, height=height)
g <- plot_scalar_boxplot(df, x="B.width", y="CV_old_Fem_GP_1_re",vert2="species",
                    horiz="A", vert="L", relative=TRUE) +
    ylab("Relative Error: CV old")+xlab("Bin Width (cm)")
ggsave("plots/conference_boxplots_CVold.png", g, width=width, height=height)
plot_scalar_points(results_re, x="CV_young_Fem_GP_1_re", horiz="A",
                   vert="L", vert2="species",
                   y="CV_old_Fem_GP_1_re", col="logmaxgrad")
plot_scalar_points(results_re, x="CV_young_Fem_GP_1_re", horiz="A",
                   vert="L", vert2="species",
                   y="CV_old_Fem_GP_1_re", col="params_on_bound")
plot_scalar_points(df, x="CV_young_Fem_GP_1_re", horiz="A",
                   vert="L", vert2="species",
                   y="CV_old_Fem_GP_1_re", col="logmaxgrad")
plot_scalar_points(df, x="CV_young_Fem_GP_1_re", horiz="A",
                   vert="L", vert2="species",
                   y="CV_old_Fem_GP_1_re", col="params_on_bound")

pairs(results_re[,c(7:11)], ylim=c(-1,1))
g <- plot_scalar_boxplot(results, x="B.width", y="RunTime")

## Make exploratory plots
ggplot(results_long, aes(x=B.width, y=value))+ ylab("relative error")+
    geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    xlab("bin width")
ggsave("plots/bin_test_cod_D0.png", width=9, height=5)
ggplot(subset(results_long, D=="D1"), aes(x=B.width, y=value, colour=D))+ ylab("relative error")+
    geom_line(aes(group=replicate))+facet_wrap("variable", scales="fixed") + ylim(-1,1) +
    xlab("bin width")
ggsave("plots/bin_test_cod_D1.png", width=9, height=5)


## ## Look at a couple of models closer using r4ss
## res.list <- NULL
## for(i in 1:length(scen)){
##     res.list[[i]] <- SS_output(paste0(scen[i], "/1/em"), covar=FALSE)
## }
## for(i in 1:length(scen)){
##     SSplotComps(res.list[[i]], print=TRUE)
## }
## for(i in 1:length(scen)){
##     SS_plots(res.list[[i]], png=TRUE, uncer=F, html=F)
## }

## ## Clean up everything
## unlink(scen, TRUE)
## file.remove(c("ss3sim_scalar.csv", "ss3sim_ts.csv"))
## rm(results, results_re, results_long, scen.df, scen, em_names, bin.seq, bin.n, x, i)
## ## End of tail compression run
### ------------------------------------------------------------

