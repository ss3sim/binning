# Test the effect of changing the population bin size on the OM

out <- lapply(seq(1, 20), function(x) {
  file.copy(ss3models::ss3model("cod", "om"), to = ".", recursive = TRUE)
  file.rename("om", "cod")
  datfile <- SS_readdat("cod/ss3.dat", verbose = FALSE)
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

  system("cd cod; ss3_24o_safe -noest")
  o <- r4ss::SS_output("cod", covar = FALSE, verbose = FALSE, compfile = "none",
    forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
    NoCompOK = TRUE, ncols = 300)
  unlink("cod", recursive = TRUE, force = TRUE)
  Sys.sleep(1) # give ample time for deletion of folder
  dq <- o$derived_quants
  dq
})

# library("dplyr")
# filter(dq, LABEL == "SSB_MSY") %>% select(Value)
