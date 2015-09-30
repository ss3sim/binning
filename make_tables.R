## Source thsi file to make the tables, note it creates csv files in the#
# results folder

## table of MARES since now dropped from the paper
mare.table.long <- ddply(binning.long.figure, .(species,data,binmatch,variable, data.binwidth),
           summarize,
            median_ = median(value, na.rm = TRUE),
            l2      = quantile(value, 0.25, na.rm = TRUE),
            u2      = quantile(value, 0.75, na.rm = TRUE),
           mare    = 100 * round(median(abs(value), na.rm = TRUE), 3),
           pct.converged=pct.converged[1],
           count = length(value))
## cast it into wide for easier reading
mare.table.long$binmatch <- ifelse(mare.table.long$binmatch=='pbin=1cm', 'Match', 'No Match')
str(mare.table.long)
mare.table.wide <- reshape2::dcast(mare.table.long,
                              formula=species+data+variable+binmatch~data.binwidth,
                              value.var='mare')
write.csv(mare.table.wide, 'results/table_mares.csv')

## tried a quick test of plotting age vs CAAL but didn't really help understand
## datatype <- rep("Age", nrow(mare.table.long))
## datatype[grep("C", as.character(mare.table.long$data))] <- "CAAL"
## dataquant <- rep("Rich", nrow(mare.table.long))
## dataquant[grep("Poor", as.character(mare.table.long$data))] <- "Limited"
## mare.table.long$datatype <- datatype
## mare.table.long$dataquant <- dataquant
## mare.table.data <- reshape2::dcast(mare.table.long,
##                               formula=species+data.binwidth+variable+binmatch+dataquant~datatype,
##                               value.var='mare')
## mare.table.data <- subset(mare.table.data, binmatch=='No Match' | data.binwidth==1)
## ggplot(mare.table.data, aes(Age, CAAL, color=data.binwidth))+geom_point() + facet_grid(species~dataquant+variable)

## table of converged binning scenarios
write.table(dcast(binning.counts, value.var='pct.converged',
                formula=species+data+binmatch~data.binwidth),
            file="results/table_binning_convergence.csv",
            sep=",", row.names=FALSE)

## table of run time
binning.runtime.table <- dcast(binning.runtime, value.var='median.runtime', formula=species+data~B)
## divide by B0 to standardize across species and scenarios
binning.runtime.table[,-(1:2)] <- 100*round(binning.runtime.table[,-(1:2)]/binning.runtime.table[,3],2)
write.table(x=binning.runtime.table,
            file='results/table_binning_runtime.csv', sep=',',
            row.names=FALSE)


binning.growth.table <- dcast(ddply(binning.long.growth, .(species, data, B, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~B)
write.table(x=binning.growth.table,
            file='results/table_binning_growth.csv', sep=',',
            row.names=FALSE)
binning.selex.table <- dcast(ddply(binning.long.selex, .(species, data, B, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~B)
write.table(x=binning.selex.table,
            file='results/table_binning_selex.csv', sep=',',
            row.names=FALSE)
binning.management.table <- dcast(ddply(binning.long.management, .(species, data, B, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~B)
write.table(x=binning.management.table,
            file='results/table_binning_management.csv', sep=',',
            row.names=FALSE)

## tcomp.growth.table <- dcast(ddply(tcomp.long.growth, .(species, data, tvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
## write.table(x=tcomp.growth.table,
##             file='results/table_tcomp_growth.csv', sep=',',
##             row.names=FALSE)
## tcomp.selex.table <- dcast(ddply(tcomp.long.selex, .(species, data, tvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
## write.table(x=tcomp.selex.table,
##             file='results/table_tcomp_selex.csv', sep=',',
##             row.names=FALSE)
## tcomp.management.table <- dcast(ddply(tcomp.long.management, .(species, data, tvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
## write.table(x=tcomp.management.table,
##             file='results/table_tcomp_management.csv', sep=',',
##             row.names=FALSE)


## robust.growth.table <- dcast(ddply(robust.long.growth, .(species, data, rvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
## write.table(x=robust.growth.table,
##             file='results/table_robust_growth.csv', sep=',',
##             row.names=FALSE)
## robust.selex.table <- dcast(ddply(robust.long.selex, .(species, data, rvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
## write.table(x=robust.selex.table,
##             file='results/table_robust_selex.csv', sep=',',
##             row.names=FALSE)
## robust.management.table <- dcast(ddply(robust.long.management, .(species, data, rvalue, variable), summarize,
##       median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
## write.table(x=robust.management.table,
##             file='results/table_robust_management.csv', sep=',',
##             row.names=FALSE)

