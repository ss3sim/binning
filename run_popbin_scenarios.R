## This file runs scenarios for what happens to model as pop bins increase

scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
scalar_re <- function(x) {
  (x - x[1]) / x[1]
}
## This function returns the management values for a given set of
## parameters. It is designed to be looped over.
get_om_values <- function(species, binwidth, F_case="F1",
                          sigmaR, iteration, pop_minimum_size=NULL,
                          pop_maximum_size=NULL){
    unlink(species, recursive = TRUE, force = TRUE)
    file.copy(ss3models::ss3model(species, "om"), to = '.', recursive = TRUE)
    file.rename("om", species)
    setwd(species)
    recdevs <- get_recdevs(iteration = iteration, n = 100, seed=iteration)
    recdevs <- sigmaR * recdevs - sigmaR^2/2 # from the package data
    change_rec_devs(recdevs_new=recdevs, file_in="ss3.par", file_out="ss3.par")
    datfile <- r4ss::SS_readdat("ss3.dat", verbose = FALSE)
    change_data(datfile=datfile, outfile= "ss3.dat",
                fleets=1:2, years=25:26, types=c("age", 'len'), age_bins=1:15,
                len_bins=seq(pop_minimum_size, pop_maximum_size,
                by=binwidth), pop_binwidth=binwidth,
                pop_minimum_size=pop_minimum_size, pop_maximum_size =
                    pop_maximum_size)
    args <- ss3sim:::get_args(system.file("cases", paste0(F_case, "-", species, ".txt"),
                                          package="ss3models"))
    ss3sim::change_f(years=args$years, years_alter=args$years_alter,
                     fvals=args$fvals, file_in= "ss3.par", file_out="ss3.par")
    system("ss3_24o_opt -nohess", ignore.stdout=TRUE)
    o <- r4ss::SS_output(getwd(), covar=FALSE, verbose=FALSE, compfile="none",
                         forecast=TRUE, warn=TRUE, readwt=FALSE, printstats=FALSE,
                         NoCompOK=TRUE, ncols=500)
    setwd('..')
    unlink(species, recursive=TRUE, force=TRUE)
    Sys.sleep(0.05) # give ample time for deletion of folder
    ss3sim::get_results_scalar(o)
}

## Run the OM across bin widths for species. F and recdevs don't make a
## difference for the equilbirium values
binwidth <- 1:15
popbins.binwidth <-
    ldply(paste0("F", 1), function(Fcase)
    ldply(species, function(spp)
    ldply(binwidth, function(binwidth)
        data.frame("binwidth"=binwidth, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp, max_bin=200,
                                 binwidth=binwidth, sigmaR=1.1,
                                 iteration=i, F_case=Fcase,
                                 pop_minimum_size=1,
                                 pop_maximum_size=200)))))
popbins.binwidth <- popbins.binwidth[,c('species', 'binwidth','F', scalars)]
popbins.binwidth <- ddply(popbins.binwidth, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
p <- popbins.binwidth[,c("species", "binwidth", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "binwidth")) %>%
  ggplot(aes(x=binwidth, y=value, colour=variable)) + geom_line() +
      facet_grid(F~species)+ xlab("Population bin size") +
    ylab("Relative error")
ggsave(paste0("plots/popbins_binwidth.png"),p, width=7, height=6)

## Run the OM across minimum bin sizes for species. F and recdevs don't
## make a difference for the equilbirium values
minsize <- 1:15
popbins.minsize <-
    ldply(paste0("F", 1), function(Fcase)
    ldply(species, function(spp)
    ldply(minsize, function(minsize)
        data.frame("minsize"=minsize, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp, max_bin=200,
                                 binwidth=1, sigmaR=1.1,
                                 iteration=i, F_case=Fcase,
                                 pop_minimum_size=minsize,
                                 pop_maximum_size=200)))))
popbins.minsize <- popbins.minsize[,c('species', 'minsize','F', scalars)]
popbins.minsize <- ddply(popbins.minsize, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
p <- popbins.minsize[,c("species", "minsize", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "minsize")) %>%
  ggplot(aes(x=minsize, y=value, colour=variable)) + geom_line() +
      facet_grid(F~species)+ xlab("Population bin size") +
    ylab("Relative error")
ggsave(paste0("plots/popbins_minsize.png"),p, width=7, height=6)


## Run the OM across maximum bin sizes for species. F and recdevs don't
## make a difference for the equilbirium values
maxsize.list <- list('cod'=rev(seq(132, 200, by=2)),
                     'flatfish'=rev(seq(47, 103, by=2)),
                     'yellow'=rev(seq(62, 106, by=2)))
popbins.maxsize <-
    ldply(paste0("F", 1), function(Fcase)
    ldply(species, function(spp)
    ldply(maxsize.list[[spp]], function(maxsize)
        data.frame("maxsize"=maxsize, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp,
                                 binwidth=1, sigmaR=1.1,
                                 iteration=i, F_case=Fcase,
                                 pop_minimum_size=1,
                                 pop_maximum_size=maxsize)))))
popbins.maxsize <- popbins.maxsize[,c('species', 'maxsize','F', scalars)]
popbins.maxsize <- ddply(popbins.maxsize, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
p <- popbins.maxsize[,c("species", "maxsize", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "maxsize")) %>%
  ggplot(aes(x=maxsize, y=value, colour=variable)) + geom_line() +
      facet_grid(F~species, scales='free_x')+ xlab("Population bin size") +
    ylab("Relative error")
ggsave(paste0("plots/popbins_maxsize.png"),p, width=7, height=6)


