# Test the effect of changing the population bin size on the OM

pop_bins <- seq(1, 25, 1)
out <- plyr::ldply(pop_bins, function(x) {
  unlink("cod", recursive = TRUE, force = TRUE)
  file.copy(ss3models::ss3model("cod", "om"), to = ".", recursive = TRUE)
  file.rename("om", "cod")
  datfile <- r4ss::SS_readdat("cod/ss3.dat", verbose = FALSE)
  ss3sim::change_data(
    datfile          = datfile,
    outfile          = "cod/ss3.dat",
    fleets           = 1:2,
    years            = 26:100,
    types            = c("len", "age"),
    age_bins         = 1:15,
    len_bins         = seq(20, 155, x),
    pop_binwidth     = x,
    pop_minimum_size = NULL,
    pop_maximum_size = NULL)

  system("cd cod; ss3_24o_safe -nohess")
  o <- r4ss::SS_output("cod", covar = FALSE, verbose = FALSE, compfile = "none",
    forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
    NoCompOK = TRUE, ncols = 300)
  unlink("cod", recursive = TRUE, force = TRUE)
  Sys.sleep(0.5) # give ample time for deletion of folder
  ss3sim::get_results_scalar(o)
})


library("dplyr")
library("reshape2")
library("ggplot2")
out2 <- out[,-grep("NLL", names(out))]

scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
#sc <- plyr::ldply(out, function(x) {
  #filter(x, LABEL %in% scalars) %>%
    #select(Value) %>% t
#})
#sc <- setNames(sc, scalars)
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
  ggplot(aes(pop_bins, value)) + geom_line() +
    facet_wrap(~variable, scales = "free_y") +
    xlab("Population bin size") +
    ylab("Relative error")
ggsave("test_om_popbins_scalars_cod.png", width = 6, height = 6)


