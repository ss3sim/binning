# Compare internal and external binning with large sample sizes
# What causes the differences in model performance?

library("ss3sim")
library("ss3models")
library("r4ss")
source("startup.R")

case_folder <- 'cases'
species <- 'cod'
case_files <- list(F = "F", B = "em_binning", I = "data",
  D = c("index","lcomp","agecomp","calcomp"))

# internal binning matches population bins:
cat("
age_bins; NULL
len_bins; seq(20, 160, by=2)
pop_binwidth; 2
pop_minimum_size; 8
pop_maximum_size; 202
lcomp_constant; 0.0001
tail_compression; -1
", file = "cases/data100-cod.txt")

# internal binning larger than population bins:
cat("
age_bins; NULL
len_bins; seq(20, 160, by=20)
pop_binwidth; 2
pop_minimum_size; 8
pop_maximum_size; 202
lcomp_constant; 0.0001
tail_compression; -1
", file = "cases/data101-cod.txt")

# external binning matches population bins:
cat("
lbin_method;NULL
bin_vector;seq(20, 160, by=2)
", file = "cases/em_binning100-cod.txt")

# external binning larger than population bins:
cat("
lbin_method;1
bin_vector;seq(20, 160, by=20)
", file = "cases/em_binning101-cod.txt")

# lots of data:
cat("
fleets;NULL
years;list(seq(50,100, by=2),seq(50,100, by=2))
Nsamp;list(1e6, 1e6)
cpar;NA
", file = "cases/agecomp202-cod.txt")
cat("
fleets;c(1,2)
years;list(seq(50,100, by=2), seq(50,100, by=2))
Nsamp;list(1e6, 1e6)
cpar;NA
", file = "cases/lcomp202-cod.txt")
cat("
fleets;2
years;list(seq(50,100, by=2))
Nsamp;list(1e6)
", file = "cases/calcomp202-cod.txt")
cat("
fleets;2
years;list(seq(50,100, by=2))
sds_obs;list(.01)
", file = "cases/index202-cod.txt")

scenarios <- c(
  "D202-F1-I100-B100-cod",
  "D202-F1-I100-B101-cod",
  "D202-F1-I101-B100-cod")

# unlink(scenarios, recursive = TRUE)
run_ss3sim(
  iterations = 1,
  scenarios = scenarios,
  user_recdevs = user.recdevs,
  case_folder = case_folder,
  om_dir = ss3model(species, "om"),
  em_dir = ss3model(species, "em"),
  case_files = case_files,
  call_change_data = TRUE,
  user_recdevs_warn = FALSE)

d <- lapply(scenarios, function(x)
  SS_readdat(file.path(x, "1", "em", "ss3.dat"), verbose = FALSE))

library("dplyr")

plot_comp <- function(dat, prefix = "l", ...) {
  lc <- dat %>%
    filter(Yr == 100, FltSvy == 2) %>%
    select(starts_with(prefix, ignore.case = FALSE)) %>%
    as.matrix %>% t
  image(1:nrow(lc), 1:ncol(lc), lc, col = RColorBrewer::brewer.pal(9, "Blues"),
    ...)
}
png("plots/internal-vs-external-binning.png", width = 800, height = 500)
par(mfrow = c(2, 3))
panels <- c("base", "external bins", "internal bins")
junk <- lapply(seq_len(3), function(i)
  plot_comp(d[[i]]$lencomp, main = paste("lcomp", panels[i]),
    xlab = "Length bin index", ylab = "ignore me"))
junk <- lapply(seq_len(3), function(i)
  plot_comp(d[[i]]$agecomp, prefix = "a", main = paste("calcomp", panels[i]),
    xlab = "Age bin index", ylab = "Length bin index"))
dev.off()

dif <- select(d[[3]]$lencomp, starts_with("l", ignore.case = FALSE)) /
  select(d[[2]]$lencomp, starts_with("l", ignore.case = FALSE))
dif <- as.matrix(dif) %>% t

library("reshape2")
library("ggplot2")
p <- ggplot(melt(dif), aes(x=Var1, y=Var2, fill=value)) +
  geom_tile() + scale_fill_gradient2(midpoint = 1) +
  xlab("Length bin") + ylab("Year index")
ggsave("plots/internal-vs-external-ratio.png", width = 5, height = 4)
