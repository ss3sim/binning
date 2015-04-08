## manipulate the existing long data frame into what we want for plotting
d <- droplevels(subset(binning.long.figure, binmatch=="pbin=1cm" & data ==c("Rich:C+L")))
d <- ddply(d, .(species, dbin, variable), summarize,
            MARE=median(abs(value)),
            MRE=median(value),
            median.runtime=median(runtime),
            count=length(value))
d$binwidth <- with(d, as.numeric(gsub("dbin=","", x=dbin)))
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

make.file(file.type, filename='figures/figure5_tradeoffs.png',
          res=500, width=width, height=4)
par(mar=c(.1,.1,.1,.1), tck=-0.03, oma=c(2.5,3,1.5,.5),
    mgp=c(.5, .2,0), mfrow=c(3,7), cex.lab=.8, cex.axis=.75,
    col.axis=col.label, xpd=FALSE)
myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]),
                        "Depletion")
species.labels <- c("cod", "flatfish", "rockfish")
xy <- c(.1, .1); k <- 1
myletters <- c(letters, "aa", "ab")
for(i in seq_along(species)){
    for(j in seq_along(myvariables)){
        d.temp <- d[d$species==species[i] & d$variable==myvariables[j],]
        d.temp <- subset(d, species==myspecies[i] & variable==myvariables[j])
        plot(0,0, type='n', xlim=c(0,5.5), ylim=c(-.25,.25), axes=FALSE, ann=FALSE)
        abline(h=0, col=col.border)
        ## only make plots if had enough converged iterations
        with(d.temp, points(x=median.runtime, y=MRE, pch=16, cex=.5*seq_along(binwidth), col=rgb(0,0,0,.5)))
        print.letter(paste0("(", myletters[k], ")"), xy=xy, cex=.7); k <- k+1
        if(i==1) mtext(myvariables.labels[j], side=3, line=0, cex=par()$cex.lab)
        if(i==length(species))
            axis(1, col=col.border, mgp=par()$mgp, tck=par()$tck)
        if(j==1){
            mtext(species.labels[i], side=2, line=.9, cex=.7)
            axis(2, col=col.border, mgp=par()$mgp, tck=par()$tck)
        }
        box(col=col.border)
    }
}
mtext("Run Time (minutes)", side=1, line=1.1, cex=par()$cex.lab, outer=TRUE)
mtext("Median Relative Error", side=2, line=2, cex=par()$cex.lab, outer=TRUE)
dev.off()

