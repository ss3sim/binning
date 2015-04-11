## Source this file to make exploratory plots. Need to load and prep data
## before sourcing

ggwidth <- 9
ggheight <- 7
library(ggplot2)
library(plyr)

### ------------------------------------------------------------
## First section is popbin effect
p <- popbins.binwidth[,c("species", "binwidth", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "binwidth")) %>%
  ggplot(aes(x=binwidth, y=value, colour=variable)) + geom_line() +
      facet_grid(species~F)+ xlab("Population bin width (cm)") +
    ylab("Relative change from base case")
ggsave(paste0("plots/popbins_binwidth.png"),p, width=ggwidth, height=ggheight)
p <- popbins.minsize[,c("species", "minsize", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "minsize")) %>%
  ggplot(aes(x=minsize, y=value, colour=variable)) + geom_line() +
      facet_grid(species~F)+ xlab("Population min bin (cm)") +
    ylab("Relative change from base case")
ggsave(paste0("plots/popbins_minsize.png"),p, width=ggwidth, height=ggheight)
p <- popbins.maxsize[,c("species", "max.Linf.ratio", 'F', paste0(scalars, "_RE"))] %>%
        melt(id.vars=c('species','F', "max.Linf.ratio")) %>%
  ggplot(aes(x=max.Linf.ratio, y=value, colour=variable)) + geom_line() +
      facet_grid(species~F, scales='free_x')+
          xlab("Population max bin:Linf ratio") +
    ylab("Relative change from base case")
ggsave(paste0("plots/popbins_maxsize.png"),p, width=ggwidth, height=ggheight)

### ------------------------------------------------------------



### For effect binning
for(spp in species){
    g <- plot_scalar_boxplot(subset(binning.long.growth, species==spp), x="variable", y='value',
                             vert='species', vert2="data", rel=TRUE,
                             horiz2="dbin", horiz="pbin", print=FALSE) +
                                 theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_growth_errors_",spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(binning.long.figure, species==spp), x="dbin", y='value',
                             vert='species', horiz="data", rel=TRUE,
                             vert2="variable", horiz2="binmatch", print=FALSE) +
                                 theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/binning_figure_errors_",spp, ".png"),g, width=ggwidth, height=ggheight)
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
    ## Plot MAREs vs iteration to address stability
    g <- ggplot(data=subset(binning.long.growth.mares, species==spp), aes(x=replicate2, y=cMARE, group=variable, color=variable))+
        ylab("Centered MARE") +xlab("Replicate")
    g <- g+geom_line(lwd=.5, alpha=1)+facet_grid(B~data)+ ylim(-.25, .25)
    ggsave(paste0("plots/binning_growth_MAREs_",spp, ".png"), width=ggwidth, height=ggheight, units="in")
    g <- ggplot(data=subset(binning.long.management.mares, species==spp), aes(x=replicate2, y=cMARE, group=variable, color=variable))+
        ylab("Centered MARE") +xlab("Replicate")
    g <- g+geom_line(lwd=.5, alpha=1)+facet_grid(B~data)+ ylim(-.25, .25)
    ggsave(paste0("plots/binning_management_MAREs_",spp, ".png"), width=ggwidth, height=ggheight, units="in")
    g <- ggplot(data=subset(binning.long.selex.mares, species==spp), aes(x=replicate2, y=cMARE, group=variable, color=variable))+
        ylab("Centered MARE") +xlab("Replicate")
    g <- g+geom_line(lwd=.5, alpha=1)+facet_grid(B~data)+ ylim(-.25, .25)
    ggsave(paste0("plots/binning_selex_MAREs_",spp, ".png"), width=ggwidth, height=ggheight, units="in")
    ## ## time series plots
    ## myylim <- ylim(-3,3)
    ## g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="SpawnBio_re", horiz="data",
    ##                      vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ## ggsave(paste0("plots/binning_ts_SBB_", spp, ".png"),g, width=ggwidth, height=ggheight)
    ## g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="Recruit_0_re", horiz="data",
    ##                      vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ## ggsave(paste0("plots/binning_ts_recruits_", spp, ".png"),g, width=ggwidth, height=ggheight)
    ## g <- plot_ts_boxplot(subset(binning.ts, species==spp), y="F_re", horiz="data",
    ##                      vert="dbin", vert2="pbin", print=FALSE, rel=FALSE)+myylim
    ## ggsave(paste0("plots/binning_ts_F_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- ggplot(subset(binning.long.growth2, species==spp & B %in% c("B1","B2", "B3", "B4")), aes(x=B0, y=value, color=B)) + geom_point(alpha=.5)+
        facet_wrap('variable', scales='fixed')+xlim(-1,1)+ylim(-1,1) +           ggtitle("Pairwise RE with base case for unmatching bins")+
            geom_hline(yintercept=0, col=gray(.5))+geom_vline(xintercept=0, col=gray(.5))
    ggsave(paste0("plots/binning_scatter_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- ggplot(subset(binning.long.growth2, species==spp & !B %in% c("B1","B2", "B3", "B4")), aes(x=B0, y=value, color=B)) + geom_point(alpha=.5)+
        facet_wrap('variable', scales='fixed')+xlim(-1,1)+ylim(-1,1) +
            ggtitle("Pairwise RE with base case for matching bins")+
                geom_hline(yintercept=0, col=gray(.5))+geom_vline(xintercept=0, col=gray(.5))
    ggsave(paste0("plots/binning_scatter2_", spp, ".png"),g, width=ggwidth, height=ggheight)
}
g <- ggplot(binning.counts, aes(x=data.binwidth, y=pct.converged, color=binmatch, group=binmatch))+
    geom_line()+ facet_grid(species~data, scales='fixed') +
        theme(axis.text.x=element_text(angle=90))
ggsave("plots/binning_convergence_counts.png", g, width=ggwidth, height=ggheight)
g <- ggplot(binning.counts, aes(x=data.binwidth, y=median.iterations, color=binmatch, group=binmatch))+
    geom_point(aes(size=pct.converged))+ facet_grid(species~data, scales='free') + geom_line()+
        theme(axis.text.x=element_text(angle=90))
ggsave("plots/binning_convergence_iterations.png", g, width=ggwidth, height=ggheight)
g <- ggplot(binning.runtime, aes(x=dbin, y=median.runtime, color=binmatch, group=binmatch))+
    geom_line()+ facet_grid(species~data, scales='free') +
    theme(axis.text.x=element_text(angle=90))+
    geom_point(aes(size=(replicates)))+
    geom_linerange(aes(ymin=lower.runtime, ymax=upper.runtime))
ggsave("plots/binning_median_runtime.png", g, width=ggwidth, height=ggheight)
## ## quick plots of bias adjustment
## ggplot(subset(bias.all.long, species=='flatfish'), aes(x=data, y=value))+geom_point() +
##     facet_grid(variable~species+B, scales="free_y")
## ggplot(scenarios.converged, aes(B, pct.converged))+geom_point()+facet_grid(species~data)


##### For tail compression
for(spp in species){
    g <- plot_scalar_boxplot(subset(tcomp.long.growth, species==spp ),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_growth_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(tcomp.long.selex, species==spp ),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_selex_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(tcomp.long.management, species==spp ),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_management_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
}
g <- ggplot(tcomp.unfiltered,
      aes(x=tvalue, y=log_max_grad, color=runtime,
          size=params_on_bound_em,))+
              geom_jitter()+ facet_grid(species~data)+
                  geom_hline(yintercept=log(.01), col='red')+
                      theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(tcomp.counts, aes(x=tvalue, y=pct.converged))+facet_grid(species~data+B)+
   geom_bar(stat='identity', aes(fill=pct.converged)) +  theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_convergence_counts.png", g, width=1.25*ggwidth, height=ggheight)
g <- ggplot(tcomp.stuck, aes(I, pct.stuck, group=which.bound, color=which.bound))+geom_line(lwd=1.5)+
    facet_grid(species+D~variable) + ylim(0,1)
ggsave("plots/tcomp_stuck_params.png", g, width=1.25*ggwidth, height=ggheight)
### end of  compression plots
### ------------------------------------------------------------


##### For robustification constant
for(spp in species){
    g <- plot_scalar_boxplot(subset(robust.long.growth, species==spp ),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_growth_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(robust.long.selex, species==spp ),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_selex_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(robust.long.management, species==spp ),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_management_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
}
g <- ggplot(robust.unfiltered,
      aes(x=rvalue, y=log_max_grad, color=runtime,
          size=params_on_bound_em,))+
              geom_jitter()+ facet_grid(species~data)+
                  geom_hline(yintercept=log(.01), col='red')+
                      theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(robust.counts, aes(x=rvalue, y=pct.converged))+facet_grid(species~data+B)+
   geom_bar(stat='identity', aes(fill=pct.converged)) +  theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_convergence_counts.png", g, width=1.25*ggwidth, height=ggheight)
g <- ggplot(robust.stuck, aes(I, pct.stuck, group=which.bound, color=which.bound))+geom_line(lwd=1.5)+
    facet_grid(species+D~variable) + ylim(0,1)
ggsave("plots/robust_stuck_params.png", g, width=1.25*ggwidth, height=ggheight)
### end of  robust plots
### ------------------------------------------------------------





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
