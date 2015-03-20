## This file runs scenarios for what happens to model as pop bins increase

spp <- "flatfish"
max_bin <- 20
increment <- 2
F_case <- "F1"

pop_bins <- seq(1, max_bin, increment)

## out <- plyr::ldply(pop_bins, function(x) {
get_om_values <- function(
  unlink(spp, recursive = TRUE, force = TRUE)
  file.copy(ss3models::ss3model(spp, "om"), to = ".", recursive = TRUE)
  file.rename("om", spp)
  datfile <- r4ss::SS_readdat(file.path(spp, "ss3.dat"), verbose = FALSE)
  ss3sim::change_data(
    datfile          = datfile,
    outfile          = file.path(spp, "ss3.dat"),
    fleets           = 1:2,
    years            = 26:100,
    types            = c("len", "age"),
    age_bins         = 1:15,
    len_bins         = seq(10, 50, x),
    pop_binwidth     = x,
    pop_minimum_size = NULL,
    pop_maximum_size = NULL)

  args <- ss3sim:::get_args(system.file("cases", paste0(F_case, "-", spp, ".txt"),
    package = "ss3models"))

  ss3sim::change_f(years = args$years,
    years_alter = args$years_alter,
    fvals = args$fvals,
    file_in = file.path(spp, "ss3.par"),
    file_out = file.path(spp, "ss3.par"))
  setwd(spp)
  system("ss3_24o_opt -nohess", ignore.stdout=TRUE)
  setwd("..")
  o <- r4ss::SS_output(spp, covar = FALSE, verbose = FALSE, compfile = "none",
    forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
    NoCompOK = TRUE, ncols = 300)
  unlink(spp, recursive = TRUE, force = TRUE)
  Sys.sleep(0.25) # give ample time for deletion of folder
  ss3sim::get_results_scalar(o)
})

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


