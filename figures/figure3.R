

## pop bin figure 3

xy <- c(.07,.925)
mycols <- rev(gray.colors(4, end=.7, start=0))
make.file(file.type, filename="figures/figure3_popbins", width=3.5,
          height=4.5, res=500)
par(mar=0*c(.5,.5,.5,.75), tck=-0.015, oma=c(2.75,4,3,.75),
    mgp=c(.5, .2,0), mfrow=c(3,2), cex.lab=.8, cex.axis=.9,
    col.axis=col.label, xpd=FALSE)
k <- 1
for(spp in species){
xoutside <- ifelse(spp=='yellow', TRUE, FALSE)
youtside <- ifelse(spp=='cod', TRUE,FALSE)
ts <- subset(popbins.binwidth.ts, species==spp)
sc <- subset(popbins.binwidth.scalars, species==spp)
bws <- c(2,5,10,20)
plot(0,0, xlim=c(0,20), ylim=c(-.36,.36), type='n', axes=FALSE, ann=FALSE)
print.letter(paste0("(", letters[k], ")"), xy=xy, cex=1); k <- k+1
abline(h=0, lty=1, col=col.border, lwd=.5)
with(sc, lines(binwidth, SSB_MSY_RE))
with(sc, lines(binwidth, depletion_RE, lty=2))
if(xoutside){
axis(1, col=col.tick, mgp=par()$mgp, tck=par()$tck)
mtext("Bin Width (cm)", side=1, line=1.5, cex=par()$cex.lab)
}
axis(2, col=col.tick, mgp=c(3,.3,0), tck=par()$tck)
box(col=col.border)
mtext("Relative Error", side=2, line=2.5, cex=1, outer=TRUE)
mtext(list('flatfish'='Flatfish', 'cod'='Cod', 'yellow'='Rockfish')[[spp]],
      side=2, line=1.2, cex=par()$cex.lab)
if(youtside) mtext("Management\nQuantities", side=3, line=.25, cex=.9)
if(spp=='cod')
    legend("bottomright", legend=c(expression(SSB[MSY]), "Depletion"), col=1,
           bty='n', title="Quantity", lty=c(1,2))
plot(0,0, xlim=c(0,101), ylim=c(-.3,.3), type='n', axes=FALSE, ann=FALSE)
print.letter(paste0("(", letters[k], ")"), xy=xy); k <- k+1
for(i in 1:4){
    with(subset(ts, binwidth.y==bws[i]),
         lines(Yr, SpawnBio_RE, col=mycols[i]))
}
if(spp=='cod')
    legend("bottomright", legend=paste(bws, "cm"), lty=1, col=mycols,
           bty='n', title="Bin Width", ncol=2)
if(xoutside){
    mtext("Year", side=1, line=1.5, cex=par()$cex.lab)
    axis(1, col=col.tick, mgp=par()$mgp, tck=par()$tck)
}
if(youtside) mtext("Spawning\nBiomass", side=3, line=.25, cex=.9)
box(col=col.border)
## plot(0,0, xlim=c(1,100), ylim=c(-.3,.3), type='n', axes=FALSE, ann=FALSE)
## print.letter(paste0("(", letters[k], ")"), xy=xy); k <- k+1
## for(i in 1:4){
##     with(subset(ts, binwidth.y==bws[i]),
##          lines(Yr, Recruit_0_RE, col=mycols[i]))
## }
## if(spp=='cod')
##     legend("bottomright", legend=paste(bws, "cm"), lty=1, col=mycols,
##            bty='n', title="Bin Width", ncol=2)
## if(xoutside){
##     mtext("Year", side=1, line=1.5, cex=par()$cex.lab)
##     axis(1, col=col.tick, mgp=par()$mgp, tck=par()$tck)
## }
## box(col=col.border)
## if(youtside) mtext("Recruitment", side=3, line=.5, cex=1.1)
}
dev.off()
## p1 <- ggplot(popbins.binwidth.ts, aes(Yr, Recruit_0_RE, colour = binwidth, group =
##                          binwidth)) + geom_line()+facet_wrap('species')
## p2 <- ggplot(popbins.binwidth.ts, aes(binwidth, SpawnBio_RE, colour = yr, group = binwidth)) + geom_line()
## pdf(paste0("plots/om_popbins_ts_", stock, ".pdf"), width = 5, height = 7)
## gridExtra::grid.arrange(p2, p1)
## dev.off()
