for(spp in species){
d <- subset(robust.long.figure, species==spp)
d <- ddply(d, .(data,variable, rvalue), summarize,
            median_ = median(value, na.rm = TRUE),
            l2      = quantile(value, 0.25, na.rm = TRUE),
            u2      = quantile(value, 0.75, na.rm = TRUE),
           mare    = 100 * round(median(abs(value), na.rm = TRUE), 2),
           count = length(value))
d$rvalue <- as.numeric(as.factor(d$rvalue))
make.file(file.type, filename=paste0('figures/figure7_robust_errors_', spp,".png"),
          res=500, width=width, height=height)
par(mar=c(.1,.1,.1,.1), tck=-0.03, oma=c(3.5,3,1.5,.5),
    mgp=c(.5, .2,0), mfrow=c(4,7), cex.lab=.8, cex.axis=.75,
    col.axis=col.label, xpd=FALSE)
mydata <- unique(d$data)
myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]), "Depletion")
mydata.labels <- c("Age Comps", "CAAL", "Age Comps", "CAAL")
xlabs <- gsub("robust=", "", levels(robust.long.figure$rvalue))
xy <- c(.1, .1); k <- 1
myletters <- c(letters, "aa", "ab")
for(i in seq_along(mydata)){
    for(j in seq_along(myvariables)){
        #d.temp <- subset(d, rows==myrows[i] & variable==myvariables[j])
        ## plot_re_panel(x=d.temp$data.binwidth, re=d.temp$value, beans=TRUE, dots=TRUE,
        ##               xaxis=FALSE, yaxis=FALSE, ylim=c(-1.5,1.5),
        ##               mare_pos=.5, xlim=c(1,20))
        d.temp <- droplevels(subset(d, data==mydata[i] & variable==myvariables[j]))
        plot(0,0, type='n', xlim=c(.5,5.5), ylim=c(-1.25,1.25), axes=FALSE, ann=FALSE)
        abline(h=0, col=col.border)
        ## only make plots if had enough converged iterations
        d.temp1 <- subset(d.temp, count > count.min)
        d.temp2 <- subset(d.temp, count <= count.min)
        with(d.temp1, {
            points(x=rvalue, y=median_, pch=16, cex=.5, col=1)
            segments(x0=rvalue, y0=l2, y1=u2, col=1)
            text(x=rvalue, y=1.1,
                 labels=mare, col=1, adj=c(0,0), cex=.7)})
        if(nrow(d.temp2)>0){
            with(d.temp2, {
                points(rvalue, y=rep(0, NROW(d.temp2)), pch="x",
                       col=1, cex=.7)
                text(x=rvalue, y=.8+ifelse(1=='black',0, .3),
                     labels="x", col=1, adj=c(0,0), cex=.7)})
        }
        print.letter(paste0("(", myletters[k], ")"), xy=xy, cex=.7); k <- k+1
        if(i==1) mtext(myvariables.labels[j], side=3, line=0, cex=par()$cex.lab)
        if(i==length(mydata))
            axis(1, las=2, at=seq_along(xlabs), labels=xlabs, col=col.border, mgp=par()$mgp, tck=par()$tck)
        if(j==1){
            mtext(mydata.labels[i], side=2, line=.9, cex=.7)
            axis(2, at=c(-1,0,1), col=col.border, mgp=par()$mgp, tck=par()$tck)
        }
        box(col=col.border)
    }
}
mtext("Data Rich", side=2, line=1.75, cex=par()$cex.lab, outer=TRUE, at=.75)
mtext("Data Poor", side=2, line=1.75, cex=par()$cex.lab, outer=TRUE, at=.25)
mtext("Tail Compression Value", side=1, line=2, cex=par()$cex.lab, outer=TRUE)
#mtext("Relative Error", side=2, line=2, cex=par()$cex.lab, outer=TRUE)
dev.off()
}
