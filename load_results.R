## Source this data to load in the results and do any processing before
## making figures and tables.

## make a table with better names for merging into the main results; used
## really only for plotting and needs to be specific for each species
bin.cases.df <-
    data.frame(species=c('cod'),
               dat.bin=paste0("dat.bin=",c(1,2,4,13,2,4,13)),
               pop.bin=paste0("pop.bin=", c(1,1,1,1,2,4,13)),
               B=paste0("B",c(0:3, 11:13)))

tcomp.cases.df <-
    data.frame(species=c('cod'),
               dat.bin=paste0("dat.bin=",c(1,4,13,1,4,13,1,4,13,1,4,13,1,4,13,1,4,13)),
               tcomp=paste0("tail.comp=", rep(c(0.01,seq(0.05,0.25,0.05)), each=3)),
               B=paste0("B",rep(c(0,2,3), 6)))

robust.cases.df <-
    data.frame(species=c('cod'),
               dat.bin=paste0("dat.bin=",c(1,4,13,1,4,13,1,4,13,1,4,13,1,4,13)),
               robust=paste0("robust=", rep(c(1e-5,1e-4,1e-3,1e-2,1e-1), each=3)),
               B=paste0("B",rep(c(0,2,3), 5)))


### ------------------------------------------------------------
## binning section
results.sc <- read.csv("results/results.sc.csv")
(scenario.counts <- ddply(results.sc, .(scenario), summarize, replicates=length(scenario)))
results.sc$log_max_grad <- log(results.sc$max_grad)
results.sc$converged <- ifelse(results.sc$max_grad<.1, "yes", "no")
results.sc <- calculate_re(results.sc, add=TRUE)
results.sc$runtime <- results.sc$RunTime
results.sc <- merge(results.sc, bin.cases.df, by=c("species", "B"))
## Drop fixed params (columns of zeroes)
results.sc$RecrDist_GP_1_re <- NULL
results.sc <- results.sc[,-which(apply(results.sc, 2, function(x) all(x==0)))]
re.names <- names(results.sc)[grep("_re", names(results.sc))]
results.sc.long <-
    melt(results.sc, measure.vars=re.names, id.vars=
             c("species","replicate", "D", "B", "dat.bin",
               "pop.bin", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
results.sc.long.growth <- droplevels(subset(results.sc.long, variable %in% growth.names))
results.sc.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", results.sc.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
results.sc.long.selex <- droplevels(subset(results.sc.long, variable %in% selex.names))
results.sc.long.selex$variable <- gsub("ery|ey|Size|_re", "", results.sc.long.selex$variable)
results.sc.long.selex$variable <- gsub("_", ".", results.sc.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
results.sc.long.management <- droplevels(subset(results.sc.long, variable %in% management.names))
results.sc.long.management$variable <- gsub("_re", "", results.sc.long.management$variable)

## tail compression
results.sc.tcomp <- read.csv("results/results_tcomp.sc.csv")
(scenario.counts <- ddply(results.sc.tcomp, .(scenario), summarize, replicates=length(scenario)))
results.sc.tcomp$log_max_grad <- log(results.sc.tcomp$max_grad)
results.sc.tcomp$converged <- ifelse(results.sc.tcomp$max_grad<.1, "yes", "no")
results.sc.tcomp <- calculate_re(results.sc.tcomp, add=TRUE)
results.sc.tcomp$runtime <- results.sc.tcomp$RunTime
results.sc.tcomp <- merge(results.sc.tcomp, tcomp.cases.df, by=c("species", "B"))
## Drop fixed params (columns of zeroes)
results.sc.tcomp$RecrDist_GP_1_re <- NULL
results.sc.tcomp <- results.sc.tcomp[,-which(apply(results.sc.tcomp, 2, function(x) all(x==0)))]
re.names <- names(results.sc.tcomp)[grep("_re", names(results.sc.tcomp))]
results.sc.tcomp.long <-
    melt(results.sc.tcomp, measure.vars=re.names, id.vars=
             c("species","replicate", "D", "B", "dat.bin",
               "tcomp", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
results.sc.tcomp.long.growth <- droplevels(subset(results.sc.tcomp.long, variable %in% growth.names))
results.sc.tcomp.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", results.sc.tcomp.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
results.sc.tcomp.long.selex <- droplevels(subset(results.sc.tcomp.long, variable %in% selex.names))
results.sc.tcomp.long.selex$variable <- gsub("ery|ey|Size|_re", "", results.sc.tcomp.long.selex$variable)
results.sc.tcomp.long.selex$variable <- gsub("_", ".", results.sc.tcomp.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
results.sc.tcomp.long.management <- droplevels(subset(results.sc.tcomp.long, variable %in% management.names))
results.sc.tcomp.long.management$variable <- gsub("_re", "", results.sc.tcomp.long.management$variable)

## robustification
results.sc.robust <- read.csv("results/results_robust.sc.csv")
(scenario.counts <- ddply(results.sc.robust, .(scenario), summarize, replicates=length(scenario)))
results.sc.robust$log_max_grad <- log(results.sc.robust$max_grad)
results.sc.robust$converged <- ifelse(results.sc.robust$max_grad<.1, "yes", "no")
results.sc.robust <- calculate_re(results.sc.robust, add=TRUE)
results.sc.robust$runtime <- results.sc.robust$RunTime
results.sc.robust <- merge(results.sc.robust, robust.cases.df, by=c("species", "B"))
## Drop fixed params (columns of zeroes)
results.sc.robust$RecrDist_GP_1_re <- NULL
results.sc.robust <- results.sc.robust[,-which(apply(results.sc.robust, 2, function(x) all(x==0)))]
re.names <- names(results.sc.robust)[grep("_re", names(results.sc.robust))]
results.sc.robust.long <-
    melt(results.sc.robust, measure.vars=re.names, id.vars=
             c("species","replicate", "D", "B", "dat.bin",
               "robust", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
results.sc.robust.long.growth <- droplevels(subset(results.sc.robust.long, variable %in% growth.names))
results.sc.robust.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", results.sc.robust.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
results.sc.robust.long.selex <- droplevels(subset(results.sc.robust.long, variable %in% selex.names))
results.sc.robust.long.selex$variable <- gsub("ery|ey|Size|_re", "", results.sc.robust.long.selex$variable)
results.sc.robust.long.selex$variable <- gsub("_", ".", results.sc.robust.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re", "Catch_endyear_re")
results.sc.robust.long.management <- droplevels(subset(results.sc.robust.long, variable %in% management.names))
results.sc.robust.long.management$variable <- gsub("_re", "", results.sc.robust.long.management$variable)

## results.ts <- read.csv("results/results.ts.csv")
## results.ts.long <- melt(results.ts, id.vars=c("ID","species", "D", 'I', "B", "replicate", "year"))
## results.ts.long <- merge(x=results.ts.long, y= subset(results.sc.long,
##                          select=c("ID", "params_on_bound_em", "max_grad")),
##                          by="ID")
## levels(results.ts.long$variable) <- gsub("_re", "", levels(results.ts.long$variable))
## results.ts$bin_method <- ifelse(results.ts$B=="B0", "Internal", "External")
## results.ts$bin_width <- ifelse(results.ts$I=="I1" | results.ts$B=="B1", "2cm", "20cm")
## ## ------------------------------------------------------------
