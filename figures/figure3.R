

## pop bin figure 3
spp <- 'flatfish'
ts <- subset(popbins.binwidth.ts, species==spp)
sc <- subset(popbins.binwidth.scalars, species==spp)
mycols <- rev(gray.colors(4, end=.7, start=0))
bws <- c(2,5,10,20)
make.file("png", filename="figures/figure3_popbins.png", width=width,
          height=3, res=500)
par(mar=c(2,.5,.5,.75), tck=-0.015, oma=c(.5,2,0,0),
    mgp=c(.5, .075,0), mfcol=c(1,3), cex.lab=.9, cex.axis=.9,
    col.axis=col.label, xpd=FALSE)
plot(0,0, xlim=c(1,24), ylim=c(-.3,.3), type='n', axes=FALSE, ann=FALSE)
abline(h=0)
with(sc, lines(binwidth, SSB_MSY_RE))
with(sc, lines(binwidth, depletion_RE, lty=2))
axis(1, col=col.border, mgp=par()$mgp, tck=par()$tck)
axis(2, col=col.border, mgp=par()$mgp, tck=par()$tck)
box(col=col.border)
mtext("Bin Width (cm)", side=1, line=1.1, cex=par()$cex.lab)
mtext("Relative Error", side=2, line=1.1, cex=par()$cex.lab)
mtext("Management Quantities", side=3, line=-1.5, cex=1)
legend("bottomright", legend=c("SSB_MSY", "Depletion"), col=1,
       bty='n', title="Quantity", lty=c(1,2))
plot(0,0, xlim=c(1,100), ylim=c(-.3,.3), type='n', axes=FALSE, ann=FALSE)
for(i in 1:4){
    with(subset(ts, binwidth==bws[i]),
         lines(Yr, SpawnBio_RE, col=mycols[i]))
}
legend("bottomright", legend=paste(bws, "cm"), lty=1, col=mycols,
       bty='n', title="Bin Width")
axis(1, col=col.border, mgp=par()$mgp, tck=par()$tck)
box(col=col.border)
mtext("Year", side=1, line=1.1, cex=par()$cex.lab)
mtext("Spawning Biomass", side=3, line=-1.5, cex=1)
plot(0,0, xlim=c(1,100), ylim=c(-.3,.3), type='n', axes=FALSE, ann=FALSE)
for(i in 1:4){
    with(subset(ts, binwidth==bws[i]),
         lines(Yr, Recruit_0_RE, col=mycols[i]))
}
legend("bottomright", legend=paste(bws, "cm"), lty=1, col=mycols,
       bty='n', title="Bin Width")
axis(1, col=col.border, mgp=par()$mgp, tck=par()$tck)
box(col=col.border)
mtext("Year", side=1, line=1.1, cex=par()$cex.lab)
mtext("Recruitment", side=3, line=-1.5, cex=1)
dev.off()

## p1 <- ggplot(popbins.binwidth.ts, aes(Yr, Recruit_0_RE, colour = binwidth, group =
##                          binwidth)) + geom_line()+facet_wrap('species')
## p2 <- ggplot(popbins.binwidth.ts, aes(binwidth, SpawnBio_RE, colour = yr, group = binwidth)) + geom_line()
## pdf(paste0("plots/om_popbins_ts_", stock, ".pdf"), width = 5, height = 7)
## gridExtra::grid.arrange(p2, p1)
## dev.off()
