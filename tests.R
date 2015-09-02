### ------------------------------------------------------------
## Exploratory code for reviewer comments

## Is the burnin long enough?
binning.ts <- readRDS("results/results_binning.ts.RData")
## binning.ts <- merge(binning.ts, subset(binning.unfiltered, select=c("ID",'converged')), by="ID")
## binning.ts <- merge(binning.ts, bin.cases.df, by=c("species", "B"))
## binning.ts <- merge(binning.ts, data.cases.df, by=c("D"))
## binning.ts <- subset(binning.ts, converged=="yes")
## binning.ts <- calculate_re(binning.ts, add=TRUE)

## All scenarios are identical for the OM except species of course
binning.ts.burnin <- subset(binning.ts, year %in% c(26, 100) & B=="B0" & D=="D5",
                            select=c('SpawnBio_om', 'Recruit_0_om',
                            'SpawnBio_em', 'year', 'ID'))
## binning.ts.burnin <- reshape2::melt(binning.ts.burnin, c('SpawnBio_om', 'Recruit_0_om',
##                             'SpawnBio_em', 'replicate', 'B', 'species'))
binning.ts.burnin <- reshape2::melt(binning.ts.burnin, c('ID', 'year'))
binning.ts.burnin$value <- log(binning.ts.burnin$value)
binning.ts.burnin <- reshape2::dcast(binning.ts.burnin, ID+variable~year)
names(binning.ts.burnin)[3:4] <- paste0('log_of_year', names(binning.ts.burnin)[3:4])
temp <- data.frame(do.call(rbind, strsplit(as.character(binning.ts.burnin$ID), split='-')))
names(temp) <- c('B', 'D', 'F', 'I', 'species', 'replicate')
binning.ts.burnin <- cbind(binning.ts.burnin, temp)
xnames <- names(binning.ts.burnin)[3:4]
ggplot(subset(binning.ts.burnin, variable=='Recruit_0_om'),
       aes_string(x=xnames[1], y=xnames[2], color='species')) +
    geom_point(size=1, alpha=.5) +   geom_smooth(method='lm',formula=y~x) +
        xlab("log(SSB(26)) in OM") +ylab("log(SSB(100)) in OM")
ggsave('plots/burn_in_test.png', width=7, height=5)

Nsim <- 100
spp <- 'cod'

for(spp in c('cod','yellow', 'flatfish')){
F99 <-  c('years;1:100', 'years_alter;1:100', 'fvals;rep(0,100)')
writeLines(F99, con=paste0("cases/", "F99-", spp, ".txt"))
case_files <- list(F="F", D=c("index","lcomp","agecomp"))
scenarios <- expand_scenarios(cases=list(D=2, F=99), species=spp)
## get_caseargs(case_folder, scenario=scenarios[1], case_files=case_files)
run_ss3sim(iterations=101:500, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=TRUE,
           case_folder=case_folder, om_dir=ss3model(spp, "om"),
           em_dir=ss3model(spp, "em"), case_files=case_files,
           bias_adjust=FALSE, bias_nsim=10,
           admb_options= " -maxfn 1 -phase 50",
           call_change_data=TRUE)
}
get_results_all(parallel=TRUE, over=TRUE)

xx <- read.csv("ss3sim_ts.csv")
xx <- ddply(xx, .(species), mutate, SSB_OM=SpawnBio_om/SpawnBio_om[1])
ggplot(xx, aes(factor(year), SSB_OM))+
    geom_boxplot()+facet_wrap("species", scales='free') + ylim(.5,2)
## look at variance over time
yy <- ddply(xx, .(species, year), transform, varSSB=var(SpawnBio_om))
ggplot(yy, aes(year, varSSB))+geom_line()+facet_wrap('species', scales='free')



## use ss3sim function to extend burn in for yellow model
setwd('yellow/om')
ss3sim::change_year(year_begin=1, year_end=500, burnin=0,
                    ctl_file_in='ss3.ctl',
                    ctl_file_out='ss3_new.ctl',
                    dat_file_in='ss3.dat',
                    dat_file_out='ss3_new.dat',
                    par_file_in='ss3.par',
                    par_file_out='ss3_new.par',
                    str_file_in='starter.ss',
                    str_file_out='starter_new.ss',
                    for_file_in='forecast.ss',
                    for_file_out='forecast_new.ss')
setwd('../em')
ss3sim::change_year(year_begin=1, year_end=200, burnin=0,
                    ctl_file_in='ss3.ctl',
                    ctl_file_out='ss3_new.ctl',
                    dat_file_in=NULL,
                    par_file_in=NULL,
                    str_file_in='starter.ss',
                    str_file_out='starter_new.ss',
                    for_file_in='forecast.ss',
                    for_file_out='forecast_new.ss')

setwd('C:/Users/Cole/binning/')
spp <- 'yellow'
F99 <-  c('years;1:500', 'years_alter;1:500', 'fvals;rep(0,500)')
writeLines(F99, con=paste0("cases/", "F99-", spp, ".txt"))
case_files <- list(F="F", D=c("index","lcomp","agecomp"))
scenarios <- expand_scenarios(cases=list(D=2, F=99), species=spp)
## get_caseargs(case_folder, scenario=scenarios[1], case_files=case_files)
run_ss3sim(iterations=1:500, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=TRUE,
           case_folder=case_folder, om_dir='yellow/om',
           em_dir='yellow/em', case_files=case_files,
           admb_options= " -maxfn 1 -phase 50",
           call_change_data=TRUE)
get_results_all(parallel=TRUE)

xx <- read.csv("ss3sim_ts.csv")
xx <- ddply(xx, .(species), mutate, SSB_OM=(SpawnBio_om-SpawnBio_om[1])/SpawnBio_om[1] )
plot_ts_lines(xx, y='SSB_OM', vert='species', rel=TRUE)
## look at variance over time
yy <- ddply(xx, .(species, year), transform, sdSSB=sd(SpawnBio_om), sdSSBnorm=sd(SSB_OM))
ggplot(yy, aes(year, sdSSB))+geom_line()+ facet_wrap('species', scales='free') +
    ylab('Stdev of SSB_om')
ggplot(yy, aes(year, sdSSBnorm))+geom_line()+ facet_wrap('species', scales='free') +
    ylab('Stdev of RE of SSB_om')
ggsave('plots/burn_in_test2.png', width=7, height=5)
