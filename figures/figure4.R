for(spp in species){
for(dataquant in c("rich", "limited")){
d <- subset(binning.long.figure, species==spp & data.binwidth<20)
d <- ddply(d, .(data,binmatch,variable, data.binwidth), summarize,
            median_ = median(value, na.rm = TRUE),
            l2      = quantile(value, 0.25, na.rm = TRUE),
            u2      = quantile(value, 0.75, na.rm = TRUE),
           mare    = 100 * round(median(abs(value), na.rm = TRUE), 2),
           pct.converged=pct.converged[1],
           count = length(value))
d$color <- ifelse(d$binmatch=="pbin=1cm", "black", gray(.5))
d$binwidth <- d$data.binwidth #as.numeric(as.factor(d$data.binwidth))
d$text_pos <- d$binwidth-ifelse(d$binmatch!="pbin=1cm", .3, .1)-.1
d$binwidth <- d$binwidth+ifelse(d$binmatch=="pbin=1cm", 0, -.4)
make.file(file.type, filename=paste0('figures/figure4_errors_',spp,"_", dataquant),
          res=500, width=width*.9, height=3)
par(mar=0*c(.1,.1,.1,.1), tck=-0.03, oma=c(2.5,3,1.5,.75),
    mgp=c(.5, .075,0), mfrow=c(2,7), cex.lab=.8, cex.axis=.8,
    col.axis=col.label, xpd=FALSE)
if(dataquant=='rich'){
    mydata <- levels(d$data)[1:2]
    re.lim <- re.lim.bin.rich
    re.at <- re.at.bin.rich
} else {
    mydata <- levels(d$data)[3:4]
    re.lim <- re.lim.bin.limited
    re.at <- re.at.bin.limited
}
myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")[c(6,7, 1:5)]
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]), "depletion")[c(6,7, 1:5)]
mydata.labels <- c("Age Comps", "CAAL")
xy <- c(.1, .05); k <- 1
myletters <- c(letters, "aa", "ab")
for(i in seq_along(mydata)){
    for(j in seq_along(myvariables)){
        #d.temp <- subset(d, rows==myrows[i] & variable==myvariables[j])
        ## plot_re_panel(x=d.temp$data.binwidth, re=d.temp$value, beans=TRUE, dots=TRUE,
        ##               xaxis=FALSE, yaxis=FALSE, ylim=c(-1.5,1.5),
        ##               mare_pos=.5, xlim=c(1,20))
        d.temp <- droplevels(subset(d, data==mydata[i] & variable==myvariables[j]))
        plot(0,0, type='n', xlim=c(.9,10.2), ylim=re.lim, axes=FALSE, ann=FALSE)
        abline(h=0, col=col.border, lty=2)
        ## only make plots if had enough converged iterations
        d.temp1 <- subset(d.temp, pct.converged > pct.converged.min)
        d.temp2 <- subset(d.temp, pct.converged <= pct.converged.min)
        with(d.temp1, {
            points(x=binwidth, y=median_, pch=16, cex=.85, col=color)
            segments(x0=binwidth, y0=l2, y1=u2, col=color, lwd=.7)
            with(subset(d.temp1, binmatch=='pbin=1cm'),
                 lines(x=binwidth, y=median_, pch=16, lwd=.85, col=color))
            with(subset(d.temp1, binmatch!='pbin=1cm'),
                 lines(x=binwidth, y=median_, pch=16, lwd=.85, col=color))
            ## text(x=text_pos, y=mare.adj.bin+ifelse(color=='black',0, mare.offset.bin),
            ##      labels=mare, col=color, adj=c(0,0), cex=.8)
        })
        ## if(NROW(d.temp2)>0){with(d.temp2, {
        ##     points(binwidth, y=rep(0, NROW(d.temp2)), pch="x",
        ##            col=color, cex=.7)
        ##     text(x=text_pos, y=mare.adj.bin+ifelse(color=='black',0, mare.offset.bin),
        ##          labels="x", col=color, adj=c(0,0), cex=.8)})
        ## }
        print.letter(paste0("(", myletters[k], ")"), xy=xy, cex=.9); k <- k+1
        if(i==1) mtext(myvariables.labels[j], side=3, line=0, cex=par()$cex.lab)
        if(i==length(mydata))
            axis(1, at=c(1,2,5,10), col=col.tick, mgp=par()$mgp, tck=par()$tck)
        if(j==1){
            ## mtext(mydata.labels[i], side=2, line=.9, cex=.7)
            axis(2, col=col.tick, at=re.at.bin, mgp=par()$mgp, tck=par()$tck)
        }
        box(col=col.border)
    }
}
mtext("Age Compositions", side=2, line=.9, cex=.6, outer=TRUE, at=.75)
mtext("Conditional Age-at-length", side=2, line=.9, cex=.6, outer=TRUE, at=.25)
mtext("Data Bin Width (cm)", side=1, line=1.1, cex=par()$cex.lab, outer=TRUE)
mtext("Relative Error", side=2, line=1.7, cex=par()$cex.lab, outer=TRUE)
dev.off()

}
}
