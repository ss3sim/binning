## This file runs scenarios for what happens to model as pop bins increase
library(plyr)
library(dplyr)
## This function returns the management values for a given set of
## parameters. It is designed to be looped over. Be careful of wd if an
## error occurs.
get_om_values <- function(species, binwidth, F_case="F1", k=NULL,
                          Lmin=NULL, Linf=NULL,
                          sigmaR, iteration, pop_minimum_size=NULL,
                          pop_maximum_size=NULL, type = c("scalar", "timeseries")){
    type <- type[1]
    unlink(species, recursive = TRUE, force = TRUE)
    file.copy(om.paths[species], to = '.', recursive = TRUE)
    file.rename("om", species)
    setwd(species)
    nyears <- ifelse(species=='yellow-long', 175, 100)
    recdevs <- get_recdevs(iteration = iteration, n = nyears, seed=iteration)
    recdevs <- sigmaR * recdevs - sigmaR^2/2 # from the package data
    change_rec_devs(recdevs_new=recdevs, par_file_in="ss3.par", par_file_out="ss3.par")
    datfile <- r4ss::SS_readdat("ss3.dat", verbose = FALSE)
    change_data(dat_list=datfile, outfile= "ss3.dat",
                fleets=1:2, years=25:26, types=c("age", 'len'), age_bins=1:15,
                len_bins=seq(pop_minimum_size, pop_maximum_size,
                by=binwidth), pop_binwidth=binwidth,
                pop_minimum_size=pop_minimum_size, pop_maximum_size =
                pop_maximum_size)
    if(!is.null(k)){
        par <- readLines("ss3.par")
        par[which(par == "# MGparm[4]:")+1] <- k
        writeLines(par, con="ss3.par")
    }
    if(!is.null(Linf)){
        par <- readLines("ss3.par")
        par[which(par == "# MGparm[3]:")+1] <- Linf
        writeLines(par, con="ss3.par")
    }
    if(!is.null(Lmin)){
        par <- readLines("ss3.par")
        par[which(par == "# MGparm[2]:")+1] <- Lmin
        writeLines(par, con="ss3.par")
    }
    args <- ss3sim:::get_args(paste0('../', case_folder,"/", F_case, "-", species, ".txt"))
    ss3sim::change_f(years=args$years, years_alter=args$years_alter,
                     fvals=args$fvals, par_file_in= "ss3.par", par_file_out="ss3.par")
    system("ss3_24o_safe -nohess", ignore.stdout=TRUE)
    o <- r4ss::SS_output(getwd(), covar=FALSE, verbose=FALSE, compfile="none",
                         forecast=TRUE, warn=TRUE, readwt=FALSE, printstats=FALSE,
                         NoCompOK=TRUE, ncols=500)
    setwd('..')
    Sys.sleep(0.05) # give ample time for deletion of folder
    unlist(species)
    if (type == "scalar")
        result <- ss3sim::get_results_scalar(o)
    if (type == "timeseries")
        result <- ss3sim::get_results_timeseries(o)
    return(result)
}


## Some values vary across species so need to make lists for this
## sigmar.list <- list('cod'=.4, 'flatfish'=.7, 'yellow-long'=.5)
## Turn off sigma to see underlying average patterns
sigmar.list <- list('cod'=.0001, 'flatfish'=.0001, 'yellow-long'=.0001)
scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
F.cases <- "F1"
scalar_re <- function(x) {(x - x[1]) / x[1]}

## Run the OM across bin widths for species. First do the scalar quantities
## which are in equilibrium so process error and F don't matter.
binwidth <- 1:20
temp <- ldply(F.cases, function(Fcase)
    ldply(species, function(spp)
        ldply(binwidth, function(bw) {
             data.frame("binwidth"=bw, "species"=spp, "F"=Fcase,
                 get_om_values(species=spp,
                               binwidth=bw, sigmaR=sigmar.list[[spp]],
                               iteration=1, F_case=Fcase,
                               pop_minimum_size=1,
                               pop_maximum_size=200))
})))
unlink(species, recursive=TRUE, force=TRUE)
popbins.binwidth.scalars <- temp[,c('species', 'binwidth','F', scalars)]
popbins.binwidth.scalars <- ddply(popbins.binwidth.scalars, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
rm(temp)
saveRDS(popbins.binwidth.scalars, file='results/popbins.binwidth.scalars.RData')

## Run the OM across bin widths for species. Now do the time series which
## do depend on F and recdevs
binwidth <- c(1,2,5,10,20)
temp <-
    ldply(F.cases, function(Fcase)
    ldply(species, function(spp)
    ldply(binwidth, function(bw)
        data.frame("binwidth"=bw, "species"=spp,
                   get_om_values(species=spp,
                                 binwidth=bw, sigmaR=sigmar.list[[spp]],
                                 iteration=1, F_case=Fcase,
                                 pop_minimum_size=1, type='timeseries',
                                 pop_maximum_size=200)))))
## calculate relative error using sean's code, uses binwidth=1 as base
popbins.binwidth.ts <- temp %>%
  dplyr::filter(binwidth == 1) %>%
  dplyr::rename(SpawnBio_bin1 = SpawnBio, Recruit_0_bin1 = Recruit_0) %>%
  dplyr::select(-F, binwidth) %>%
  dplyr::inner_join(temp, by = c("species","Yr")) %>%
  dplyr::mutate(
    SpawnBio_RE = (SpawnBio - SpawnBio_bin1) / SpawnBio_bin1,
    Recruit_0_RE = (Recruit_0 - Recruit_0_bin1) / Recruit_0_bin1)
rm(temp)
saveRDS(popbins.binwidth.ts, file='results/popbins.binwidth.ts.RData')

## End of code used in study
### ------------------------------------------------------------

## Turned off for now
## ## Try varying the growth parameters to test our hypothesis of nonlinearity
## k.seq <-  seq(.05, .1, len=10)
## spp <- "yellow-long"
## popbins.k.scalars <-
##     ldply(c(.0001, sigmar.list[[spp]]), function(sigmaR)
##     ldply(c(1,20), function(bw)
##     ldply(k.seq, function(k)
##         data.frame("k"=k, "binwidth"=bw, "sigmaR"=sigmaR, 'species'=spp, 'F'="F1",
##                    get_om_values(species=spp, k=k,
##                                  binwidth=bw, sigmaR=sigmaR,
##                                  iteration=1, F_case="F1",
##                                  pop_minimum_size=1,
##                                  pop_maximum_size=200)))))
## popbins.k.scalars <- popbins.k.scalars[,c('binwidth', 'k','sigmaR', scalars)]
## popbins.k.scalars <- ddply(popbins.k.scalars, .(species, F, k, sigmaR),
##      mutate, SSB_MSY_RE=scalar_re(SSB_MSY), len=length(k),
##     TotYield_MSY_RE=scalar_re(TotYield_MSY),
##     SSB_Unfished_RE=scalar_re(SSB_Unfished),
##     depletion_RE=scalar_re(depletion))
## popbins.k.scalars <- subset(popbins.k.scalars, binwidth==20)
## saveRDS(popbins.k.scalars, file='results/popbins.k.scalars.RData')
## Linf.seq <-  seq(50, 70, len=10)
## popbins.Linf.scalars <-
##     ldply(c(.0001, sigmar.list[[spp]]), function(sigmaR)
##     ldply(c(1,20), function(bw)
##     ldply(Linf.seq, function(Linf)
##         data.frame("Linf"=Linf, "binwidth"=bw, "sigmaR"=sigmaR, 'species'=spp, 'F'="F1",
##                    get_om_values(species=spp, Linf=Linf,
##                                  binwidth=bw, sigmaR=sigmaR,
##                                  iteration=1, F_case="F1",
##                                  pop_minimum_size=1,
##                                  pop_maximum_size=200)))))
## popbins.Linf.scalars <- popbins.Linf.scalars[,c('binwidth', 'Linf','sigmaR', scalars)]
## popbins.Linf.scalars <- ddply(popbins.Linf.scalars, .(species, F, Linf, sigmaR),
##      mutate, SSB_MSY_RE=scalar_re(SSB_MSY), len=length(Linf),
##     TotYield_MSY_RE=scalar_re(TotYield_MSY),
##     SSB_Unfished_RE=scalar_re(SSB_Unfished),
##     depletion_RE=scalar_re(depletion))
## popbins.Linf.scalars <- subset(popbins.Linf.scalars, binwidth==20)
## saveRDS(popbins.Linf.scalars, file='results/popbins.Linf.scalars.RData')
## Lmin.seq <-  seq(10, 30, len=10)
## popbins.Lmin.scalars <-
##     ldply(c(.0001, sigmar.list[[spp]]), function(sigmaR)
##     ldply(c(1,20), function(bw)
##     ldply(Lmin.seq, function(Lmin)
##         data.frame("Lmin"=Lmin, "binwidth"=bw, "sigmaR"=sigmaR, 'species'=spp, 'F'="F1",
##                    get_om_values(species=spp, Lmin=Lmin,
##                                  binwidth=bw, sigmaR=sigmaR,
##                                  iteration=1, F_case="F1",
##                                  pop_minimum_size=1,
##                                  pop_maximum_size=200)))))
## popbins.Lmin.scalars <- popbins.Lmin.scalars[,c('binwidth', 'Lmin','sigmaR', scalars)]
## popbins.Lmin.scalars <- ddply(popbins.Lmin.scalars, .(species, F, Lmin, sigmaR),
##      mutate, SSB_MSY_RE=scalar_re(SSB_MSY), len=length(Lmin),
##     TotYield_MSY_RE=scalar_re(TotYield_MSY),
##     SSB_Unfished_RE=scalar_re(SSB_Unfished),
##     depletion_RE=scalar_re(depletion))
## popbins.Lmin.scalars <- subset(popbins.Lmin.scalars, binwidth==20)
## saveRDS(popbins.Lmin.scalars, file='results/popbins.Lmin.scalars.RData')
## ## end of growth parameter exploration
## ## ## These weren't that interestign so turning off for now
## ## Run the OM across minimum bin sizes for species. F and recdevs don't
## ## make a difference for the equilbirium values
## minsize <- 1:15
## popbins.minsize <-
##     ldply(F.cases, function(Fcase)
##     ldply(species, function(spp)
##     ldply(minsize, function(minsize)
##         data.frame("minsize"=minsize, "species"=spp, "F"=Fcase,
##                    get_om_values(species=spp,
##                                  binwidth=1, sigmaR=sigmar.list[[spp]],
##                                  iteration=1, F_case=Fcase,
##                                  pop_minimum_size=minsize,
##                                  pop_maximum_size=200)))))
## popbins.minsize <- popbins.minsize[,c('species', 'minsize','F', scalars)]
## popbins.minsize <- ddply(popbins.minsize, .(species,F),
##     mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
##     TotYield_MSY_RE=scalar_re(TotYield_MSY),
##     SSB_Unfished_RE=scalar_re(SSB_Unfished),
##     depletion_RE=scalar_re(depletion))
## saveRDS(popbins.minsize, file='results/popbins.minsize.RData')
## ## Run the OM across maximum bin sizes for species. F and recdevs don't
## ## make a difference for the equilbirium values
## maxsize.list <- list('cod'=rev(seq(132, 200, by=2)),
##                      'flatfish'=rev(seq(47, 103, by=2)),
##                      'yellow-long'=rev(seq(62, 106, by=2)))
## popbins.maxsize <-
##     ldply(F.cases, function(Fcase)
##     ldply(species, function(spp)
##     ldply(maxsize.list[[spp]], function(maxsize)
##         data.frame("maxsize"=maxsize, "species"=spp, "F"=Fcase,
##                    get_om_values(species=spp,
##                                  binwidth=1, sigmaR=sigmar.list[[spp]],
##                                  iteration=1, F_case=Fcase,
##                                  pop_minimum_size=1,
##                                  pop_maximum_size=maxsize)))))
## popbins.maxsize <- popbins.maxsize[,c('species', 'maxsize','F', scalars)]
## popbins.maxsize <- ddply(popbins.maxsize, .(species,F),
##     mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
##     TotYield_MSY_RE=scalar_re(TotYield_MSY),
##     SSB_Unfished_RE=scalar_re(SSB_Unfished),
##     depletion_RE=scalar_re(depletion))
## saveRDS(popbins.maxsize, file='results/popbins.maxsize.RData')

