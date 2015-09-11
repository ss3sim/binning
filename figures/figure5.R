## performanc3e by species

levels(binning.counts.normalized$data) <-
    c("Rich: Age Comps", "Rich: CAAL", "Limited: Age Comps", "Limited: CAAL")
dcases <- levels(binning.counts.normalized$data)
xy <- c(.07,.925)
mycols <- rev(gray.colors(4, end=.7, start=0))
lwd.temp <- 2.5
cex.pch <- 1.1
cex.letters <- 1.25
for(spp in species){
make.file(file.type, filename=paste0("figures/figure5_performance_", spp), width=width,
          height=height*1.25, res=500)
par(mar=0*c(.5,.5,.5,.75), tck=-0.015, oma=c(2.75,3,2,.75),
    mgp=c(.5, .2,0), mfrow=c(4,4), cex.lab=1, cex.axis=1.1,
    col.axis=col.label, xpd=FALSE)
k <- 1
yy <- subset(binning.counts.normalized, species==spp)
## Plot convergence rates
for(d in dcases){
    youtside <- ifelse(d==dcases[1], TRUE, FALSE)
    plot(0,0, xlim=c(0,20), ylim=c(0,112), type='n', axes=FALSE, ann=FALSE)
    print.letter(paste0("(", letters[k], ")"), xy=xy, cex=cex.letters); k <- k+1
    ##    abline(h=.5, lty=1, col=col.border, lwd=.5)
    xx <- subset(yy, match=='No' & data==d)
    with(xx, lines(data.binwidth, pct.converged, lwd=lwd.temp))
    with(xx, points(data.binwidth, pct.converged, pch=16, cex=cex.pch))
    xx <- subset(yy, match=='Yes' & data==d)
    with(xx, lines(data.binwidth, pct.converged, lty=1, lwd=lwd.temp, col=gray(.5)))
    with(xx, points(data.binwidth, pct.converged, pch=21, bg='white', cex=cex.pch))
    if(youtside){
        axis(2, at=c(0, 25,50,75,100), col=col.tick, mgp=c(3,.3,0), tck=par()$tck)
        mtext("% Converged", side=2, line=1.5, cex=par()$cex.lab)
    }
    mtext(d, side=3, line=.5, cex=par()$cex.lab)
    box(col=col.border)
}
for(d in dcases){
    youtside <- ifelse(d==dcases[1], TRUE, FALSE)
    plot(0,0, xlim=c(0,20), ylim=c(0,1.2), type='n', axes=FALSE, ann=FALSE)
    print.letter(paste0("(", letters[k], ")"), xy=xy, cex=cex.letters); k <- k+1
    abline(h=1, col=col.border, lwd=.5, lty=3)
    xx <- subset(yy, match=='No' & data==d)
    with(xx, lines(data.binwidth, runtime.normalized, lwd=lwd.temp))
    with(xx, points(data.binwidth, runtime.normalized, pch=16, cex=cex.pch))
    xx <- subset(yy, match=='Yes' & data==d)
    with(xx, lines(data.binwidth, runtime.normalized, lty=1, lwd=lwd.temp, col=gray(.5)))
    with(xx, points(data.binwidth, runtime.normalized, pch=21, bg='white', cex=cex.pch))
    if(youtside){
        axis(2, at=c(0, .5,1), col=col.tick, mgp=c(3,.3,0), tck=par()$tck)
        mtext("Runtime", side=2, line=1.5, cex=par()$cex.lab)
    }
    box(col=col.border)
}
for(d in dcases){
    youtside <- ifelse(d==dcases[1], TRUE, FALSE)
    plot(0,0, xlim=c(0,20), ylim=c(1,3.5), type='n', axes=FALSE, ann=FALSE)
    print.letter(paste0("(", letters[k], ")"), xy=xy, cex=cex.letters); k <- k+1
    abline(h=1, col=col.border, lwd=.5, lty=3)
    xx <- subset(yy, match=='No' & data==d)
    with(xx, lines(data.binwidth, iterations.normalized, lwd=lwd.temp))
    with(xx, points(data.binwidth, iterations.normalized, pch=16, cex=cex.pch))
    xx <- subset(yy, match=='Yes' & data==d)
    with(xx, lines(data.binwidth, iterations.normalized, lty=1, lwd=lwd.temp, col=gray(.5)))
    with(xx, points(data.binwidth, iterations.normalized, pch=21, bg='white', cex=cex.pch))
    if(youtside){
        legend("topright", cex=1.1,
               legend=c("=1cm", "=Data bin width"), col=c(1,gray(.5)), lwd=lwd.temp,
               bty='n', title="Model bin width", lty=c(1,1), pch=c(16,21),
               pt.cex=cex.pch, pt.bg=c('black', 'white'))
        axis(2, at=c(1,2,3), col=col.tick, mgp=c(3,.3,0), tck=par()$tck)
        mtext("Iterations", side=2, line=1.5, cex=par()$cex.lab)
    }
    box(col=col.border)
}
for(d in dcases){
    youtside <- ifelse(d==dcases[1], TRUE, FALSE)
    plot(0,0, xlim=c(0,20), ylim=c(0,1.15), type='n', axes=FALSE, ann=FALSE)
    print.letter(paste0("(", letters[k], ")"), xy=xy, cex=cex.letters); k <- k+1
    abline(h=1, col=col.border, lwd=.5, lty=3)
    xx <- subset(yy, match=='No' & data==d)
    with(xx, lines(data.binwidth, runtime.normalized/iterations.normalized, lwd=lwd.temp))
    with(xx, points(data.binwidth, runtime.normalized/iterations.normalized, pch=16, cex=cex.pch))
    xx <- subset(yy, match=='Yes' & data==d)
    with(xx, lines(data.binwidth, runtime.normalized/iterations.normalized, lty=1, lwd=lwd.temp, col=gray(.5)))
    with(xx, points(data.binwidth, runtime.normalized/iterations.normalized, pch=21, bg='white', cex=cex.pch))
    if(youtside){
        axis(2, at=c(0, .5, 1), col=col.tick, mgp=c(3,.3,0), tck=par()$tck)
        mtext("Runtime/Iterations", side=2, line=1.5, cex=par()$cex.lab)
    }
    axis(1, at=c(1,2,5,10,20), col=col.tick, mgp=par()$mgp, tck=par()$tck)
    box(col=col.border)
}
mtext("Data bin Width (cm)", side=1, line=1.5, cex=par()$cex.lab, outer=TRUE)
dev.off()
}


## ## these are the old ggplot versions from the original submission,
## reworked them on reresubmission to be by species
## g <- ggplot(binning.counts2, aes(x=data.binwidth, y=iterations.normalized, lty=match, group=binmatch))+
##     geom_line()+ facet_grid(species~data.case+data.type, scales='free') +
##     theme_bw() + xlab("Data Binwidth (cm)")+ylab("Normalized Median Iterations") + theme(legend.position="none")
## ggsave(paste0("figures/figureS9_iterations.", file.type), g, width=9, height=5, dpi=500)
## g <- ggplot(binning.counts2, aes(x=data.binwidth, y=(runtime.normalized), lty=match, group=binmatch))+
##     geom_line()+ facet_grid(species~data.case+data.type, scales='free') +
##     theme_bw() + xlab("Data Binwidth (cm)")+ylab("Normalized Median Runtime") + theme(legend.position="none")
## ggsave(paste0("figures/figureS4_runtime.", file.type), g, width=9, height=5, dpi=500)
## g <- ggplot(binning.counts2, aes(x=data.binwidth, y=(pct.converged), lty=match, group=binmatch))+
##     geom_line()+ facet_grid(species~data.case+data.type, scales='free') + ylim(0,100)+
##     theme_bw() + xlab("Data Binwidth (cm)")+ylab("Convergece Rate") + theme(legend.position="none")
## ggsave(paste0("figures/figureS3_convergence.", file.type), g, width=9, height=5, dpi=500)
