for(spp in species){
d <- subset(binning.long.figure, species==spp)
d <- ddply(d, .(data,binmatch,variable, data.binwidth), summarize,
            median_ = median(value, na.rm = TRUE),
            l2      = quantile(value, 0.25, na.rm = TRUE),
            u2      = quantile(value, 0.75, na.rm = TRUE),
           mare    = 100 * round(median(abs(value), na.rm = TRUE), 2),
           count = length(value))
d$color <- ifelse(d$binmatch=="pbin=1cm", "black", gray(.5))
d$binwidth <- as.numeric(as.factor(d$data.binwidth))
d$text_pos <- d$binwidth-ifelse(d$binmatch!="pbin=1cm", -.1, .1)-.05
d$binwidth <- d$binwidth+ifelse(d$binmatch=="pbin=1cm", 0, .2)
make.file(file.type, filename=paste0('figures/figure4_binning_errors_', spp,".png"),
          res=500, width=width, height=height)
par(mar=c(.1,.1,.1,.1), tck=-0.03, oma=c(2.5,3,1.5,.5),
    mgp=c(.5, .075,0), mfrow=c(4,7), cex.lab=.8, cex.axis=.75,
    col.axis=col.label, xpd=FALSE)
mydata <- unique(d$data)
myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]), "depletion")
mydata.labels <- c("Age Comps", "CAAL", "Age Comps", "CAAL")
xy <- c(.1, .1); k <- 1
myletters <- c(letters, "aa", "ab")
for(i in seq_along(mydata)){
    for(j in seq_along(myvariables)){
        #d.temp <- subset(d, rows==myrows[i] & variable==myvariables[j])
        ## plot_re_panel(x=d.temp$data.binwidth, re=d.temp$value, beans=TRUE, dots=TRUE,
        ##               xaxis=FALSE, yaxis=FALSE, ylim=c(-1.5,1.5),
        ##               mare_pos=.5, xlim=c(1,20))
        d.temp <- droplevels(subset(d, data==mydata[i] & variable==myvariables[j]))
        plot(0,0, type='n', xlim=c(.5,5.5), ylim=c(-1.5,1.5), axes=FALSE, ann=FALSE)
        abline(h=0, col=col.border)
        ## only make plots if had enough converged iterations
        d.temp1 <- subset(d.temp, count > count.min)
        d.temp2 <- subset(d.temp, count <= count.min)
        with(d.temp1, {
            points(x=binwidth, y=median_, pch=16, cex=.5, col=color)
            segments(x0=binwidth, y0=l2, y1=u2, col=color)
            text(x=text_pos, y=.8+ifelse(color=='black',0, .3),
                 labels=mare, col=color, adj=c(0,0), cex=.7)})
        if(NROW(d.temp2)>0){with(d.temp2, {
            points(binwidth, y=rep(0, NROW(d.temp2)), pch="x",
                   col=color, cex=.7)
            text(x=text_pos, y=.8+ifelse(color=='black',0, .3),
                 labels="x", col=color, adj=c(0,0), cex=.7)})
                        }
        print.letter(paste0("(", myletters[k], ")"), xy=xy, cex=.7); k <- k+1
        if(i==1) mtext(myvariables.labels[j], side=3, line=0, cex=par()$cex.lab)
        if(i==length(mydata))
            axis(1, at=1:5, labels=c(1,2,5,10,20), col=col.border, mgp=par()$mgp, tck=par()$tck)
        if(j==1){
            mtext(mydata.labels[i], side=2, line=.9, cex=.7)
            axis(2, at=c(-1,0,1), col=col.border, mgp=par()$mgp, tck=par()$tck)
        }
        box(col=col.border)
    }
}
mtext("Data Rich", side=2, line=1.75, cex=par()$cex.lab, outer=TRUE, at=.75)
mtext("Data Poor", side=2, line=1.75, cex=par()$cex.lab, outer=TRUE, at=.25)
mtext("Bin Width (cm)", side=1, line=1, cex=par()$cex.lab, outer=TRUE)
#mtext("Relative Error", side=2, line=2, cex=par()$cex.lab, outer=TRUE)
dev.off()
}
