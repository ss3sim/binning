## Source this file to make the figures for the paper. Figures are just
## plots that appear in the paper. See also make_plots for more.
library(ggplot2)
library(r4ss)
library(dplyr)
## global options
width <- 7                             # inches
height <- 5


### ------------------------------------------------------------
## Make the literature review figure(s)
lit <- read.csv("lit-review.csv", stringsAsFactors = FALSE, strip.white = TRUE)
names(lit) <- tolower(names(lit))
names(lit) <- gsub("\\.", "_", names(lit))
names(lit) <- gsub("__", "_", names(lit))
names(lit) <- gsub("_$", "", names(lit))

region_lit <- lit %>% group_by(region, bin_width_cm) %>%
  summarise(num = length(bin_width_cm))
taxa_lit <- lit %>% group_by(species_type, bin_width_cm) %>%
  summarise(num = length(bin_width_cm))

region_lit_wide <- reshape2::dcast(region_lit, region ~ bin_width_cm,
  value.var = "num")
region_lit_wide[is.na(region_lit_wide)] <- 0

taxa_lit_wide <- reshape2::dcast(taxa_lit, species_type ~ bin_width_cm,
  value.var = "num")
taxa_lit_wide[is.na(taxa_lit_wide)] <- 0

region_order <- c("Australia", "Atlantic", "Caribbean", "Gulf of Mexico",
  "South Atlantic", "West Coast")
region_lit_wide <- region_lit_wide[order(region_order, region_lit_wide$region), ]
region_lit_wide$region[-1] <- paste("US", region_lit_wide$region[-1])

fable <- function(x, y, z, xlab = "", ylab = "",
  col_breaks = seq(0.5, 4, length.out = 13), log_colours = TRUE,
  text_cex = 1) {

  z <- z[nrow(z):1, ]
  y <- rev(y)
  col <- rev(grey(seq(0, 1, length.out = 18)))
  col <- col[2:13]
  if (log_colours)
    z_plot <- log(z + 1)
  else
    z_plot <- z
  image(1:length(x), 1:length(y), t(z_plot), axes = F, xlab = "", ylab = "",
    col = col, breaks = col_breaks)
  x_lines <- 1:(length(x) + 1) - 0.5
  if(!is.null(y))
    y_lines <- 1:(length(y) + 1) - 0.5
  axis(3, at = x_lines, labels = FALSE, col = "grey50")
  axis(3, tick = FALSE, at = 1:length(x), labels = x, col = "grey50", padj = 0.4)
  axis(2, at = y_lines, labels = FALSE, col = "grey50")
  axis(2, tick = FALSE, at = 1:length(y), labels = y, col = "grey50",
    padj = 0.5, hadj = 0.9, las = 1)
  abline(h = y_lines, col = "#00000050")
  abline(v = x_lines, col = "#00000050")
  for(x_i in 1:length(x)) {
    for(y_i in 1:length(y)) {
      col <- ifelse(z[y_i, x_i] == 0, "white", "grey10")
      text(x_i, y_i, z[y_i, x_i], cex = text_cex, col = col)
    }
  }
  box(col = "grey50")
  mtext(xlab, side = 3, line = 1.75, cex = 0.8)
  if(!is.null(y))
    mtext(ylab, side = 2, line = 2.00, cex = 0.8)
}

pdf("plots/lit-review.pdf", width = 6, height = 7)
par(mar = c(1, 8, 3, 1), oma = c(1, 1, 1, 1), cex = 0.75)
m <- c(rep(1, 3), rep(2, 5))
layout(m)
z <- region_lit_wide[,-1] %>% as.matrix
fable(y = region_lit_wide$region, x = names(region_lit_wide)[-1], z = z, text_cex = 0.9)
z <- taxa_lit_wide[,-1] %>% as.matrix
fable(y = taxa_lit_wide$species_type, x = names(taxa_lit_wide)[-1], z = z, text_cex = 0.9)
dev.off()

####
df <- read.csv("results/Binning_lit_review_10_2014.csv")
str(df)
g <- ggplot(data=df, aes(x=Linf_cm,
            col=Internal_External))+facet_wrap("Region") + xlab("Linf") +
    scale_color_discrete(name="Growth Estimation",
                         labels=c("Not yet specified", "Empirical",
                         "External", "Internal"))
g2 <- g+geom_point(aes(y=num_length_bin))+ylab("Number of bins")
ggsave("plots/lit_review_num_bins.png", g2, width=7, height=4.5)
g2 <- g+geom_point(aes(y=bin_width_cm))+ylab("Width of bins (cm)") + ylim(0,10.5)
ggsave("plots/lit_review_width_bins.png", g2, width=7, height=4.5)

### ------------------------------------------------------------


make_selex_plot <- function(B){
    species <- c('cod', 'flatfish', 'yellow')
    scenarios <- expand_scenarios(cases=list(D=2, E=991, F=1, I=0, B=B), species=species)
    circle.scalar <- 1
    par(mfrow=c(1,3), mgp=c(2,.5,0), mar=c(3,3,3,1))
    for(scenario in scenarios){
        fleet <- 1
        replist <- r4ss::SS_output(file.path("example_models", scenario, "1", "om/"), covar=F, forecast=F,
                                   ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE)
        dat <- SS_readdat(file.path("example_models", scenario, "1", "em/ss3.dat"), verbose=FALSE)
        lbins <- dat$lbin_vector
        agebins <- dat$agebin_vector
        ## Get length samples aggegrated across year for specified fleet
        lbin.proportions <- as.vector(colSums(dat$lencomp[dat$lencomp[,3]==fleet,-(1:6)]))
        lbin.proportions <- lbin.proportions/max(lbin.proportions)*circle.scalar
        agebin.proportions <- as.vector(colSums(dat$agecomp[dat$agecomp[,3]==fleet,-(1:9)]))
        agebin.proportions <- agebin.proportions/max(agebin.proportions)*circle.scalar
        selexinfo <- SSplotSelex(replist = replist, selexlines = 1:6, subplot=21,
                                 fleets = fleet , fleetnames = "default", plot = TRUE,
                                 print = FALSE,  pwidth = 6.5, pheight = 5,
                                 punits = "in", ptsize = 10, showmain=FALSE)
        abline(h=lbins, col=gray(.8), lty=2)
        mtext(scenario, line=-2, cex=.75)
        symbols(x=rep(max(agebins), length(lbins)), y=lbins, circles=lbin.proportions, add=TRUE,
                inches=FALSE, bg='blue')
        symbols(y=rep(min(lbins), length(agebins)), x=agebins, circles=agebin.proportions, add=TRUE,
                inches=FALSE, bg='green')
    }
}

for(bb in 0:4){
png(paste0('plots/selex_B', bb, '.png'), width=9, height=5, units='in', res=300)
make_selex_plot(bb)
dev.off()
}

## ## default args from function -- could play with these to clean up the
## ## plots if need be
## function (replist, infotable = NULL, fleets = "all", fleetnames = "default",
##     sizefactors = c("Lsel"), agefactors = c("Asel", "Asel2"),
##     years = "endyr", season = 1, sexes = "all", selexlines = 1:6,
##     subplot = 1:25, skipAgeSelex10 = TRUE, plot = TRUE, print = FALSE,
##     add = FALSE, labels = c("Length (cm)", "Age (yr)", "Year",
##         "Selectivity", "Retention", "Discard mortality"), col1 = "red",
##     col2 = "blue", lwd = 2, fleetcols = "default", fleetpch = "default",
##     fleetlty = "default", spacepoints = 5, staggerpoints = 1,
##     legendloc = "bottomright", pwidth = 7, pheight = 7, punits = "in",
##     res = 300, ptsize = 12, cex.main = 1, showmain = TRUE, plotdir = "default",
##     verbose = TRUE)
