## This file runs scenarios for what happens to model as pop bins increase

## Some values vary across species so need to make lists for this
sigmar.list <- list('cod'=.4, 'flatfish'=.7, 'yellow'=.5)
scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
F.cases <- "F1"
scalar_re <- function(x) {(x - x[1]) / x[1]}
## This function returns the management values for a given set of
## parameters. It is designed to be looped over. Be careful of wd if an
## error occurs.
get_om_values <- function(species, binwidth, F_case="F1",
                          sigmaR, iteration, pop_minimum_size=NULL,
                          pop_maximum_size=NULL, type = c("scalar", "timeseries")){
    type <- type[1]
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
    if (type == "scalar")
      ss3sim::get_results_scalar(o)
    if (type == "timeseries")
      ss3sim::get_results_timeseries(o)
}


## Run the OM across bin widths for species. F and recdevs don't make a
## difference for the equilbirium values
binwidth <- 1:20
popbins.binwidth <-
    ldply(F.cases, function(Fcase)
    ldply(species, function(spp)
    ldply(binwidth, function(binwidth)
        data.frame("binwidth"=binwidth, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp,
                                 binwidth=binwidth, sigmaR=sigmar.list[[spp]],
                                 iteration=1, F_case=Fcase,
                                 pop_minimum_size=1,
                                 pop_maximum_size=200)))))
popbins.binwidth <- popbins.binwidth[,c('species', 'binwidth','F', scalars)]
popbins.binwidth <- ddply(popbins.binwidth, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
saveRDS(popbins.binwidth, file='results/popbins.binwidth.RData')

## Run the OM across minimum bin sizes for species. F and recdevs don't
## make a difference for the equilbirium values
minsize <- 1:15
popbins.minsize <-
    ldply(F.cases, function(Fcase)
    ldply(species, function(spp)
    ldply(minsize, function(minsize)
        data.frame("minsize"=minsize, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp,
                                 binwidth=1, sigmaR=sigmar.list[[spp]],
                                 iteration=1, F_case=Fcase,
                                 pop_minimum_size=minsize,
                                 pop_maximum_size=200)))))
popbins.minsize <- popbins.minsize[,c('species', 'minsize','F', scalars)]
popbins.minsize <- ddply(popbins.minsize, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
saveRDS(popbins.minsize, file='results/popbins.minsize.RData')

## Run the OM across maximum bin sizes for species. F and recdevs don't
## make a difference for the equilbirium values
maxsize.list <- list('cod'=rev(seq(132, 200, by=2)),
                     'flatfish'=rev(seq(47, 103, by=2)),
                     'yellow'=rev(seq(62, 106, by=2)))
popbins.maxsize <-
    ldply(F.cases, function(Fcase)
    ldply(species, function(spp)
    ldply(maxsize.list[[spp]], function(maxsize)
        data.frame("maxsize"=maxsize, "species"=spp, "F"=Fcase,
                   get_om_values(species=spp,
                                 binwidth=1, sigmaR=sigmar.list[[spp]],
                                 iteration=1, F_case=Fcase,
                                 pop_minimum_size=1,
                                 pop_maximum_size=maxsize)))))
popbins.maxsize <- popbins.maxsize[,c('species', 'maxsize','F', scalars)]
popbins.maxsize <- ddply(popbins.maxsize, .(species,F),
    mutate, SSB_MSY_RE=scalar_re(SSB_MSY),
    TotYield_MSY_RE=scalar_re(TotYield_MSY),
    SSB_Unfished_RE=scalar_re(SSB_Unfished),
    depletion_RE=scalar_re(depletion))
saveRDS(popbins.maxsize, file='results/popbins.maxsize.RData')

# Example code to make the time series plot:
# # `out` is output from the `get_om_values()` function:
# # I've explicitely called the dplyr:: namespace to avoid conflicts
# # with plyr, but you'll still need to load maggritr for pipes if you aren't
# # going to load dplyr:
# library("maggritr")
# # (or strip out the pipes and dplyr if you'd rather)
# max_bin <- 20
# increment <- 2
# pop_bins <- seq(1, max_bin, increment)
# out$bin <- rep(pop_bins, each = 100)
# out_RE <- out %>%
#   dplyr::filter(bin == 1) %>%
#   dplyr::rename(SpawnBio_bin1 = SpawnBio, Recruit_0_bin1 = Recruit_0) %>%
#   dplyr::select(-F, -bin) %>%
#   dplyr::inner_join(out, by = "Yr") %>%
#   dplyr::mutate(
#     SpawnBio_RE = (SpawnBio - SpawnBio_bin1) / SpawnBio_bin1,
#     Recruit_0_RE = (Recruit_0 - Recruit_0_bin1) / Recruit_0_bin1)
#
# p1 <- ggplot(out_RE, aes(Yr, Recruit_0_RE, colour = bin, group = bin)) + geom_line()
# p2 <- ggplot(out_RE, aes(bin, SpawnBio_RE, colour = yr, group = bin)) + geom_line()
# pdf(paste0("plots/om_popbins_ts_", stock, ".pdf"), width = 5, height = 7)
# gridExtra::grid.arrange(p2, p1)
# dev.off()
