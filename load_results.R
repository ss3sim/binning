## Source this data to load in the results and do any processing before
## making figures and tables.

## make a table with better names for merging into the main results; used
## really only for plotting and needs to be specific for each species
bin.cases.df <-
    rbind(
        data.frame(species=c('cod'),
                   dbin=paste0("dbin=",c(1,2,4,12,24, 2,4,12,24)),
                   pbin=paste0("pbin=", c(1,1,1,1,1, 2,4,12,24)),
                   B=paste0("B",B.binning)),
        data.frame(species=c('flatfish'),
                   dbin=paste0("dbin=",c(1,2,5,10,20, 2,5,10,20)),
                   pbin=paste0("pbin=", c(1,1,1,1,1, 2,5,10,20)),
                   B=paste0("B",B.binning)),
        data.frame(species=c('yellow'),
                   dbin=paste0("dbin=",c(1,2,4,12,24, 2,4,12,24)),
                   pbin=paste0("pbin=", c(1,1,1,1,1, 2,4,12,24)),
                   B=paste0("B",B.binning)))
data.cases.df <- data.frame(D=paste0("D",D.binning), data=c("Rich; A+L", "Rich; C+L",
                                         "Poor; A+L", "Poor; C+L"))

tcomp.cases.df <-
    data.frame(species=c('cod'),
               dbin=paste0("dbin=",c(1,4,13,1,4,13,1,4,13,1,4,13,1,4,13,1,4,13)),
               tcomp=paste0("tail.comp=", rep(c(0.01,seq(0.05,0.25,0.05)), each=3)),
               B=paste0("B",rep(c(0,2,3), 6)))
robust.cases.df <-
    data.frame(species=c('cod'),
               dbin=paste0("dbin=",c(1,4,13,1,4,13,1,4,13,1,4,13,1,4,13)),
               robust=paste0("robust=", rep(c(1e-5,1e-4,1e-3,1e-2,1e-1), each=3)),
               B=paste0("B",rep(c(0,2,3), 5)))


### ------------------------------------------------------------
## binning section
binning <- read.csv("results/results_binning.sc.csv")
binning$log_max_grad <- log(binning$max_grad)
binning$converged <- ifelse(binning$max_grad<.1, "yes", "no")
(scenario.counts <- ddply(binning, .(scenario), summarize,
                          replicates=length(scenario),
                          pct.converged=100*mean(converged=="yes")))
binning <- calculate_re(binning, add=TRUE)
binning$runtime <- binning$RunTime
binning <- merge(binning, bin.cases.df, by=c("species", "B"))
binning <- merge(binning, data.cases.df, by=c("D"))
## reorder for plotting
binning$pbin <- factor(binning$pbin, levels= c("pbin=1",  "pbin=2", "pbin=4" , "pbin=5",
                             "pbin=10",  "pbin=12", "pbin=20", "pbin=24"))
binning$dbin <- factor(binning$dbin, levels=c("dbin=1",  "dbin=2", "dbin=4" , "dbin=5",
                             "dbin=10",  "dbin=12", "dbin=20", "dbin=24"))
binning$data <- factor(binning$data, levels=c("Rich; A+L", "Rich; C+L", "Poor; A+L", "Poor; C+L"))
## Drop fixed params (columns of zeroes)
binning$RecrDist_GP_1_re <- NULL
binning <- binning[,-which(apply(binning, 2, function(x) all(x==0)))]
binning.unfiltered <- binning           # before subetting by convergence
binning <- droplevels(subset(binning, converged=="yes"))
re.names <- names(binning)[grep("_re", names(binning))]
binning.long <-
    melt(binning, measure.vars=re.names, id.vars=
             c("species","replicate", "data", "B", "dbin",
               "pbin", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
binning.long.growth <- droplevels(subset(binning.long, variable %in% growth.names))
binning.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", binning.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
binning.long.selex <- droplevels(subset(binning.long, variable %in% selex.names))
binning.long.selex$variable <- gsub("ery|ey|Size|_re", "", binning.long.selex$variable)
binning.long.selex$variable <- gsub("_", ".", binning.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
binning.long.management <- droplevels(subset(binning.long, variable %in% management.names))
binning.long.management$variable <- gsub("_re", "", binning.long.management$variable)
## End of binning results
### ------------------------------------------------------------



## tail compression
tcomp <- read.csv("results/results_tcomp.sc.csv")
(scenario.counts <- ddply(tcomp, .(scenario), summarize, replicates=length(scenario)))
tcomp$log_max_grad <- log(tcomp$max_grad)
tcomp$converged <- ifelse(tcomp$max_grad<.1, "yes", "no")
tcomp <- calculate_re(tcomp, add=TRUE)
tcomp$runtime <- tcomp$RunTime
tcomp <- merge(tcomp, tcomp.cases.df, by=c("species", "B"))
## Drop fixed params (columns of zeroes)
tcomp$RecrDist_GP_1_re <- NULL
tcomp <- tcomp[,-which(apply(tcomp, 2, function(x) all(x==0)))]
re.names <- names(tcomp)[grep("_re", names(tcomp))]
tcomp.long <-
    melt(tcomp, measure.vars=re.names, id.vars=
             c("species","replicate", "D", "B", "dbin",
               "tcomp", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
tcomp.long.growth <- droplevels(subset(tcomp.long, variable %in% growth.names))
tcomp.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", tcomp.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
tcomp.long.selex <- droplevels(subset(tcomp.long, variable %in% selex.names))
tcomp.long.selex$variable <- gsub("ery|ey|Size|_re", "", tcomp.long.selex$variable)
tcomp.long.selex$variable <- gsub("_", ".", tcomp.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
tcomp.long.management <- droplevels(subset(tcomp.long, variable %in% management.names))
tcomp.long.management$variable <- gsub("_re", "", tcomp.long.management$variable)

## robustification
robust <- read.csv("results/results_robust.sc.csv")
(scenario.counts <- ddply(robust, .(scenario), summarize, replicates=length(scenario)))
robust$log_max_grad <- log(robust$max_grad)
robust$converged <- ifelse(robust$max_grad<.1, "yes", "no")
robust <- calculate_re(robust, add=TRUE)
robust$runtime <- robust$RunTime
robust <- merge(robust, robust.cases.df, by=c("species", "B"))
## Drop fixed params (columns of zeroes)
robust$RecrDist_GP_1_re <- NULL
robust <- robust[,-which(apply(robust, 2, function(x) all(x==0)))]
re.names <- names(robust)[grep("_re", names(robust))]
robust.long <-
    melt(robust, measure.vars=re.names, id.vars=
             c("species","replicate", "D", "B", "dbin",
               "robust", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
robust.long.growth <- droplevels(subset(robust.long, variable %in% growth.names))
robust.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", robust.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
robust.long.selex <- droplevels(subset(robust.long, variable %in% selex.names))
robust.long.selex$variable <- gsub("ery|ey|Size|_re", "", robust.long.selex$variable)
robust.long.selex$variable <- gsub("_", ".", robust.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
robust.long.management <- droplevels(subset(robust.long, variable %in% management.names))
robust.long.management$variable <- gsub("_re", "", robust.long.management$variable)
### ------------------------------------------------------------
