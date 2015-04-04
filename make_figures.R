## Source this file to make the figures for the paper. Figures are just
## plots that appear in the paper. See also make_plots for more.
library(ggplot2)
library(r4ss)
library(dplyr)
## global options
width <- 7                             # inches
height <- 5
col.label <- gray(.2)
col.border <- gray(.5)
col.tick <- gray(.5)

## 1. image plot / figure/table of lit. review
## 2. experimental design
## 3. OM bin stuff - flatfish - send code for spawn-bio-RE to Cole
## 4. estimation bin results - add beanaplots to function, put it in makefigure file flatfish
## 5. run time and accuracy
## 6. robustifation
## 7. tail compression
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
source("figures/figure1.R")
source("figures/figure2.R")
source("figures/figure3.R")

str(binning.long)
## get MARE for each growth parameter
df <- ddply(binning.long.growth, .(species, data, dbin, binmatch,variable), summarize,
            MARE=median(abs(value)),
            median.runtime=median(runtime))
## get some measure of total MARE by plying over variable
df2 <- ddply(df, .(species, data, dbin, binmatch), summarize,
             MARE.median=median(MARE),
             MARE.sum=sum(MARE),
             median.runtime=median.runtime[1])
df2$binwidth <- with(df2, as.numeric(gsub("dbin=","", x=dbin)))
g <- ggplot(df2, aes(log(median.runtime), log(MARE.median), size=binwidth, color=binmatch))+geom_point()+facet_grid(data~species)
ggsave('plots/binning_performance_tradeoffs.png', g,  width=7, height=5)







