### This file is the central place to develop and then run the analysis for
### the paper. It sources other files that do particular tasks.

### In progress!

### ------------------------------------------------------------
## Prepare the workspace by loading packages and defining global settings
## used throughout
case_folder <- 'cases'
devtools::install('../ss3sim') # may need this for parallel runs??
## devtools::load_all("../ss3sim")
library(reshape2)
library(ss3sim)
source("startup.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Create case files dynamically for reproducibility
## file.copy(from=paste0("../ss3models/cases/", c("F0-yel", "F1-yel", "F2-yel"), ".txt"),
##           to=paste0("cases", c("F0-yel", "F1-yel", "F2-yel"), ".txt"))
species <- 'cos'
om.cos <- paste0("../ss3models/", species, "-om/")
em.cos <- paste0("../ss3models/", species, "-em/")
source("write_casefiles.R")
### ------------------------------------------------------------

### ------------------------------------------------------------
## Deterministic scenarios for data binning cases
scenarios.E <- expand_scenarios(cases=list(D=102, F=1, I=0, B=1:2), species=species)
scenarios.I <- expand_scenarios(cases=list(D=102, F=1, I=1:2, B=0), species=species)
scenarios <- c(scenarios.E, scenarios.I)[2]
case_files <- list(F="F", B="em_binning", I="data", D=c("index","lcomp","agecomp","calcomp"))
devtools::load_all("../ss3sim")
unlink(scenarios, TRUE)
run_ss3sim(iterations=1, scenarios=scenarios,
           parallel=F, user_recdevs=user.recdevs,
           case_folder=case_folder, om_dir=om.cos,
           em_dir=em.cos, case_files=case_files, call_change_data=TRUE)
## Read in results
get_results_all(dir=getwd(), user_scenarios=scenarios, parallel=TRUE, over=TRUE)
write.csv(det.bin.ts, "results/det.bin.ts.csv")
write.csv(det.bin.sc, "results/det.bin.sc.csv")
file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))

## quick plots for checking performance
det.bin.sc <- subset(calculate_re(read.csv("results/det.bin.sc.csv"), add=TRUE),
       select=c("ID", "species", "D", "replicate", "L_at_Amin_Fem_GP_1_re","L_at_Amax_Fem_GP_1_re",
       "VonBert_K_Fem_GP_1_re","CV_young_Fem_GP_1_re", "CV_old_Fem_GP_1_re",
       "depletion_re", "SSB_MSY_re", "params_on_bound_em", "max_grad") )
det.bin.ts <-
    subset(calculate_re(read.csv("results/det.bin.ts.csv"), add=TRUE),
           select=c("ID","species", "D", "replicate", "year","SpawnBio_re",
           "Recruit_0_re", "F_re"))
## Put all data together into long form for plotting
det.bin.sc.long <- reshape2::melt(det.bin.sc, id.vars=
        c("ID","species", "D", "replicate", "max_grad", "params_on_bound_em"))
det.bin.ts.long <- melt(det.bin.ts, id.vars=c("ID","species", "D", "replicate", "year"))
det.bin.ts.long <- merge(x=det.bin.ts.long, y= subset(det.bin.sc.long,
                         select=c("ID", "params_on_bound_em", "max_grad")),
                         by="ID")
levels(det.bin.sc.long$variable) <- gsub("_Fem_GP_1_re|_re", "", levels(det.bin.sc.long$variable))
levels(det.bin.ts.long$variable) <- gsub("_re", "", levels(det.bin.ts.long$variable))
plot_scalar_points(det.bin.sc.long, x="variable", y='value',
                   horiz='species', rel=TRUE, color='max_grad')
ggsave("plots/new_models_scalars.png", width=9, height=7)
plot_ts_lines(det.bin.ts.long, vert="variable", y='value', horiz='ID',
              rel=TRUE, color="max_grad")
ggsave("plots/new_models_TS.png", width=9, height=7)
plyr::ddply(det.bin.sc.long, .(species), summarize,
            median.maxgrad=round(median(max_grad),2),
            max.bounds=max(params_on_bound_em))
## End of determinstic scenarios with binning functions
### ------------------------------------------------------------




library(r4ss)
xx <- SS_output(dir="B0-D100-E0-F1-I1-cos/1/em", covar=FALSE, forecast=FALSE)
SS_plots(xx, png=TRUE, uncertainty=FALSE)

source("load_results.R")

source("make_tables.R")
source("make_figures.R")



### ------------------------------------------------------------
## OLD CODE
## ### ------------------------------------------------------------
## ## Deterministic scenarios for data cases used
## scenarios <- expand_scenarios(cases=list(D=100:102,F=1), species=species)
## case_files <- list(F="F", E="E", D=c("index","lcomp","agecomp","calcomp"))
## a <- get_caseargs(folder = case_folder, scenario = scenarios[1], case_files = case_files)
## ## devtools::load_all("../ss3sim")
## ## devtools::install("../ss3sim"); library(ss3sim)
## ## unlink(scenarios, TRUE)
## run_ss3sim(iterations=1:15, scenarios=scenarios,
##            parallel=TRUE, user_recdevs=user.recdevs,
##            case_folder=case_folder, om_dir=om.cos,
##            em_dir=em.cos, case_files=case_files)
## ## Read in results
## get_results_all(dir=getwd(), user_scenarios=scenarios, parallel=F, over=TRUE)
## det.ts <- calculate_re(read.csv("ss3sim_ts.csv"), add=TRUE)
## det.sc <- calculate_re(read.csv("ss3sim_scalar.csv"), add=TRUE)
## write.csv(det.ts, "results/det.ts.csv")
## write.csv(det.sc, "results/det.sc.csv")
## file.remove(c('ss3sim_ts.csv', 'ss3sim_scalar.csv'))
## ### ------------------------------------------------------------
