## Source this file to make the figures for the paper. Figures are just
## plots that appear in the paper. See also make_plots for more.
library(ggplot2)
library(r4ss)
## global options
width <- 7                             # inches
height <- 5


### ------------------------------------------------------------
## Make the literature review figure
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
