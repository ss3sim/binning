## Source this file to make the figures
library(ggplot2)

## global options
width <- 7                             # inches
height <- 5


### ------------------------------------------------------------
## Make the literature review figure
df <- read.csv("results/Binning_lit_review_10_2014.csv")
str(df)
g <- ggplot(data=df, aes(x=Linf_cm,
            col=Internal_External))+facet_wrap("Region") + xlab("Linf") +
    scale_color_discrete(name="Growth Estimation",
                         labels=c("Not yet specified", "Empirical",
                         "External", "Internal"))
g2 <- g+geom_point(aes(y=num_length_bin))+ylab("Number of bins")
ggsave("plots/lit_review_num_bins.png", g2, width=7, height=4.5)
g2 <- g+geom_point(aes(y=bin_width_cm))+ylab("Width of bins (cm)") + ylim(0,10.5)
ggsave("plots/lit_review_width_bins.png", g2, width=7, height=4.5)

### ------------------------------------------------------------

