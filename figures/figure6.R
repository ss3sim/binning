## performance tradeoffs

## manipulate the existing long data frame into what we want for plotting
d <- droplevels(subset(binning.long.figure, binmatch=="pbin=1cm" & data
                       ==c("Rich:C+L") & pct.converged > .5))
d <- ddply(d, .(species, dbin, variable), summarize,
            MARE=median(abs(value)),
            MRE=median(value),
            median.runtime=median(runtime),
            count=length(value),
           pct.converged=pct.converged[1])
d$binwidth <- with(d, as.numeric(gsub("dbin=","", x=dbin)))
d <- subset(d, binwidth < 20)
d <- ddply(d, .(species, variable), mutate,
      relative.runtime=median.runtime/median.runtime[which(binwidth==1)])
range(d$relative.runtime)
range(d$MRE)

## ## get some measure of total MARE by plying over variable
## df2 <- ddply(df, .(species, data, dbin, binmatch), summarize,
##              binwidth=binwidth[1],
##              MARE.median=median(MARE),
##              MARE.sum=sum(MARE),
##              median.runtime=median.runtime[1])
## g <- ggplot(df2, aes(log(median.runtime), log(MARE.median), size=binwidth, color=binmatch))+geom_point()+facet_grid(data~species)
## ggplot(d, aes(log(median.runtime), (MRE), size=as.factor(binwidth)))+
##     geom_hline(yintercept=0, col='red')+
##     facet_grid(species~variable, scales='free_x')+geom_point() + ylim(-.2,.2)
## ggsave('figures/figure5_performance_tradeoffs.png', g,  width=7, height=5)


myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")[c(6,7, 1:5)]
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]),
                        "Depletion")[c(6,7, 1:5)]
species.labels <- c("Cod", "Flatfish", "Rockfish")
xy <- c(.07, .93);
for(i in seq_along(species)){
make.file(file.type, filename=paste0('figures/figure6_tradeoffs_', species[i]),
          res=500, width=width2, height=4)
par(mar=c(0,0,0,0), tck=-0.03, oma=c(2.5,2.5,.5,.5),
    mgp=c(.5, .2,0), mfrow=c(4,2), cex.lab=.8, cex.axis=.8,
    col.axis=col.label, xpd=FALSE)
k <- 1
for(j in seq_along(myvariables)){
    d.temp <- d[d$species==species[i] & d$variable==myvariables[j],]
    pch.cex <- .6*seq_along(d.temp$binwidth)
    plot(0,0, type='n', xlim=c(.27,1.05), ylim=c(-.16, .16), axes=FALSE, ann=FALSE)
    abline(h=0, col=col.border, lty=2, lwd=.75)
    ## only make plots if had enough converged iterations
    with(d.temp, lines(x=relative.runtime, y=MRE, pch=16, col=gray(.5), lwd=1.5))
    with(d.temp, points(x=relative.runtime, y=MRE, pch=16, cex=pch.cex,
                        col=rgb(0,0,0,.5)))
    print.letter(paste0("(", letters[k], ")"), xy=xy, cex=.8); k <- k+1
    mtext(myvariables.labels[j], side=3, line=-1.65, cex=par()$cex.lab)
    if(j %in% c(6,7))
        axis(1, col=col.tick, mgp=par()$mgp, tck=par()$tck)
    if(j %in% c(1,3,5,7)){
        axis(2, col=col.tick, mgp=par()$mgp, tck=par()$tck, at=c(-.1, 0, .1))
    }
    box(col=col.border)
}
plot(0,0, type='n', xlim=c(.27,1.05), ylim=c(-.17,.17), axes=FALSE, ann=FALSE)
legend("center", legend=c(1,2,5,10), pch=16, pt.cex=pch.cex,
       bty='n', horiz=TRUE, cex=.9, adj=0, xjust=3, col=rgb(0,0,0,.5),
       title='Bin Width (cm)')
##    box(col=col.border)
mtext("Relative Run Time", side=1, line=1.25, cex=par()$cex.lab, outer=TRUE)
mtext(paste("Median Relative Error:", species.labels[i]), side=2, line=1, cex=par()$cex.lab, outer=TRUE)
dev.off()
}

