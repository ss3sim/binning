### ------------------------------------------------------------
## Exploratory code for reviewer comments

stop("don't source this file")

## Is the burnin long enough?
## binning.ts <- readRDS("results/results_binning.ts.RData")
## ## binning.ts <- merge(binning.ts, subset(binning.unfiltered, select=c("ID",'converged')), by="ID")
## ## binning.ts <- merge(binning.ts, bin.cases.df, by=c("species", "B"))
## ## binning.ts <- merge(binning.ts, data.cases.df, by=c("D"))
## ## binning.ts <- subset(binning.ts, converged=="yes")
## ## binning.ts <- calculate_re(binning.ts, add=TRUE)

## ## All scenarios are identical for the OM except species of course
## binning.ts.burnin <- subset(binning.ts, year %in% c(26, 100) & B=="B0" & D=="D5",
##                             select=c('SpawnBio_om', 'Recruit_0_om',
##                             'SpawnBio_em', 'year', 'ID'))
## ## binning.ts.burnin <- reshape2::melt(binning.ts.burnin, c('SpawnBio_om', 'Recruit_0_om',
## ##                             'SpawnBio_em', 'replicate', 'B', 'species'))
## binning.ts.burnin <- reshape2::melt(binning.ts.burnin, c('ID', 'year'))
## binning.ts.burnin$value <- log(binning.ts.burnin$value)
## binning.ts.burnin <- reshape2::dcast(binning.ts.burnin, ID+variable~year)
## names(binning.ts.burnin)[3:4] <- paste0('log_of_year', names(binning.ts.burnin)[3:4])
## temp <- data.frame(do.call(rbind, strsplit(as.character(binning.ts.burnin$ID), split='-')))
## names(temp) <- c('B', 'D', 'F', 'I', 'species', 'replicate')
## binning.ts.burnin <- cbind(binning.ts.burnin, temp)
## xnames <- names(binning.ts.burnin)[3:4]
## ggplot(subset(binning.ts.burnin, variable=='Recruit_0_om'),
##        aes_string(x=xnames[1], y=xnames[2], color='species')) +
##     geom_point(size=1, alpha=.5) +   geom_smooth(method='lm',formula=y~x) +
##         xlab("log(SSB(26)) in OM") +ylab("log(SSB(100)) in OM")
## ggsave('plots/burn_in_test.png', width=7, height=5)

## Run a bunch of scenarios with no EM to see if behaving right
Nsim <- 100
for(spp in c('cod','yellow-long', 'flatfish')){
    F99 <-  ifelse(spp=='yellow-long',
                   c('years;1:175', 'years_alter;1:175', 'fvals;rep(0,175)'),
                   c('years;1:100', 'years_alter;1:100', 'fvals;rep(0,100)'))
    writeLines(F99, con=paste0("cases/", "F99-", spp, ".txt"))
    case_files <- list(F="F", D=c("index","lcomp","agecomp"))
    scenarios <- expand_scenarios(cases=list(D=2, F=99), species=spp)
    ## get_caseargs(case_folder, scenario=scenarios[1], case_files=case_files)
    run_ss3sim(iterations=1:Nsim, scenarios=scenarios,
               parallel=TRUE, parallel_iterations=TRUE,
               case_folder=case_folder, om_dir=om.paths[spp],
               em_dir=em.paths[spp], case_files=case_files,
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



## ## use ss3sim function to extend burn in for yellow model
## setwd('C:/Users/Cole/ss3models/inst/models/yellow-long/om')
## ss3sim::change_year(year_begin=1, year_end=175, burnin=0,
##                     ctl_file_in='ss3.ctl',
##                     ctl_file_out='ss3_new.ctl',
##                     dat_file_in='ss3.dat',
##                     dat_file_out='ss3_new.dat',
##                     par_file_in='ss3.par',
##                     par_file_out='ss3_new.par',
##                     str_file_in='starter.ss',
##                     str_file_out='starter_new.ss',
##                     for_file_in='forecast.ss',
##                     for_file_out='forecast_new.ss')
## setwd('../em')
## ss3sim::change_year(year_begin=1, year_end=175, burnin=100,
##                     ctl_file_in='ss3.ctl',
##                     ctl_file_out='ss3_new.ctl',
##                     dat_file_in=NULL,
##                     par_file_in=NULL,
##                     str_file_in='starter.ss',
##                     str_file_out='starter_new.ss',
##                     for_file_in='forecast.ss',
##                     for_file_out='forecast_new.ss')

## setwd('C:/Users/Cole/binning/')
## spp <- 'yellow'
## F99 <-  c('years;1:500', 'years_alter;1:500', 'fvals;rep(0,500)')
## writeLines(F99, con=paste0("cases/", "F99-", spp, ".txt"))
## case_files <- list(F="F", D=c("index","lcomp","agecomp"))
## scenarios <- expand_scenarios(cases=list(D=2, F=99), species=spp)
## ## get_caseargs(case_folder, scenario=scenarios[1], case_files=case_files)
## run_ss3sim(iterations=1:500, scenarios=scenarios,
##            parallel=TRUE, parallel_iterations=TRUE,
##            case_folder=case_folder, om_dir='yellow/om',
##            em_dir='yellow/em', case_files=case_files,
##            admb_options= " -maxfn 1 -phase 50",
##            call_change_data=TRUE)
## get_results_all(parallel=TRUE)

xx <- read.csv("ss3sim_ts.csv")
xx <- ddply(xx, .(species), mutate, SSB_OM=(SpawnBio_om-SpawnBio_om[1])/SpawnBio_om[1] )
levels(xx$species) <- c('cod', 'flatfish', 'rockfish')
plot_ts_lines(xx, y='SSB_OM', vert='species', rel=TRUE)
## look at variance over time
yy <- ddply(xx, .(species, year), transform, sdSSB=sd(SpawnBio_om), sdSSBnorm=sd(SSB_OM))
## ggplot(yy, aes(year, sdSSB))+geom_line()+ facet_wrap('species', scales='free') +
##     ylab('Stdev of SSB_om')
g <- ggplot(yy, aes(year, sdSSB))+geom_line()+ facet_wrap('species', ncol=1, scales='free') +
    ylab('SD of SSB')+ theme_bw()
ggsave('plots/burn_in_test2.png', g, width=7, height=5)


## size of plus groups in unfished state? take it from last year
ss3sim:::extract_expected_data("D2-F99-flatfish/1/om/data.ss_new")
flatfish.lencomp <- SS_readdat('ss3.dat', verbose=FALSE)$lencomp
round(100*flatfish.lencomp[nrow(flatfish.lencomp), ncol(flatfish.lencomp)]/sum(flatfish.lencomp[nrow(flatfish.lencomp), -(1:6)]),3)
plot(as.numeric(flatfish.lencomp[nrow(flatfish.lencomp), -(1:6)]))

ss3sim:::extract_expected_data("D2-F99-cod/1/om/data.ss_new")
cod.lencomp <- SS_readdat('ss3.dat', verbose=FALSE)$lencomp
round(100*cod.lencomp[nrow(cod.lencomp), ncol(cod.lencomp)]/sum(cod.lencomp[nrow(cod.lencomp), -(1:6)]),3)
plot(as.numeric(cod.lencomp[nrow(cod.lencomp), -(1:6)]))

ss3sim:::extract_expected_data("D2-F99-yellow-long/1/om/data.ss_new")
yellow.lencomp <- SS_readdat('ss3.dat', verbose=FALSE)$lencomp
round(100*yellow.lencomp[nrow(yellow.lencomp), ncol(yellow.lencomp)]/sum(yellow.lencomp[nrow(yellow.lencomp), -(1:6)]),3)
plot(as.numeric(yellow.lencomp[nrow(yellow.lencomp), -(1:6)]))


## Run models with tons of data as self-test. First make new cases needed
for(spp in species){
    ## copy the F cases to make it easier to run w and w/o bias_adjust
    file.copy(paste0('cases/F1-',spp, '.txt'), paste0('cases/F101-',spp, '.txt'))
    file.copy(paste0('cases/F1-',spp, '.txt'), paste0('cases/F102-',spp, '.txt'))
    if(spp=='yellow-long'){
        ## just add 75 more years due to the extra burn in
        index.years99 <- 'years;list(75+26:100)'
        comp.years99 <- 'years;list(75+26:100, 75+26:100)'
    } else {
        index.years99 <- 'years;list(26:100)'
        comp.years99 <- 'years;list(26:100, 26:100)'
    }
    index99 <- c('fleets;c(2)', index.years99 , 'sds_obs;list(.05)')
    lcomp99 <- c('fleets;c(1,2)', comp.years99, 'Nsamp;list(1000, 1000)', 'cpar;c(NA,NA)')
    agecomp99 <- c('fleets;c(1,2)', comp.years99, 'Nsamp;list(1000, 1000)', 'cpar;c(NA,NA)')
    writeLines(index99, con=paste0(case_folder,"/", "index99-", spp, ".txt"))
    writeLines(lcomp99, con=paste0(case_folder,"/", "lcomp99-", spp, ".txt"))
    writeLines(agecomp99, con=paste0(case_folder,"/", "agecomp99-", spp, ".txt"))
## now run model with and without bias adjustment
case_files <- list(F="F", D=c("index","lcomp","agecomp"))
## get_caseargs(case_folder, scenario=scenarios[1], case_files=case_files)
scenarios <- expand_scenarios(cases=list(D=c(2,99), F=101), species=spp)
run_ss3sim(iterations=1:100, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=TRUE,
           case_folder=case_folder, om_dir=om.paths[spp],
           em_dir=em.paths[spp], case_files=case_files,
           call_change_data=TRUE)
scenarios <- expand_scenarios(cases=list(D=c(2,99), F=102), species=spp)
run_ss3sim(iterations=1:100, scenarios=scenarios,
           parallel=TRUE, parallel_iterations=TRUE,
           bias_adjust=TRUE, bias_nsim=5,
           case_folder=case_folder, om_dir=om.paths[spp],
           em_dir=em.paths[spp], case_files=case_files,
           call_change_data=TRUE)
}

get_results_all(user=expand_scenarios(cases=list(D=c(2,99), F=c(101, 102)), species=species))
saveRDS(read.csv('ss3sim_scalar.csv'), file='results/bias_adjust_scalar.RData')
saveRDS(read.csv('ss3sim_ts.csv'), file='results/bias_adjust_ts.RData')

## cod.out <- SS_output('D99-F1-cod/1/em', forecast=FALSE, covar=FALSE,
##                  NoCompOK=TRUE, ncols=250, verbose=FALSE)
## SS_plots(replist=cod.out, png=TRUE, uncertainty=FALSE, html=FALSE)
## flatfish.out <- SS_output('D99-F1-flatfish/1/em', forecast=FALSE, covar=FALSE,
##                  NoCompOK=TRUE, ncols=250, verbose=FALSE)
## SS_plots(replist=flatfish.out, png=TRUE, uncertainty=FALSE, html=FALSE)
## yellow.out <- SS_output('D99-F1-yellow-long/1/em', forecast=FALSE, covar=FALSE,
##                  NoCompOK=TRUE, ncols=250, verbose=FALSE)
## SS_plots(replist=yellow.out, png=TRUE, uncertainty=FALSE, html=FALSE)

biasadjust.sc <- readRDS('results/bias_adjust_scalar.RData')
biasadjust.sc <- calculate_re(biasadjust.sc)
levels(biasadjust.sc$F) <- c("No.Bias.Adjust", "Bias.Adjust")
scalars <- c("CV_young_Fem_GP_1_re",  "CV_old_Fem_GP_1_re",
           "depletion_re", "L_at_Amax_Fem_GP_1_re",
           "L_at_Amin_Fem_GP_1_re", "SSB_MSY_re")
bsc <- melt(biasadjust.sc, id.vars=c('replicate','species', 'D', 'F'), measure.vars=scalars)
## ggplot(bsc, aes(variable, y=value)) + facet_grid(species~D+F) +
##     ylim(-.5, .5) + geom_hline(xintercept=0, col='red') +
##         geom_violin() + theme(axis.text.x = element_text(angle = 90, hjust = 1))
bsc.wide <- reshape2::dcast(bsc, species+variable+D+replicate~F,
                            value.var='value')
levels(bsc.wide$D) <- c("Data rich (D2)", "Extreme data")
g <- ggplot(bsc.wide, aes(No.Bias.Adjust, (Bias.Adjust-No.Bias.Adjust),
                     color=species))+geom_point(alpha=.5) +
                         ggtitle('Effect of bias adjustment on RE')+
                         facet_grid(D~variable, scales='free_x')
ggsave('plots/bias_adjust_effect.png', g, width=9, height=6)
## biasadjust.ts <- readRDS('results/bias_adjust_ts.RData')
## biasadjust.ts <- calculate_re(biasadjust.ts)
## levels(biasadjust.ts$F) <- c("No Bias Adjust", "Bias Adjust")
## plot_ts_boxplot(biasadjust.ts, y='SpawnBio_re', horiz='species', vert2='F',
##                 vert='D', re=TRUE)
