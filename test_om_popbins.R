# Test the effect of changing the population bin size on the OM

library("ss3models")
library("ss3sim")
library("r4ss")
library("dplyr")

file.copy(ss3model("cod", "om"), to = ".", recursive = TRUE)
file.rename("om", "cod")
datfile <- SS_readdat("cod/ss3.dat", verbose = FALSE)
change_data(
  datfile          = datfile,
  outfile          = "cod/ss3.dat",
  fleets           = 1:2,
  years            = 26:100,
  types            = c("len", "age"),
  age_bins         = 1:15,
  len_bins         = seq(20, 155, 30),
  pop_binwidth     = 30,
  pop_minimum_size = NULL,
  pop_maximum_size = NULL)

system("cd cod; ss3_24o_safe -noest")
o <- SS_output("cod", covar = FALSE, verbose = FALSE, compfile = "none",
  forecast = TRUE, warn = TRUE, readwt = FALSE, printstats = FALSE,
  NoCompOK = TRUE, ncols = 300)
unlink("cod", recursive = TRUE, force = TRUE)
dq <- o$derived_quants
#filter(dq, LABEL == "SSB_MSY") %>% select(Value)
