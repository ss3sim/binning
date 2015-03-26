## Source thsi file to make the tables, note it creates csv files in the
## results folder

## table of converged binning scenarios
write.table(dcast(binning.counts, value.var='pct.converged',
                formula=species+data~B),
            file="results/table_binning_convergence.csv",
            sep=",", row.names=FALSE)

## table of run time
binning.runtime.table <- dcast(binning.runtime, value.var='median.runtime', formula=species+data~B)
## divide by B0 to standardize across species and scenarios
binning.runtime.table[,-(1:2)] <- 100*round(binning.runtime.table[,-(1:2)]/binning.runtime.table[,3],2)
write.table(x=binning.runtime.table,
            file='results/table_binning_runtime.csv', sep=',',
            row.names=FALSE)


