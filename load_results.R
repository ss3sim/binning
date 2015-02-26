## Source this data to load in the results and do any processing before
## making figures and tables.


### ------------------------------------------------------------
## binning section
results.sc <- read.csv("results/results.sc.csv")
(scenario.counts <- ddply(results.sc, .(scenario), summarize, replicates=length(scenario)))
results.sc$log_max_grad <- log(results.sc$max_grad)
results.sc$converged <- ifelse(results.sc$max_grad<.1, "yes", "no")
results.sc <- calculate_re(results.sc, add=TRUE)
results.sc$method <- ifelse(results.sc$B=="B0", "Internal", "External")
results.sc$width <- as.numeric(gsub("B", "", results.sc$B))+as.numeric(gsub("I", "", results.sc$I))
results.sc$runtime <- results.sc$RunTime
## Drop fixed params (columns of zeroes)
results.sc <- results.sc[,-which(apply(results.sc, 2, function(x) all(x==0)))]
re.names <- names(results.sc)[grep("_re", names(results.sc))]
results.sc.long <-
    melt(results.sc, measure.vars=re.names,
         id.vars= c("species","replicate", "D", "I", "B", "method",
         "width", "log_max_grad", "params_on_bound_em", "runtime"))
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



## results.ts <- read.csv("results/results.ts.csv")
## results.ts.long <- melt(results.ts, id.vars=c("ID","species", "D", 'I', "B", "replicate", "year"))
## results.ts.long <- merge(x=results.ts.long, y= subset(results.sc.long,
##                          select=c("ID", "params_on_bound_em", "max_grad")),
##                          by="ID")
## levels(results.ts.long$variable) <- gsub("_re", "", levels(results.ts.long$variable))
## results.ts$bin_method <- ifelse(results.ts$B=="B0", "Internal", "External")
## results.ts$bin_width <- ifelse(results.ts$I=="I1" | results.ts$B=="B1", "2cm", "20cm")
## ## ------------------------------------------------------------
