## Source this file to make exploratory plots. Need to load and prep data
## before sourcing

ggwidth <- 9
ggheight <- 7
library(ggplot2)
library(plyr)

### For effect binning
for(spp in species){
    g <- plot_scalar_boxplot(subset(binning.long.growth, species==spp), x="variable", y='value',
                             vert='species', vert2="data", rel=TRUE,
                             horiz2="dbin", horiz="pbin", print=FALSE) +
                                 theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_growth_errors_",spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(binning.long.selex, species==spp), x="variable", y='value', vert2='species', vert="data", rel=TRUE, horiz2="dbin", horiz="pbin", print=FALSE)+
        theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_selex_errors_", spp, ".png"), g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(binning.long.management, species==spp), x="variable",
                             y='value', vert2='species', vert="data", rel=TRUE, horiz2="dbin",
                             horiz="pbin", print=FALSE)+
                                 theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_management_errors_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- ggplot(subset(binning.unfiltered, species==spp), aes(x=data, y=log_max_grad, color=runtime, size=params_on_bound_em,))+
        geom_jitter()+
            facet_grid(species~dbin+pbin)+
                geom_hline(yintercept=log(.01), col='red')
    ggsave(paste0("plots/binning_convergence_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- ggplot(subset(binning.unfiltered, species==spp), aes(x=data, y=runtime, size=params_on_bound_em, color=converged))+
        geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
            facet_grid(.~pbin+dbin) +  theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_runtime_", spp, ".png"),g, width=ggwidth, height=ggheight)
    ## ## table of convergence
    ## plyr::ddply(binning.long, .(species, data, B), summarize,
    ##             median.logmaxgrad=round(median(log_max_grad),2),
    ##             max.stuck.on.bounds=max(params_on_bound_em))
    myylim <- ylim(-3,3)
    g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="SpawnBio_re", horiz="data",
                         vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ggsave(paste0("plots/binning_ts_SBB_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="Recruit_0_re", horiz="data",
                         vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ggsave(paste0("plots/binning_ts_recruits_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="F_re", horiz="data",
                         vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ggsave(paste0("plots/binning_ts_F_", spp, ".png"),g, width=ggwidth, height=ggheight)
}

## ## Temp code to explore correlations, needs to be fixed
## temp <- subset(binning, species=='cod')
## ggplot(temp, aes(L_at_Amin_Fem_GP_1_re, CV_young_Fem_GP_1_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(VonBert_K_Fem_GP_1_re, CV_young_Fem_GP_1_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(L_at_Amin_Fem_GP_1_re, VonBert_K_Fem_GP_1_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(CV_young_Fem_GP_1_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(LnQ_base_2_Survey_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(CV_young_Fem_GP_1_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(VonBert_K_Fem_GP_1_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(L_at_Amax_Fem_GP_1_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(SizeSel_2P_3_Survey_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(SizeSel_2P_1_Survey_re, SSB_MSY_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)

## ggplot(temp, aes(CV_young_Fem_GP_1_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(LnQ_base_2_Survey_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(CV_young_Fem_GP_1_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(VonBert_K_Fem_GP_1_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(L_at_Amax_Fem_GP_1_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(SizeSel_2P_3_Survey_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)
## ggplot(temp, aes(SizeSel_2P_1_Survey_re, SSB_Unfished_re))+
##     geom_point()+facet_grid(D~B)+xlim(-1,1)+ylim(-1,1)



##### For tail compression
g <- plot_scalar_boxplot(tcomp.long.growth, x="variable", y='value',
                         vert2='species', vert="B", rel=TRUE,
                         horiz="tvalue", print=FALSE) +
                             theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_growth_errors.png",g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(tcomp.long.selex, x="variable", y='value', vert2='species', vert="B", rel=TRUE, horiz="tvalue", print=FALSE)+
    theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_selex_errors.png", g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(tcomp.long.management, x="variable",
                         y='value', vert2='species', vert="B", rel=TRUE,
                         horiz="tvalue", print=FALSE)+
                             theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_management_errors.png",g, width=ggwidth, height=ggheight)
g <- ggplot(tcomp.unfiltered, aes(x=B, y=log_max_grad, color=runtime, size=params_on_bound_em,))+
    geom_jitter()+
        facet_grid(species~tvalue)+
            geom_hline(yintercept=log(.01), col='red')
ggsave("plots/tcomp_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(tcomp.unfiltered, aes(x=B, y=runtime, size=params_on_bound_em, color=converged))+
    geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
        facet_grid(species~tvalue)
ggsave("plots/tcomp_runtime.png",g, width=ggwidth, height=ggheight)
ggplot(tcomp.counts, aes(tvalue, pct.converged))+geom_point()+facet_grid(species~B)
## table of convergence
## plyr::ddply(tcomp.long, .(species, tvalue, B), summarize,
##             median.logmaxgrad=round(median(log_max_grad),2),
##             max.stuck.on.bounds=max(params_on_bound_em))

##### For robustification constant
g <- plot_scalar_boxplot(robust.long.growth, x="variable", y='value',
                         vert2='species', vert="B", rel=TRUE,
                         horiz="rvalue", print=FALSE) +
                             theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_growth_errors.png",g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(robust.long.selex, x="variable", y='value', vert2='species', vert="B", rel=TRUE, horiz="rvalue", print=FALSE)+
    theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_selex_errors.png", g, width=ggwidth, height=ggheight)
g <- plot_scalar_boxplot(robust.long.management, x="variable",
                         y='value', vert2='species', vert="B", rel=TRUE,
                         horiz="rvalue", print=FALSE)+
                             theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_management_errors.png",g, width=ggwidth, height=ggheight)
g <- ggplot(robust, aes(x=B, y=log_max_grad, color=runtime, size=params_on_bound_em,))+
    geom_jitter()+
        facet_grid(species~B+rvalue)+
            geom_hline(yintercept=log(.01), col='red')
ggsave("plots/robust_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(robust, aes(x=B, y=runtime, size=params_on_bound_em, color=converged))+
    geom_jitter()+ ylab("Runtime (minutes)")+
        facet_grid(species~B+rvalue)
ggsave("plots/robust_runtime.png",g, width=ggwidth, height=ggheight)
## table of convergence
plyr::ddply(robust.long, .(species, B, B), summarize,
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
##     merge(x=results.ts, y= subset(binning,
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
## plot_scalar_boxplot(binning, x="D", y="depletion_re", rel=TRUE)
## ggsave("plots/results.depletion.png", width=ggwidth, height=ggheight)
## growth.names <- paste0(c('L_at_Amin', 'L_at_Amax', 'VonBert_K', 'CV_young', 'CV_old'), '_Fem_GP_1_re')
## results.growth <- subset(binning, select=c('D', 'species', growth.names))
## results.growth.long <- reshape2::melt(results.growth, measure.vars=growth.names)
## levels(results.growth.long$variable) <- gsub('_Fem_GP_1', '', x=levels(results.growth.long$variable))
## plot_scalar_boxplot(results.growth.long, vert='variable', y='value', x='D', rel=TRUE)
## ggsave("plots/results.growth.re.png", width=9, height=5)



