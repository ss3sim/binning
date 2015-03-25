## This file runs scenarios for what happens to model as pop bins increase

## species <- "flatfish"
## max_bin <- 20
## binwidth <- 2
## F_case <- "F1"
## sigmaR <- .4
## pop_bins <- seq(1, max_bin, binwidth)

Nreps <- 2
minsize <- c(1, 15)
temp <- do.call(rbind,
                lapply(1:Nreps, function(i)
                    do.call(rbind,  lapply(minsize, function(i.minsize)
                        cbind("iteration"=i, "minsize"=i.minsize,
                              data.frame(
left off here  get_om_values(species=spp, max_bin=200,
                binwidth=1, sigmaR=1.1,
                iteration=i,
                pop_minimum_size=i.minsize,
                pop_maximum_size=300)

                              ))))))

ggplot(temp, aes(iteration, SSB_MSY, group=minsize, color=minsize))+ geom_line()
facet_grid(minsize~.)

## out <- plyr::ldply(pop_bins, function(x) {
## This function returns the management values for a given set of
## parameters. It is designed to be looped over.
get_om_values <- function(species, max_bin, binwidth, F_case="F1",
                          sigmaR, iteration, pop_minimum_size=NULL,
                          pop_maximum_size=NULL){
    unlink(species, recursive = TRUE, force = TRUE)
    file.copy(ss3models::ss3model(species, "om"), to = '.', recursive = TRUE)
    file.rename("om", species)
    setwd(species)
    datfile <- r4ss::SS_readdat("ss3.dat", verbose = FALSE)
    recdevs <- get_recdevs(iteration = iteration, n = 100, seed=iteration)
    recdevs <- sigmaR * recdevs - sigmaR^2/2 # from the package data
    change_rec_devs(recdevs_new=recdevs, file_in="ss3.par", file_out="ss3.par")
    change_data(datfile = datfile, outfile =  "ss3.dat",
                fleets = 1:2, years = 25:26, types = c("age"), age_bins = 1:15,
                len_bins = c(50,51), pop_binwidth = binwidth,
                pop_minimum_size = pop_minimize_size, pop_maximum_size = pop_maximum_size)
    args <- ss3sim:::get_args(system.file("cases", paste0(F_case, "-", species, ".txt"),
                                          package = "ss3models"))
    ss3sim::change_f(years = args$years, years_alter = args$years_alter,
                     fvals = args$fvals, file_in =  "ss3.par", file_out = "ss3.par")
    system("ss3_24o_opt -nohess", ignore.stdout=TRUE)
    o <- r4ss::SS_output(species, covar = FALSE, verbose = FALSE, compfile = "none",
                         forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
                         NoCompOK = TRUE, ncols = 300)
    setwd("..")
    unlink(species, recursive = TRUE, force = TRUE)
    Sys.sleep(0.05) # give ample time for deletion of folder
    ss3sim::get_results_scalar(o)
}


out2 <- out[,-grep("NLL", names(out))]

scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
out$pop_bins <- pop_bins

scalar_re <- function(x) {
  (x - x[1]) / x[1]
}

out2 <- out[,c("pop_bins", scalars)] %>%
  mutate(
    SSB_MSY_RE = scalar_re(SSB_MSY),
    TotYield_MSY_RE = scalar_re(TotYield_MSY),
    SSB_Unfished_RE = scalar_re(SSB_Unfished),
    depletion_RE = scalar_re(depletion))


p <- out2[,c("pop_bins", paste0(scalars, "_RE"))] %>%
  melt(id.vars = "pop_bins") %>%
  ggplot(aes(pop_bins, value, colour = variable)) + geom_line() +
    #facet_wrap(~variable, scales = "free_y") +
    xlab("Population bin size") +
    ylab("Relative error")
ggsave(paste0("plots/test_om_popbins_scalars_", spp, ".png"),
  width = 7, height = 6)


