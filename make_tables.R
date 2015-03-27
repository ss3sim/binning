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

tcomp.growth.table <- dcast(ddply(tcomp.long.growth, .(species, data, tvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
write.table(x=tcomp.growth.table,
            file='results/table_tcomp_growth.csv', sep=',',
            row.names=FALSE)
tcomp.selex.table <- dcast(ddply(tcomp.long.selex, .(species, data, tvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
write.table(x=tcomp.selex.table,
            file='results/table_tcomp_selex.csv', sep=',',
            row.names=FALSE)
tcomp.management.table <- dcast(ddply(tcomp.long.management, .(species, data, tvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~tvalue)
write.table(x=tcomp.management.table,
            file='results/table_tcomp_management.csv', sep=',',
            row.names=FALSE)


robust.growth.table <- dcast(ddply(robust.long.growth, .(species, data, rvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
write.table(x=robust.growth.table,
            file='results/table_robust_growth.csv', sep=',',
            row.names=FALSE)
robust.selex.table <- dcast(ddply(robust.long.selex, .(species, data, rvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
write.table(x=robust.selex.table,
            file='results/table_robust_selex.csv', sep=',',
            row.names=FALSE)
robust.management.table <- dcast(ddply(robust.long.management, .(species, data, rvalue, variable), summarize,
      median.re=round(median(value),3)), value.var="median.re", formula=species+data+variable~rvalue)
write.table(x=robust.management.table,
            file='results/table_robust_management.csv', sep=',',
            row.names=FALSE)

