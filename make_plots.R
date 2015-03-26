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
    g <- ggplot(subset(binning.unfiltered, species==spp & binmatch=="no match"), aes(x=dbin, y=runtime, size=params_on_bound_em, color=converged))+
        geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
            facet_grid(data~pbin) +
                theme(axis.text.x=element_text(angle=90))#+ylim(0, 3)
    ggsave(paste0("plots/binning_runtime_", spp, ".png"),g, width=ggwidth, height=ggheight)
    g <- ggplot(subset(binning.unfiltered, species==spp & binmatch=="match"), aes(x=pbin, y=runtime, size=params_on_bound_em, color=converged))+
        geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
            facet_grid(data~.) +  theme(axis.text.x=element_text(angle=90))#+ylim(0, 3)
    ggsave(paste0("plots/binning_runtime_", spp, "2.png"),g, width=ggwidth, height=ggheight)
    ## ## table of convergence
    plyr::ddply(binning.long, .(species, data, B), summarize,
                median.logmaxgrad=round(median(log_max_grad),2),
                max.stuck.on.bounds=max(params_on_bound_em))
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
g <- ggplot(binning.counts, aes(x=data, y=pct.converged))+facet_grid(B~species)+
   geom_bar(stat='identity', aes(fill=pct.converged)) +  theme(axis.text.x=element_text(angle=90))
ggsave("plots/binning_convergence_counts.png", g, width=ggwidth, height=ggheight)

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
B.temp <- "B1" # only showing this in the plots
for(spp in species){
    g <- plot_scalar_boxplot(subset(tcomp.long.growth, species==spp & B==B.temp),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_growth_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(tcomp.long.selex, species==spp & B==B.temp),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_selex_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(tcomp.long.management, species==spp & B==B.temp),
               x="tvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/tcomp_management_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
}
g <- ggplot(subset(tcomp.unfiltered, B==B.temp),
      aes(x=tvalue, y=log_max_grad, color=runtime,
          size=params_on_bound_em,))+
              geom_jitter()+ facet_grid(species~data)+
                  geom_hline(yintercept=log(.01), col='red')+
                      theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(tcomp,
            aes(x=tvalue, y=runtime, color=B))+
         geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
             facet_grid(species~data)+ ggtitle("Converged model runtime")+
                 theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_runtime.png",g, width=ggwidth, height=ggheight)
g <- ggplot(tcomp.counts, aes(x=tvalue, y=pct.converged))+facet_grid(species~data+B)+
   geom_bar(stat='identity', aes(fill=pct.converged)) +  theme(axis.text.x=element_text(angle=90))
ggsave("plots/tcomp_convergence_counts.png", g, width=1.25*ggwidth, height=ggheight)
### end of  compression plots
### ------------------------------------------------------------

##### For robustification
B.temp <- "B1" # only showing this in the plots
for(spp in species){
    g <- plot_scalar_boxplot(subset(robust.long.growth, species==spp & B==B.temp),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_growth_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(robust.long.selex, species==spp & B==B.temp),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_selex_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
    g <- plot_scalar_boxplot(subset(robust.long.management, species==spp & B==B.temp),
               x="rvalue", y='value', vert='data', vert2="B",
               rel=TRUE, horiz="variable", print=FALSE) + ggtitle(spp)+
                   theme(axis.text.x=element_text(angle=90))
    ggsave(paste0("plots/robust_management_errors_",spp,".png"),g, width=ggwidth, height=ggheight)
}
g <- ggplot(subset(robust.unfiltered, B==B.temp),
      aes(x=rvalue, y=log_max_grad, color=runtime,
          size=params_on_bound_em,))+
              geom_jitter()+ facet_grid(species~data)+
                  geom_hline(yintercept=log(.01), col='red')+
                      theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_convergence.png",g, width=ggwidth, height=ggheight)
g <- ggplot(robust,
            aes(x=rvalue, y=runtime, color=B))+
         geom_jitter(alpha=.5)+ ylab("Runtime (minutes)")+
             facet_grid(species~data)+ ggtitle("Converged model runtime")+
                 theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_runtime.png",g, width=ggwidth, height=ggheight)
g <- ggplot(robust.counts, aes(x=rvalue, y=pct.converged))+facet_grid(species~data+B)+
   geom_bar(stat='identity', aes(fill=pct.converged)) +  theme(axis.text.x=element_text(angle=90))
ggsave("plots/robust_convergence_counts.png", g, width=1.25*ggwidth, height=ggheight)
### end of  compression plots
### ------------------------------------------------------------



## ##### For robustification constant
## g <- plot_scalar_boxplot(robust.long.growth, x="variable", y='value',
##                          vert2='species', vert="B", rel=TRUE,
##                          horiz="rvalue", print=FALSE) +
##                              theme(axis.text.x=element_text(angle=90))
## ggsave("plots/robust_growth_errors.png",g, width=ggwidth, height=ggheight)
## g <- plot_scalar_boxplot(robust.long.selex, x="variable", y='value', vert2='species', vert="B", rel=TRUE, horiz="rvalue", print=FALSE)+
##     theme(axis.text.x=element_text(angle=90))
## ggsave("plots/robust_selex_errors.png", g, width=ggwidth, height=ggheight)
## g <- plot_scalar_boxplot(robust.long.management, x="variable",
##                          y='value', vert2='species', vert="B", rel=TRUE,
##                          horiz="rvalue", print=FALSE)+
##                              theme(axis.text.x=element_text(angle=90))
## ggsave("plots/robust_management_errors.png",g, width=ggwidth, height=ggheight)
## g <- ggplot(robust, aes(x=B, y=log_max_grad, color=runtime, size=params_on_bound_em,))+
##     geom_jitter()+
##         facet_grid(species~B+rvalue)+
##             geom_hline(yintercept=log(.01), col='red')
## ggsave("plots/robust_convergence.png",g, width=ggwidth, height=ggheight)
## g <- ggplot(robust, aes(x=B, y=runtime, size=params_on_bound_em, color=converged))+
##     geom_jitter()+ ylab("Runtime (minutes)")+
##         facet_grid(species~B+rvalue)
## ggsave("plots/robust_runtime.png",g, width=ggwidth, height=ggheight)
## ## table of convergence
## plyr::ddply(robust.long, .(species, B, B), summarize,
##             median.logmaxgrad=round(median(log_max_grad),2),
##             max.stuck.on.bounds=max(params_on_bound_em))


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



