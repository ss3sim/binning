## Source thsi file to make the tables, note it creates csv files in the
## results folder

## table of converged binning scenarios
write.csv(dcast(binning.counts, value.var='pct.converged',
                formula=species+data~B), file="results/table_binning_convergence.csv")
