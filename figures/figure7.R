for(spp in species){

d <- subset(robust.long.figure, species==spp)
d <- ddply(d, .(data,variable, rvalue), summarize,
           pct.converged=pct.converged[1],
            median_ = median(value, na.rm = TRUE),
            l2      = quantile(value, 0.25, na.rm = TRUE),
            u2      = quantile(value, 0.75, na.rm = TRUE),
           mare    = 100 * round(median(abs(value), na.rm = TRUE), 2),
           count = length(value))
d$data.case <- ifelse(as.character(d$data) %in% c("Rich:A+L", "Rich:C+L"), "rich", "poor")
d$color <- ifelse(as.character(d$data) %in% c("Rich:A+L", "Poor:A+L"), "black", gray(.5))
d$text_pos <- ifelse(d$color!="black", -.1, .1)-.1
d$xvalue <- as.numeric(as.factor(d$rvalue))
d$xvalue <- d$xvalue+ifelse(d$color=="black", 0, .2)
make.file(file.type, filename=paste0('figures/figure7_robust_errors_', spp,".png"),
          res=500, width=width, height=3)
par(mar=0*c(.1,.1,.1,.1), tck=-0.03, oma=c(3,3,1.5,.75),
    mgp=c(.5, .075,0), mfrow=c(2,7), cex.lab=.8, cex.axis=.8,
    col.axis=col.label, xpd=FALSE)
mydata <- c("rich", "poor")
myvariables <- c("CV_young", "CV_old", "L_at_Amin", "L_at_Amax",
                 "VonBert_K", "SSB_MSY", "depletion")[c(6,7, 1:5)]
myvariables.labels <- c(expression(CV[young]), expression(CV[old]),
                        expression(L[min]), expression(L[infinity]),
                        expression(italic(k)), expression(SSB[MSY]), "Depletion")[c(6,7, 1:5)]
mydata.labels <- c("Data Rich", "Data Limited") #c("Age Comps", "CAAL", "Age Comps", "CAAL")
xlabs <- gsub("robust=", "", levels(robust.long.figure$rvalue))
xy <- c(.1, .05); k <- 1
myletters <- c(letters, "aa", "ab")
for(i in seq_along(mydata)){
    for(j in seq_along(myvariables)){
        d.temp <- droplevels(subset(d, data.case==mydata[i] & variable==myvariables[j]))
        plot(0,0, type='n', xlim=c(.9,4.5), ylim=re.lim.rbtc, axes=FALSE, ann=FALSE)
        abline(h=0, col=col.border, lty=2)
        ## only make plots if had enough converged iterations
        d.temp1 <- subset(d.temp, pct.converged > pct.converged.min)
        d.temp2 <- subset(d.temp, pct.converged <= pct.converged.min)
        with(d.temp1, {
            points(x=xvalue, y=median_, pch=16, cex=.85, col=color)
            segments(x0=xvalue, y0=l2, y1=u2, col=color, lwd=.7)
            text(x=xvalue, y=mare.adj.rbtc+ifelse(color=='black',0, mare.offset.rbtc),
                 labels=mare, col=color, adj=c(0,0), cex=.8)})
        ## if(NROW(d.temp2)>0){
        ##     with(d.temp2, {
        ##     points(xvalue, y=rep(0, NROW(d.temp2)), pch="x",
        ##            col=color, cex=.7)
        ##     text(x=xvalue, y=mare.adj.rbtc+ifelse(color=='black',0, mare.offset.rbtc),
        ##          labels="x", col=color, adj=c(0,0), cex=.8)})
        ##                 }
        print.letter(paste0("(", myletters[k], ")"), xy=xy, cex=.9); k <- k+1
        if(i==1) mtext(myvariables.labels[j], side=3, line=0, cex=par()$cex.lab)
        if(i==length(mydata))
            axis(1, at=1:4, labels=xlabs, col=col.tick, mgp=c(.5,.3,0),
                 tck=par()$tck, las=2)
        if(j==1){
            ## mtext(mydata.labels[i], side=2, line=.9, cex=.7)
            axis(2, at=re.at.rbtc, col=col.tick, mgp=par()$mgp, tck=par()$tck)
        }
        box(col=col.border)
    }
}
mtext("Data Rich", side=2, line=.9, cex=.6, outer=TRUE, at=.75)
mtext("Data Limited", side=2, line=.9, cex=.6, outer=TRUE, at=.25)
mtext("Robustification Constant", side=1, line=1.95, cex=par()$cex.lab, outer=TRUE)
mtext("Relative Error", side=2, line=1.7, cex=par()$cex.lab, outer=TRUE)
dev.off()
}

