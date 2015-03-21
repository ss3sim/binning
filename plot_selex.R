library(r4ss)
xx <- SS_output("em/", covar=F, forecast=F, ncols=300)

lbins <- xx$lbins
## This will be the difference between internal and external bins
lbin.ratios <- rnorm(length(lbins), mean=0, sd=.2)
## plot both fleets together
par(mfrow=c(1,2))
selexinfo <- SSplotSelex(replist = xx, selexlines = 1:6, subplot=21,
                         fleets = 1, fleetnames = "default", plot = TRUE,
                         print = FALSE,  pwidth = 6.5, pheight = 5,
                         punits = "in", ptsize = 10, res = 300, cex.main = 1,
                         plotdir = "plots")
abline(h=lbins, col=gray(.8))
symbols(x=rep(0, length(lbins)), y=lbins, circles=abs(lbin.ratios), add=TRUE,
        inches=FALSE, bg=ifelse(lbin.ratios>0, "blue", "red"))
selexinfo <- SSplotSelex(replist = xx, selexlines = 1:6, subplot=21,
                         fleets = 2, fleetnames = "default", plot = TRUE,
                         print = FALSE,  pwidth = 6.5, pheight = 5,
                         punits = "in", ptsize = 10, res = 300, cex.main = 1,
                         plotdir = "plots")
abline(h=lbins, col=gray(.8))
symbols(x=rep(0, length(lbins)), y=lbins, circles=abs(lbin.ratios), add=TRUE,
        inches=FALSE, bg=ifelse(lbin.ratios>0, "blue", "red"))

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
