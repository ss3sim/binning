## Source this file to make exploratory plots. Need to load and prep data
## before sourcing

ggwidth <- 9
ggheight <- 5
library(ggplot2)
library(plyr)

g <- plot_scalar_boxplot(results.sc.long.growth, x="variable", y='value',
                         vert2='species', vert="D", rel=TRUE,
                         horiz2="data.binwidth", horiz="pop.binwidth", print=FALSE) +
    theme(axis.text.x=element_text(angle=90))
ggsave("plots/growth_errors.png",g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(results.sc.long.selex, x="variable", y='value', vert2='species', vert="D", rel=TRUE, horiz2="data.binwidth", horiz="pop.binwidth", print=FALSE)+
    theme(axis.text.x=element_text(angle=90))
ggsave("plots/selex_errors.png", g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(results.sc.long.management, x="variable",
      y='value', vert2='species', vert="D", rel=TRUE, horiz2="data.binwidth",
                         horiz="pop.binwidth", print=FALSE)+
    theme(axis.text.x=element_text(angle=90))
ggsave("plots/management_errors.png",g, width=ggwidth, height=ggheight)
g <- ggplot(results.sc, aes(x=D, y=log_max_grad, color=runtime, size=params_on_bound_em,))+
    geom_jitter()+
    facet_grid(species~data.binwidth+pop.binwidth)+
        geom_hline(yintercept=log(.01), col='red')
ggsave("plots/convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(results.sc, aes(x=D, y=runtime, size=params_on_bound_em, color=converged))+
    geom_jitter()+ ylab("Runtime (minutes)")+
    facet_grid(species~data.binwidth+pop.binwidth)
ggsave("plots/runtime.png",g, width=ggwidth, height=ggheight)
## table of convergence
plyr::ddply(results.sc.long, .(species, D, B), summarize,
            median.logmaxgrad=round(median(log_max_grad),2),
            max.stuck.on.bounds=max(params_on_bound_em))

## ## make time series plots
## sto.ts <- read.csv("sto_ts.csv")
## sto.ts$D <- "stochastic"
## det.ts <- read.csv("det_ts.csv")
## det.ts$D <- "deterministic"
## results.ts <- rbind(sto.ts, det.ts)
## results.ts <- calculate_re(results.ts, add=TRUE)
## results.ts <-
##     merge(x=results.ts, y= subset(results.sc,
##      select=c("ID", "params_on_bound_em", "log_max_grad")), by="ID")
## re.names <- names(results.ts)[grep("_re", names(results.ts))]
## results.ts.long <-
##     melt(results.ts, measure.vars=re.names,
##          id.vars= c("ID","species", "D", "replicate",
##          "log_max_grad", "params_on_bound_em", "year"))
## g <- plot_ts_lines(results.ts.long,  y='value', vert="variable", vert2="D",
##                    horiz='species', rel=TRUE, color='log_max_grad')
## ggsave("plots/ts.results.png", g, width=9, height=ggheight)
## g <- plot_ts_lines(results.ts, y="SpawnBio_om", horiz="species",
##                    vert="D", color="log_max_grad")
## ggsave("plots/ts.convergence.png", g, width=9, height=ggheight)
## plot_ts_boxplot(results.ts, y="SpawnBio_re", vert="D", rel=TRUE)
## ggsave("plots/results.SSB.png", width=ggwidth, height=ggheight)
## plot_ts_boxplot(results.ts, y="Recruit_0_re", vert="D", rel=TRUE)
## ggsave("plots/results.recdevs.png", width=ggwidth, height=ggheight)
## plot_scalar_boxplot(results.sc, x="D", y="depletion_re", rel=TRUE)
## ggsave("plots/results.depletion.png", width=ggwidth, height=ggheight)
## growth.names <- paste0(c('L_at_Amin', 'L_at_Amax', 'VonBert_K', 'CV_young', 'CV_old'), '_Fem_GP_1_re')
## results.growth <- subset(results.sc, select=c('D', 'species', growth.names))
## results.growth.long <- reshape2::melt(results.growth, measure.vars=growth.names)
## levels(results.growth.long$variable) <- gsub('_Fem_GP_1', '', x=levels(results.growth.long$variable))
## plot_scalar_boxplot(results.growth.long, vert='variable', y='value', x='D', rel=TRUE)
## ggsave("plots/results.growth.re.png", width=9, height=5)



