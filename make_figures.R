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
col.tick <- gray(.3)
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




