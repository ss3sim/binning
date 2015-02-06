## Source this file to make exploratory plots. Need to load and prep data
## before sourcing

ggwidth <- 9
ggheight <- 5
library(ggplot2)

if(! all(exists('det.data.ts'), exists('det.data.sc'))) {
    det.data.ts <- read.csv("results/det.data.ts.csv")
    det.data.sc <- read.csv("results/det.data.sc.csv")
}
plot_ts_boxplot(det.data.ts, y="SpawnBio_re", vert="D", rel=TRUE)
ggsave("plots/det.data.SSB.png", width=ggwidth, height=ggheight)
plot_ts_boxplot(det.data.ts, y="Recruit_0_re", vert="D", rel=TRUE)
ggsave("plots/det.data.recdevs.png", width=ggwidth, height=ggheight)
plot_scalar_boxplot(det.data.sc, x="D", y="depletion_re", rel=TRUE)
ggsave("plots/det.data.depletion.png", width=ggwidth, height=ggheight)
growth.names <- paste0(c('L_at_Amin', 'L_at_Amax', 'VonBert_K', 'CV_young', 'CV_old'), '_Fem_GP_1_re')
det.data.growth <- subset(det.data.sc, select=c('D', 'species', growth.names))
det.data.growth.long <- reshape2::melt(det.data.growth, measure.vars=growth.names)
levels(det.data.growth.long$variable) <- gsub('_Fem_GP_1', '', x=levels(det.data.growth.long$variable))
plot_scalar_boxplot(det.data.growth.long, vert='variable', y='value', x='D', rel=TRUE)
ggsave("plots/det.data.growth.re.png", width=9, height=5)

if(! all(exists('det.bin.ts'), exists('det.bin.sc'))) {
    det.bin.ts <- read.csv("results/det.bin.ts.csv")
    det.bin.sc <- read.csv("results/det.bin.sc.csv")
}
det.bin.ts$bin_method <- ifelse(det.bin.ts$B=="B0", "Internal", "External")
det.bin.sc$bin_method <- ifelse(det.bin.sc$B=="B0", "Internal", "External")
det.bin.sc$bin_width <- ifelse(det.bin.sc$B=="I1" | det.bin.sc$B=="B1",
                               "2cm", "20cm")
det.bin.ts$bin_width <- ifelse(det.bin.ts$B=="I1" | det.bin.ts$B=="B1", "2cm", "20cm")
plot_ts_boxplot(det.bin.ts, y="SpawnBio_re", vert="bin_method", rel=TRUE,
                horiz="bin_width", axes=FALSE)
ggsave("plots/det.bin.SSB.png", width=ggwidth, height=ggheight)
plot_ts_boxplot(det.bin.ts, y="Recruit_0_re", vert="bin_method",
                horiz="bin_width" , rel=TRUE, axes=FALSE)
ggsave("plots/det.bin.recdevs.png", width=ggwidth, height=ggheight)
plot_scalar_boxplot(det.bin.sc, x="bin_width", vert="bin_method", y="depletion_re", rel=TRUE)
ggsave("plots/det.bin.depletion.png", width=ggwidth, height=ggheight)
growth.names <- paste0(c('L_at_Amin', 'L_at_Amax', 'VonBert_K', 'CV_young', 'CV_old'), '_Fem_GP_1_re')
det.bin.growth <- subset(det.bin.sc, select=c('bin_method', 'bin_width', 'species', growth.names))
det.bin.growth.long <- reshape2::melt(det.bin.growth, measure.vars=growth.names)
levels(det.bin.growth.long$variable) <- gsub('_Fem_GP_1', '', x=levels(det.bin.growth.long$variable))
plot_scalar_boxplot(det.bin.growth.long, horiz='bin_method', vert='variable', y='value', x='bin_width', rel=TRUE)
ggsave("plots/det.bin.growth.re.png", width=9, height=5)



## g <- plot_scalar_points(results, x="B", y="RunTime", color="log_max_grad",
##                     vert="L", horiz="A", vert2="species")
## ggsave("plots/conference_points_runtime.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="SSB_MSY_re", vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##     ylab("Relative Error: MSY")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_MSY.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="L_at_Amin_Fem_GP_1_re",vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##         ylab("Relative Error: Lmin")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_Lmin.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="L_at_Amax_Fem_GP_1_re",vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##     ylab("Relative Error: Linf")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_Linf.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="VonBert_K_Fem_GP_1_re",vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##     ylab("Relative Error: VB k")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_vbK.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="CV_young_Fem_GP_1_re",vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##     ylab("Relative Error: CV young")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_CVyoung.png", g, width=width, height=height)
## g <- plot_scalar_boxplot(df, x="B.width", y="CV_old_Fem_GP_1_re",vert2="species",
##                     horiz="A", vert="L", relative=TRUE) +
##     ylab("Relative Error: CV old")+xlab("Bin Width (cm)")
## ggsave("plots/conference_boxplots_CVold.png", g, width=width, height=height)
## plot_scalar_points(results_re, x="CV_young_Fem_GP_1_re", horiz="A",
##                    vert="L", vert2="species",
##                    y="CV_old_Fem_GP_1_re", col="logmaxgrad")
## plot_scalar_points(results_re, x="CV_young_Fem_GP_1_re", horiz="A",
##                    vert="L", vert2="species",
##                    y="CV_old_Fem_GP_1_re", col="params_on_bound")
## plot_scalar_points(df, x="CV_young_Fem_GP_1_re", horiz="A",
##                    vert="L", vert2="species",
##                    y="CV_old_Fem_GP_1_re", col="logmaxgrad")
## plot_scalar_points(df, x="CV_young_Fem_GP_1_re", horiz="A",
##                    vert="L", vert2="species",
##                    y="CV_old_Fem_GP_1_re", col="params_on_bound")
