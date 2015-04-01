# Test the effect of changing the population bin size on the OM
library("dplyr")
library("reshape2")
library("ggplot2")

stock <- "yellow"
max_bin <- 20
increment <- 2
F_case <- "F1"
type <- "scalar"
recdev_iterations <- 6

pop_bins <- seq(1, max_bin, increment)

out <- plyr::ldply(pop_bins, function(bin_j) {
  junk2 <- plyr::ldply(seq_len(recdev_iterations), function(recdev_i) {
    folder <- paste0(stock, "-", bin_j)
    file.copy(ss3models::ss3model(stock, "om"), to = ".", recursive = TRUE)
    file.rename("om", folder)
    datfile <- r4ss::SS_readdat(file.path(folder, "ss3.dat"), verbose = FALSE)
    ss3sim::change_data(
      datfile          = datfile,
      outfile          = file.path(folder, "ss3.dat"),
      fleets           = 1:2,
      years            = 26:100,
      types            = c("len", "age"),
      age_bins         = 1:15,
      len_bins         = seq(10, 50, bin_j), # don't matter, but must not exceed pop bins
      pop_binwidth     = bin_j,
      pop_minimum_size = NULL,
      pop_maximum_size = NULL)

    args <- ss3sim:::get_args(system.file("cases", paste0(F_case, "-", stock, ".txt"),
        package = "ss3models"))

    rec_devs <- ss3sim::get_recdevs(recdev_i, 100)
    sigma_r  <- paste0(ss3models::ss3model(stock, "om"), "/ss3") %>% get_sigmar
    rec_devs <- sigma_r * rec_devs - (sigma_r^2)/2 # scale to sigma r and bias adjust

    ss3sim::change_rec_devs(rec_devs,
      file_in  = file.path(folder, "ss3.par"),
      file_out = file.path(folder, "ss3.par"))

    ss3sim::change_f(
      years       = args$years,
      years_alter = args$years_alter,
      fvals       = args$fvals,
      file_in     = file.path(folder, "ss3.par"),
      file_out    = file.path(folder, "ss3.par"))

    system(paste0("cd ", folder, "; ss3_24o_opt -nohess"))
    o <- r4ss::SS_output(folder, covar = FALSE, verbose = FALSE, compfile = "none",
      forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
      NoCompOK = TRUE, ncols = 300)
    unlink(folder, recursive = TRUE, force = TRUE)
    if (type == "scalar")
      junk <- ss3sim::get_results_scalar(o)
    if (type == "timeseries")
      junk <- ss3sim::get_results_timeseries(o)
    junk$recdev_i <- recdev_i
    junk
  })
  junk2$bin <- bin_j
  junk2
})

# time series plot:
# out$bin <- rep(pop_bins, each = 100)
# out_RE <- out %>%
#   filter(bin == 1) %>%
#   dplyr::rename(SpawnBio_bin1 = SpawnBio, Recruit_0_bin1 = Recruit_0) %>%
#   select(-F, -bin) %>%
#   inner_join(out, by = "Yr") %>%
#   mutate(
#     SpawnBio_RE = (SpawnBio - SpawnBio_bin1) / SpawnBio_bin1,
#     Recruit_0_RE = (Recruit_0 - Recruit_0_bin1) / Recruit_0_bin1)
#
# p1 <- ggplot(out_RE, aes(Yr, Recruit_0_RE, colour = bin, group = bin)) + geom_line()
# p2 <- ggplot(out_RE, aes(bin, SpawnBio_RE, colour = yr, group = bin)) + geom_line()
# pdf(paste0("plots/om_popbins_ts_", stock, ".pdf"), width = 5, height = 7)
# gridExtra::grid.arrange(p2, p1)
# dev.off()

scalars <- c("SSB_MSY", "TotYield_MSY", "SSB_Unfished", "depletion")
#out$pop_bins <- pop_bins

# scalar_re <- function(x) {
#   (x - x[1]) / x[1]
# }

# out2 <- out[,c("pop_bins", scalars)] %>%
#   mutate(
#     SSB_MSY_RE = scalar_re(SSB_MSY),
#     TotYield_MSY_RE = scalar_re(TotYield_MSY),
#     SSB_Unfished_RE = scalar_re(SSB_Unfished),
#     depletion_RE = scalar_re(depletion))

out2 <- out[, names(out) %in% c("bin", "recdev_i", scalars)]
out2 <- out2 %>%
  filter(bin == 1) %>%
  dplyr::rename(
    SSB_MSY_bin1 = SSB_MSY,
    TotYield_MSY_bin1 = TotYield_MSY,
    SSB_Unfished_bin1 = SSB_Unfished,
    depletion_bin1 = depletion) %>%
  select(-bin) %>%
  inner_join(out2) %>%
  mutate(
    SSB_MSY_RE = (SSB_MSY - SSB_MSY_bin1) / SSB_MSY_bin1,
    TotYield_MSY_RE = (TotYield_MSY - TotYield_MSY_bin1) / TotYield_MSY_bin1,
    SSB_Unfished_RE = (SSB_Unfished - SSB_Unfished_bin1) / SSB_Unfished_bin1,
    depletion_RE = (depletion - depletion_bin1) / depletion_bin1)

p <- out2[, c("recdev_i", "bin", paste0(scalars, "_RE"))] %>%
  reshape2::melt(id.vars = c("bin", "recdev_i")) %>%
  ggplot(aes(bin, value, group = recdev_i)) + geom_line() +
    facet_wrap(~variable) +
    xlab("Population bin size") +
    ylab("Relative error")
ggsave(paste0("plots/test_om_popbins_scalars_recdevs_", stock, ".pdf"),
  width = 7, height = 6)
