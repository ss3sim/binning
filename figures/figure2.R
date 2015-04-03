## stripped this out of SSplotSelex -- just grabbed the pieces we need
extract.data <- function(replist){
    attach(replist)
        growdat <- replist$endgrowth
        growdatF <- growdat[growdat$Gender == 1 & growdat$Morph == mainmorphs[1], ]
        growdatF$Sd_Size <- growdatF$SD_Mid
        growdatF$high <- qnorm(0.975, mean = growdatF$Len_Mid, sd = growdatF$Sd_Size)
        growdatF$low <- qnorm(0.025, mean = growdatF$Len_Mid, sd = growdatF$Sd_Size)
        plotlenselex <- as.numeric(sizeselex[sizeselex$Factor ==
                                             "Lsel" & sizeselex$year == endyr & sizeselex$Fleet ==
                                             1 & sizeselex$gender == 1, -(1:5)])
        plotageselex <-
            as.numeric(ageselex[ageselex$factor ==
                                "Asel" & ageselex$year == endyr & ageselex$fleet ==
                                1 & ageselex$gender == 1, -(1:7)])
        x <- seq(0, accuage, by = 1)
        y <- lbinspop
        z <- plotageselex %o% plotlenselex
        xx <- list(x=x, y=y, z=z, mid=growdatF$Len_Mid, low=growdatF$low,
                   high=growdatF$high)
    detach(replist)
    return(xx)
}
f <- function(x, low, mid, high){
    lines(x, mid, col = "white", lwd = 5)
    lines(x, mid, col = col1, lwd = 3)
    lines(x, high, col = "white", lwd = 1, lty = 1)
    lines(x, high, col = col1, lwd = 1, lty = "dashed")
    lines(x, low, col = "white", lwd = 1, lty = 1)
    lines(x, low, col = col1, lwd = 1, lty = "dashed")
}
replist <- r4ss::SS_output(file.path("B0-D2-F1-I0-flatfish", "1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE)
SS_plots(replist,  png=TRUE, uncertainty=FALSE)
flatfish <- extract.data(r4ss::SS_output(file.path("B0-D2-F1-I0-flatfish", "1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE))
cod <- extract.data(r4ss::SS_output(file.path("B0-D2-F1-I0-cod", "1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE))
yellow <- extract.data(r4ss::SS_output(file.path("xB0-D2-F1-I0-yellow/", "1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE))
replist.list <- list(flatfish,cod,yellow)
## flatfish.dat <- SS_readdat(file.path("example_models", scenario, "1", "em/ss3.dat"), verbose=FALSE)
## lbins <- dat$lbin_vector
## agebins <- dat$agebin_vector
## ## Get length samples aggegrated across year for specified fleet
## lbin.proportions <- as.vector(colSums(dat$lencomp[dat$lencomp[,3]==fleet,-(1:6)]))
## lbin.proportions <- lbin.proportions/max(lbin.proportions)*circle.scalar
## agebin.proportions <- as.vector(colSums(dat$agecomp[dat$agecomp[,3]==fleet,-(1:9)]))
## agebin.proportions <- agebin.proportions/max(agebin.proportions)*circle.scalar
## on.exit(if(type!="none") dev.off())
## make.file(type=type, paste("Figures/Figure4", res,
##           sep="_"), width=width, height=height, res=res)

make.file("png", filename="figures/figure2_expdesign.png", width=width,
          height=6, res=500)
set.seed(5)
col1 <- 'black'
par(mar=c(2,1,1,1), tck=-0.015, oma=c(1,2,0,0),
    mgp=c(.5, .075,0), mfcol=c(1,1), cex.lab=.9, cex.axis=.8,
    col.axis=col.label, xpd=TRUE)
bin.widths <- c(1,5,10,20)
n.contours <- 6
## cols.palette <- RColorBrewer::brewer.pal(n.contours, "Blues")
cols.palette <- rev(gray.colors(n.contours))
layout(mat=matrix(c(1,1,2,2,3,3,4,4,4,5,5,5), nrow=2, byrow=TRUE), heights=c(1,.5))
for(i in 1:3){
with(replist.list[[i]],{
    plot(0,0, ylim=c(0, max(y)), xlim=c(-5, max(x)+5), type='n',
         axes=FALSE, ann=FALSE)
    contour(x, y, z, nlevels=n.contours , col=cols.palette, lwd=1,
            axes=FALSE, add=TRUE)
    box(col=col.border)
    f(x=x, low,mid,high)
    temp.ages <- rnorm(1000, 10,5)
    den <- density(temp.ages, from=0, to=max(x))
    lines(den$x, den$y*100)
    temp.len <- rnorm(1000, 20, 5)
    den <- density(temp.len, from=0, to=max(y))
    lines(y=seq(min(den$x), max(den$x), len=length(den$x)), x=max(x)-den$y*100)
        sapply(seq_along(bin.widths), function(ii) {
            ynew <- seq(y[1], y[length(y)], by=bin.widths[ii])
            points(x=rep(-ii-1, len=length(ynew)), y=ynew, pch="-")
        })
    axis(1, col=col.border, mgp=par()$mgp, tck=par()$tck)
    axis(2, col=col.border, mgp=par()$mgp, tck=par()$tck)
    mtext("Age", side=1, line=1, cex=par()$cex.lab)
    if(i==1) mtext("Length (cm)", side=2, line=1,cex=par()$cex.lab)
    mtext(c("Flatfish", "Cod", "Rockfish")[i], side=3, line=-1.5, cex=par()$cex.lab*1.1)
})}
cex.fishery <- 1.25
cex.survey <- 1
## add data rich
plot(x=25:100, ylim=c(1,4.25), axes=FALSE, ann=FALSE, xlim=c(25,100))
lcomp2 <- ss3sim:::get_args("cases/lcomp2-cod.txt")
with(lcomp2, points(years[[1]], y=rep(2, len=length(years[[1]])), cex=cex.fishery))
with(lcomp2, points(years[[2]], y=rep(2.25, len=length(years[[2]])), cex=cex.survey, pch=16))
index2 <- ss3sim:::get_args("cases/index2-cod.txt")
with(index2, points(years[[1]], y=rep(3, len=length(years[[1]])), cex=cex.survey,pch=16))
agecomp2 <- ss3sim:::get_args("cases/agecomp2-cod.txt")
with(agecomp2, points(years[[1]], y=rep(1, len=length(years[[1]])), cex=cex.fishery))
with(agecomp2, points(years[[2]], y=rep(1.25, len=length(years[[2]])), cex=cex.survey, pch=16))
points(x=25:100, y=rep(3.75, len=76), cex=cex.fishery)
axis(1, at=seq(25,100, by=25), col=col.border, mgp=par()$mgp, tck=par()$tck)
text(x=90, y=c(1.5,2.5,3.25,4), labels=c("Lengths", "Ages", "Index", "Catches"))
box(col=col.border)
## add data poor
mtext("Year", side=1, line=1,cex=par()$cex.lab)
mtext("Data Type", side=2, line=.75 ,cex=par()$cex.lab)
plot(x=25:100, ylim=c(1,4.25), axes=FALSE, ann=FALSE, xlim=c(25,100))
lcomp5 <- ss3sim:::get_args("cases/lcomp5-cod.txt")
with(lcomp5, points(years[[1]], y=rep(2, len=length(years[[1]])), cex=cex.fishery))
with(lcomp5, points(years[[2]], y=rep(2.25, len=length(years[[2]])), cex=cex.survey, pch=16))
index5 <- ss3sim:::get_args("cases/index5-cod.txt")
with(index5, points(years[[1]], y=rep(3, len=length(years[[1]])),pch=16, cex=cex.survey))
agecomp5 <- ss3sim:::get_args("cases/agecomp5-cod.txt")
with(agecomp5, points(years[[1]], y=rep(1, len=length(years[[1]])), cex=cex.fishery))
with(agecomp5, points(years[[2]], y=rep(1.25, len=length(years[[2]])), cex=cex.survey, pch=16))
points(x=25:100, y=rep(3.75, len=76), cex=cex.fishery)
axis(1, at=seq(25,100, by=25), col=col.border, mgp=par()$mgp, tck=par()$tck)
text(x=90, y=c(1.5,2.5,3.25,4), labels=c("Lengths", "Ages", "Index", "Catches"))
box(col=col.border)
mtext("Year", side=1, line=1,cex=par()$cex.lab)
dev.off()

## for(bb in 0:4){
## png(paste0('plots/selex_B', bb, '.png'), width=9, height=5, units='in', res=300)
## make_selex_plot(bb)
## dev.off()
## }
## ## ## default args from function -- could play with these to clean up the
## ## ## plots if need be
## ## function (replist, infotable = NULL, fleets = "all", fleetnames = "default",
## ##     sizefactors = c("Lsel"), agefactors = c("Asel", "Asel2"),
## ##     years = "endyr", season = 1, sexes = "all", selexlines = 1:6,
## ##     subplot = 1:25, skipAgeSelex10 = TRUE, plot = TRUE, print = FALSE,
## ##     add = FALSE, labels = c("Length (cm)", "Age (yr)", "Year",
## ##         "Selectivity", "Retention", "Discard mortality"), col1 = "red",
## ##     col2 = "blue", lwd = 2, fleetcols = "default", fleetpch = "default",
## ##     fleetlty = "default", spacepoints = 5, staggerpoints = 1,
## ##     legendloc = "bottomright", pwidth = 7, pheight = 7, punits = "in",
## ##     res = 300, ptsize = 12, cex.main = 1, showmain = TRUE, plotdir = "default",
## ##     verbose = TRUE)
## make_selex_plot <- function(B){
##     species <- c('cod', 'flatfish', 'yellow')
##     scenarios <- expand_scenarios(cases=list(D=2, E=991, F=1, I=0, B=B), species=species)
##     circle.scalar <- 1
##     par(mfrow=c(1,3), mgp=c(2,.5,0), mar=c(3,3,3,1))
##     for(scenario in scenarios){
##         fleet <- 1
##         replist <- r4ss::SS_output(file.path("example_models", scenario, "1", "om/"), covar=F, forecast=F,
##                                    ncols=300, readwt=FALSE, printstats=FALSE, verbose=FALSE)
##         dat <- SS_readdat(file.path("example_models", scenario, "1", "em/ss3.dat"), verbose=FALSE)
##         lbins <- dat$lbin_vector
##         agebins <- dat$agebin_vector
##         ## Get length samples aggegrated across year for specified fleet
##         lbin.proportions <- as.vector(colSums(dat$lencomp[dat$lencomp[,3]==fleet,-(1:6)]))
##         lbin.proportions <- lbin.proportions/max(lbin.proportions)*circle.scalar
##         agebin.proportions <- as.vector(colSums(dat$agecomp[dat$agecomp[,3]==fleet,-(1:9)]))
##         agebin.proportions <- agebin.proportions/max(agebin.proportions)*circle.scalar
##         selexinfo <- SSplotSelex(replist = replist, selexlines = 1:6, subplot=21,
##                                  fleets = fleet , fleetnames = "default", plot = TRUE,
##                                  print = FALSE,  pwidth = 6.5, pheight = 5,
##                                  punits = "in", ptsize = 10, showmain=FALSE)
##         abline(h=lbins, col=gray(.8), lty=2)
##         mtext(scenario, line=-2, cex=.75)
##         symbols(x=rep(max(agebins), length(lbins)), y=lbins, circles=lbin.proportions, add=TRUE,
##                 inches=FALSE, bg='blue')
##         symbols(y=rep(min(lbins), length(agebins)), x=agebins, circles=agebin.proportions, add=TRUE,
##                 inches=FALSE, bg='green')
##     }
## }
