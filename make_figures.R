## Source this file to make the figures for the paper. Figures are just
## plots that appear in the paper. See also make_plots for more.
library(ggplot2)
library(r4ss)
library(dplyr)
## global options
width <- 7                             # inches
height <- 5
width2 <- 3
col.label <- gray(.2)
col.border <- gray(.5)
col.tick <- gray(.2)
print.letter <- function(label="(a)",xy=c(0.1,0.925),...) {
    tmp <- par("usr")
    text.x <- tmp[1]+xy[1]*diff(tmp[1:2])   #x position, diff=difference
    text.y <- tmp[3]+xy[2]*diff(tmp[3:4])   #y position
    text(x=text.x, y=text.y, labels=label, ...)
}
make.file <- function(type=c("png","pdf", "none"), filename,
                      width, height, res){
    ## Pass it file type and dimensions in inches. It creates file.
    type <- match.arg(type)
    ## If no extension given, add one
    if(length(grep(type, filename))==0)
        filename <- paste0(filename,".",type)
    if(type=="png") png(filename, width=width,
       height=height, units="in", res=res)
    else if(type=="pdf"){pdf(filename, width=width, height=height)}
    else if(dev.cur()==1) dev.new(width=width, height=height)
}

file.type <- 'png'

## These are fine tune adjustments for the y limits and MARE placement on
## the figures.
mare.adj.rbtc <- .725
mare.offset.rbtc <- .15
re.lim.rbtc <- c(-.95,.95)
re.at.rbtc <- c(-.75,0, .75)
mare.adj.bin <- .4
mare.offset.bin <- .07
re.lim.bin <- c(-.5,.5)
re.at.bin <- c(-.25,0, .25)

## 1. image plot / figure/table of lit. review
source("figures/figure1.R")
## 2. experimental design
source("figures/figure2.R")
## 3. OM pop bin results
source("figures/figure3.R")
## 4. estimation bin results
source('figures/figure4.R')
## 5. run time and accuracy for binning scenarios
source('figures/figure5.R')
## 6. robustifation errors
source('figures/figure6.R')
## 7. tail compression errors
source('figures/figure7.R')

## Make supplementary figures
binning.counts2 <- binning.counts
binning.counts2$data.case <- as.factor(ifelse(as.numeric(binning.counts$data) < 3,
                                    "Data Rich", "Data Limited"))
binning.counts2$data.type <- as.factor(ifelse(as.numeric(binning.counts$data) %in% c(1,3), "Age Comps", "CAAL"))
binning.counts2$match <- factor(binning.counts2$binmatch)
levels(binning.counts2$match) <- c("No", "Yes")
levels(binning.counts2$species) <- c("Cod", "Flatfish", "Rockfish")
binning.counts2 <- ddply(binning.counts2, .(species, data.case, data.type), mutate,
      runtime.normalized=median.runtime/median.runtime[which(data.binwidth==1)],
                         iterations.normalized=median.iterations/median.iterations[which(data.binwidth==1)])
g <- ggplot(binning.counts2, aes(x=data.binwidth, y=iterations.normalized, lty=match, group=binmatch))+
    geom_line()+ facet_grid(species~data.case+data.type, scales='free') +
    theme_bw() + xlab("Data Binwidth (cm)")+ylab("Normalized Median Iterations") + theme(legend.position="none")
ggsave("figures/figureS_iterations.png", g, width=9, height=5, dpi=500)
g <- ggplot(binning.counts2, aes(x=data.binwidth, y=(runtime.normalized), lty=match, group=binmatch))+
    geom_line()+ facet_grid(species~data.case+data.type, scales='free') +
    theme_bw() + xlab("Data Binwidth (cm)")+ylab("Normalized Median Runtime") + theme(legend.position="none")
ggsave("figures/figureS_runtime.png", g, width=9, height=5, dpi=500)
g <- ggplot(binning.counts2, aes(x=data.binwidth, y=(pct.converged), lty=match, group=binmatch))+
    geom_line()+ facet_grid(species~data.case+data.type, scales='free') +
    theme_bw() + xlab("Data Binwidth (cm)")+ylab("Convergece Rate") + theme(legend.position="none")
ggsave("figures/figureS_convergence.png", g, width=9, height=5, dpi=500)


## ## Some old code from playing with figures for convergence of rbtc. Not
## that telling so dropped for now....
## tcomp.counts2 <- tcomp.counts
## tcomp.counts2$data.case <- as.factor(ifelse(as.numeric(tcomp.counts$data) < 3,
##                                     "Data Rich", "Data Limited"))
## tcomp.counts2$data.type <- as.factor(ifelse(as.numeric(tcomp.counts$data) %in% c(1,3), "Age Comps", "CAAL"))
## levels(tcomp.counts2$species) <- c("Cod", "Flatfish", "Rockfish")
## tcomp.counts2 <- ddply(tcomp.counts2, .(species, data.case, data.type), mutate,
##       runtime.normalized=median.runtime/median.runtime[which(tvalue=="tcomp=-1")],
##       iterations.normalized=median.iterations/median.iterations[which(tvalue=="tcomp=-1")])
## tcomp.counts2$tvalue <- gsub("tcomp=", "", x=tcomp.counts2$tvalue)
## robust.counts2 <- robust.counts
## robust.counts2$data.case <- as.factor(ifelse(as.numeric(robust.counts$data) < 3,
##                                     "Data Rich", "Data Limited"))
## robust.counts2$data.type <- as.factor(ifelse(as.numeric(robust.counts$data) %in% c(1,3), "Age Comps", "CAAL"))
## levels(robust.counts2$species) <- c("Cod", "Flatfish", "Rockfish")
## robust.counts2$rvalue <- gsub("robust=", "", x=robust.counts2$rvalue)
## robust.counts2 <- ddply(robust.counts2, .(species, data.case, data.type), mutate,
##       runtime.normalized=median.runtime/median.runtime[which(rvalue=="robust=1e-10")],
##       iterations.normalized=median.iterations/median.iterations[which(rvalue=="robust=1e-10")])
## g1 <- ggplot(tcomp.counts2, aes(x=tvalue, y=(pct.converged), lty=data.type, group=data.type))+
##     geom_line()+ facet_grid(species~data.case, scales='free') +
##     theme_bw() + xlab("Data Binwidth (cm)")+ylab("Convergece Rate") +
##     ggtitle("Tail Compression")+ ylim(0,100)+
##     theme(legend.position="none",axis.text.x=element_text(angle=90))
## g2 <- ggplot(robust.counts2, aes(x=rvalue, y=(pct.converged), lty=data.type, group=data.type))+
##     geom_line()+ facet_grid(species~data.case, scales='free') +
##     theme_bw() + xlab("Data Binwidth (cm)")+ylab("Convergece Rate") +
##     ggtitle("Robustification Constant")+ ylim(0,100)+
##     theme(legend.position="none",axis.text.x=element_text(angle=90),
##           axis.text.y=element_blank(),
##           axis.title.y=element_blank())
## make.file(file.type, filename="figures/figureSAA_rbtc_convergence", width=9, height=5, res=500)
## multiplot(g1,g2, cols=2)
## dev.off()



## ## Took this from here: http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_%28ggplot2%29/
## # Multiple plot function
## #
## # ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
## # - cols:   Number of columns in layout
## # - layout: A matrix specifying the layout. If present, 'cols' is ignored.
## #
## # If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
## # then plot 1 will go in the upper left, 2 will go in the upper right, and
## # 3 will go all the way across the bottom.
## #
## multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
##   library(grid)

##   # Make a list from the ... arguments and plotlist
##   plots <- c(list(...), plotlist)

##   numPlots = length(plots)

##   # If layout is NULL, then use 'cols' to determine layout
##   if (is.null(layout)) {
##     # Make the panel
##     # ncol: Number of columns of plots
##     # nrow: Number of rows needed, calculated from # of cols
##     layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
##                     ncol = cols, nrow = ceiling(numPlots/cols))
##   }

##  if (numPlots==1) {
##     print(plots[[1]])

##   } else {
##     # Set up the page
##     grid.newpage()
##     pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))

##     # Make each plot, in the correct location
##     for (i in 1:numPlots) {
##       # Get the i,j matrix positions of the regions that contain this subplot
##       matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))

##       print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
##                                       layout.pos.col = matchidx$col))
##     }
##   }
## }
