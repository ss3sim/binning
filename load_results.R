## Source this data to load in the results and do any processing before
## making figures and tables.

## Load the results from section 1
Linf.df <- data.frame(species=factor(c('cod', 'flatfish', 'yellow')), Linf=c(132,47,62))
popbins.binwidth <- readRDS(file='results/popbins.binwidth.RData')
popbins.minsize <- readRDS(file='results/popbins.minsize.RData')
popbins.maxsize <- readRDS(file='results/popbins.maxsize.RData')
popbins.maxsize <- merge(Linf.df, popbins.maxsize, by='species')
popbins.maxsize$max.Linf.ratio <- with(popbins.maxsize, maxsize/Linf)

###  ------------------------------------------------------------
### Step 1: Make some quick data.frames to rename ggplot factors
bin.cases.df <-
    rbind(data.frame(species=c('cod'),
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
data.cases.df <-
    data.frame(D=paste0("D",D.binning), data=c("Rich; A+L", "Rich; C+L", "Poor; A+L", "Poor; C+L"))
tcomp.cases.df <-
    data.frame(species=rep(c('cod','flatfish','yellow'),each=4),
               tvalue=paste0("tcomp=", c(-1, 1e-3, 0.01, 0.1)),
               I=paste0("I",11:14))
robust.cases.df <-
    data.frame(species=rep(c('cod','flatfish','yellow'),each=4),
               rvalue=paste0("robust=", c(1e-10,1e-5,1e-3,0.01)),
               I=paste0("I", 21:24))
## reorder for plotting
bin.cases.df$pbin <- factor(bin.cases.df$pbin, levels= c("pbin=1",  "pbin=2", "pbin=4" , "pbin=5",
                             "pbin=10",  "pbin=12", "pbin=20", "pbin=24"))
bin.cases.df$dbin <- factor(bin.cases.df$dbin, levels=c("dbin=1",  "dbin=2", "dbin=4" , "dbin=5",
                             "dbin=10",  "dbin=12", "dbin=20", "dbin=24"))
data.cases.df$data <- factor(data.cases.df$data, levels=c("Rich; A+L", "Rich; C+L", "Poor; A+L", "Poor; C+L"))
robust.cases.df$rvalue <- factor(robust.cases.df$rvalue,
          levels=c("robust=1e-10", "robust=1e-05", "robust=0.001",
          "robust=0.01"))
### End renaming data.frames
### ------------------------------------------------------------

### ------------------------------------------------------------
### Step 2: Load and prep the binning results
## binning section
binning <- readRDS("results/results_binning.sc.RData")
binning$log_max_grad <- log(binning$max_grad)
binning$converged <- ifelse(binning$max_grad<.1 & binning$params_on_bound_em==0, "yes", "no")
binning <- calculate_re(binning, add=TRUE)
binning$runtime <- (binning$RunTime)
binning <- merge(binning, bin.cases.df, by=c("species", "B"))
binning <- merge(binning, data.cases.df, by=c("D"))
binning$binmatch <- with(binning, ifelse(pbin=="pbin=1" & dbin!="dbin=1", "no match", "match"))
binning.counts <- ddply(binning, .(data,B, species), summarize,
                          replicates=length(scenario),
                          pct.converged=100*mean(converged=="yes"))
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
binning.ts <- readRDS("results/results_binning.ts.RData")
binning.ts <- merge(binning.ts, subset(binning.unfiltered, select=c("ID",'converged')), by="ID")
binning.ts <- merge(binning.ts, bin.cases.df, by=c("species", "B"))
binning.ts <- merge(binning.ts, data.cases.df, by=c("D"))
binning.ts <- subset(binning.ts, converged=="yes")
binning.ts <- calculate_re(binning.ts, add=TRUE)
## End of binning results
### ------------------------------------------------------------


### ------------------------------------------------------------
### Step 3: Load and prep the tail compression and robustification data
## tail compression
tcomp <- readRDS("results/results_tcomp.sc.RData")
tcomp$log_max_grad <- log(tcomp$max_grad)
tcomp$converged <- ifelse(tcomp$max_grad<.1 & tcomp$params_on_bound_em==0, "yes", "no")
tcomp <- calculate_re(tcomp, add=TRUE)
tcomp$runtime <- tcomp$RunTime
tcomp <- merge(tcomp, tcomp.cases.df, by=c("species", "I"))
tcomp <- merge(tcomp, data.cases.df, by=c("D"))
tcomp.counts <- ddply(tcomp, .(tvalue,B,data, species), summarize,
                          replicates=length(scenario),
                          pct.converged=100*mean(converged=="yes"))
## Drop fixed params (columns of zeroes)
tcomp$RecrDist_GP_1_re <- NULL
tcomp <- tcomp[,-which(apply(tcomp, 2, function(x) all(x==0)))]
re.names <- names(tcomp)[grep("_re", names(tcomp))]
tcomp.unfiltered <- tcomp
tcomp <- subset(tcomp, converged=="yes")
tcomp.long <-
    melt(tcomp, measure.vars=re.names, id.vars=
             c("species","replicate", "data", "B", "tvalue",
               "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
tcomp.long.growth <- droplevels(subset(tcomp.long, variable %in% growth.names))
tcomp.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", tcomp.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
tcomp.long.selex <- droplevels(subset(tcomp.long, variable %in% selex.names))
tcomp.long.selex$variable <- gsub("ery|ey|Size|_re", "", tcomp.long.selex$variable)
tcomp.long.selex$variable <- gsub("_", ".", tcomp.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re")
tcomp.long.management <- droplevels(subset(tcomp.long, variable %in% management.names))
tcomp.long.management$variable <- gsub("_re", "", tcomp.long.management$variable)
## robustification
robust <- readRDS("results/results_robust.sc.RData")
robust$log_max_grad <- log(robust$max_grad)
robust$converged <- ifelse(robust$max_grad<.1 & robust$params_on_bound_em==0, "yes", "no")
robust <- calculate_re(robust, add=TRUE)
robust$runtime <- robust$RunTime
robust <- merge(robust, robust.cases.df, by=c("species", "I"))
robust <- merge(robust, data.cases.df, by=c("D"))
robust.unfiltered <- robust
robust <- subset(robust, converged=="yes")
robust.counts <- ddply(robust.unfiltered, .(rvalue, B, species, data), summarize,
                          replicates=length(scenario),
                          pct.converged=100*mean(converged=="yes"))
## Drop fixed params (columns of zeroes)
robust$RecrDist_GP_1_re <- NULL
robust <- robust[,-which(apply(robust, 2, function(x) all(x==0)))]
re.names <- names(robust)[grep("_re", names(robust))]
robust.long <-
    melt(robust, measure.vars=re.names, id.vars=
             c("species","replicate", "data", "B",
               "rvalue", "log_max_grad", "params_on_bound_em",
               "runtime"))
growth.names <- re.names[grep("GP_", re.names)]
robust.long.growth <- droplevels(subset(robust.long, variable %in% growth.names))
robust.long.growth$variable <- gsub("_Fem_GP_1_re|_re", "", robust.long.growth$variable)
selex.names <- re.names[grep("Sel_", re.names)]
robust.long.selex <- droplevels(subset(robust.long, variable %in% selex.names))
robust.long.selex$variable <- gsub("ery|ey|Size|_re", "", robust.long.selex$variable)
robust.long.selex$variable <- gsub("_", ".", robust.long.selex$variable)
management.names <- c("SSB_MSY_re", "depletion_re", "SSB_Unfished_re")
robust.long.management <- droplevels(subset(robust.long, variable %in% management.names))
robust.long.management$variable <- gsub("_re", "", robust.long.management$variable)
## End tcomp and robust
### ------------------------------------------------------------
