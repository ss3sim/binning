## stripped this out of SSplotSelex -- just grabbed the pieces we need
extract.data <- function(replist, fl=1){
    attach(replist)
    on.exit(detach(replist))
    growdat <- replist$endgrowth
    growdatF <- growdat[growdat$Gender == 1 & growdat$Morph == mainmorphs[1], ]
    growdatF$Sd_Size <- growdatF$SD_Mid
    growdatF$high <- qnorm(0.975, mean = growdatF$Len_Mid, sd = growdatF$Sd_Size)
    growdatF$low <- qnorm(0.025, mean = growdatF$Len_Mid, sd = growdatF$Sd_Size)
    plotlenselex <- as.numeric(sizeselex[sizeselex$Factor ==
                                         "Lsel" & sizeselex$year == endyr & sizeselex$Fleet ==
                                         fl & sizeselex$gender == 1, -(1:5)])
    plotageselex <-
        as.numeric(ageselex[ageselex$factor ==
                            "Asel" & ageselex$year == endyr & ageselex$fleet ==
                            1 & ageselex$gender == 1, -(1:7)])
    x <- seq(0, accuage, by = 1)
    y <- lbinspop
    z <- plotageselex %o% plotlenselex
    temp <- replist$lendbase[replist$lendbase$Fleet==fl, c("Bin", "Exp", "Yr")]
    lencomp <- ddply(temp, .(Bin), summarize, mean.exp=mean(Exp))
    temp <- replist$agedbase[replist$agedbase$Fleet==fl, c("Bin", "Exp", "Yr")]
    agecomp <- ddply(temp, .(Bin), summarize, mean.exp=mean(Exp))
    xx <- list(x=x, y=y, z=z, mid=growdatF$Len_Mid, low=growdatF$low,
               high=growdatF$high, lencomp=lencomp, agecomp=agecomp)
    return(xx)
}
add.lines <- function(x, low, mid, high){
    lines(x, mid, col = "white", lwd = 5)
    lines(x, mid, col = col1, lwd = 2)
    lines(x, high, col = "white", lwd = 1, lty = 1)
    lines(x, high, col = col1, lwd = 1, lty = "dashed")
    lines(x, low, col = "white", lwd = 1, lty = 1)
    lines(x, low, col = col1, lwd = 1, lty = "dashed")
}
## read in the data once
flatfish <- extract.data(r4ss::SS_output(file.path("example_models/B0-D2-F1-I0-flatfish-1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE,
                                         verbose=FALSE, NoCompOK=TRUE))
cod <- extract.data(r4ss::SS_output(file.path("example_models/B0-D2-F1-I0-cod-1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE,
                                         verbose=FALSE, NoCompOK=TRUE))
yellow <- extract.data(r4ss::SS_output(file.path("example_models/B0-D2-F1-I0-yellow-1", "om/"), covar=F, forecast=F,
                           ncols=300, readwt=FALSE, printstats=FALSE,
                                         verbose=FALSE, NoCompOK=TRUE))
replist.list <- list(cod,flatfish, yellow)

## start of figure
make.file("png", filename="figures/figure2_expdesign.png", width=width,
          height=6, res=500)
col1 <- 'black'
par(mar=c(2,.5,.5,.75), tck=-0.015, oma=c(.5,2,0,0),
    mgp=c(.5, .075,0), mfcol=c(1,1), cex.lab=.9, cex.axis=.9,
    col.axis=col.label, xpd=TRUE)
bin.widths <- list(c(2,5,10,20), c(2,5,10,20), c(2,5,10,20))
n.contours <- 6
## cols.palette <- RColorBrewer::brewer.pal(n.contours, "Blues")
cols.palette <- rev(gray.colors(n.contours))
layout(mat=matrix(c(1,1,2,2,3,3,4,4,4,5,5,5), nrow=2, byrow=TRUE), heights=c(1,.5))
xy <- c(.95, .97); xy2 <- c(.95,.93);k <- 1
for(i in 1:3){
with(replist.list[[i]],{
    offset <- list(6,6, 16)[[i]]#(max(x)-min(x))/7
    plot(0,0, yaxs='i', xaxs='i', ylim=c(0, max(y)*1.01), xlim=c(-offset*1.1, max(x)+offset/2), type='n',
         axes=FALSE, ann=FALSE)
    print.letter(paste0("(",letters[k], ")"), xy=xy);k <<- k+1
    contour(x, y, z, nlevels=n.contours , col=cols.palette, lwd=1,
            axes=FALSE, add=TRUE)
    box(col=col.border)
    add.lines(x=x, low,mid,high)
    with(agecomp, lines(x=Bin, y=offset*mean.exp/max(mean.exp)))
    ## lines(y=seq(min(den$x), max(den$x), len=length(den$x)), x=max(x)-den$y*100)
    with(lencomp, lines(y=Bin, x=max(x)+offset/2-offset/2*mean.exp/max(mean.exp)))
    ##     with(lencomp, print(head(-5+max(x)-offset*mean.exp/max(mean.exp))))
    xtemp <- seq(-offset*.4, -offset, len=length(bin.widths[[i]]))
    sapply(seq_along(bin.widths[[i]]), function(ii) {
        ynew <- seq(y[1], y[length(y)], by=bin.widths[[i]][ii])
        points(x=rep(xtemp[ii], len=length(ynew)), y=ynew, pch="-")
        ##  text(x=xtemp[ii], y=max(y)*1.01, labels=bin.widths[[i]][ii], cex=.5)
    })
    axis(1, at=seq(0,max(x), by=10), col=col.border, mgp=par()$mgp, tck=par()$tck)
    axis(2, col=col.border, mgp=par()$mgp, tck=par()$tck)
    mtext("Age", side=1, line=1, cex=par()$cex.lab)
    if(i==1) mtext("Length (cm)", side=2, line=1,cex=par()$cex.lab)
    mtext(c("Cod","Flatfish", "Rockfish")[i], side=3, line=-1.6, cex=par()$cex.lab*1.1)
})}
cex.fishery <- 1.25
cex.survey <- 1
## add data rich
plot(x=25:100, ylim=c(1,4.5), axes=FALSE, ann=FALSE, xlim=c(25,100))
print.letter(paste0("(",letters[k], ")"), xy=xy2);k <<- k+1
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
mtext("Data Rich", side=3, line=-1.6, cex=1)
box(col=col.border)
## add data poor
mtext("Year", side=1, line=1,cex=par()$cex.lab)
mtext("Data Type", side=2, line=.75 ,cex=par()$cex.lab)
plot(x=25:100, ylim=c(1,4.5), axes=FALSE, ann=FALSE, xlim=c(25,100))
print.letter(paste0("(",letters[k], ")"), xy=xy2);k <<- k+1
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
mtext("Data Limited", side=3, line=-1.6, cex=1)
dev.off()
