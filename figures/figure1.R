
### ------------------------------------------------------------
## Make the literature review figure(s)
lit <- read.csv("lit-review.csv", stringsAsFactors = FALSE, strip.white = TRUE)
names(lit) <- tolower(names(lit))
names(lit) <- gsub("\\.", "_", names(lit))
names(lit) <- gsub("__", "_", names(lit))
names(lit) <- gsub("_$", "", names(lit))
region_lit <- lit %>% group_by(region, bin_width_cm) %>%
  summarise(num = length(bin_width_cm))
taxa_lit <- lit %>% group_by(species_type, bin_width_cm) %>%
  summarise(num = length(bin_width_cm))
region_lit_wide <- reshape2::dcast(region_lit, region ~ bin_width_cm,
  value.var = "num")
region_lit_wide[is.na(region_lit_wide)] <- 0
taxa_lit_wide <- reshape2::dcast(taxa_lit, species_type ~ bin_width_cm,
  value.var = "num")
taxa_lit_wide[is.na(taxa_lit_wide)] <- 0
region_order <- c("Australia", "Atlantic", "Caribbean", "Gulf of Mexico",
  "South Atlantic", "West Coast")
region_lit_wide <- region_lit_wide[order(region_order, region_lit_wide$region), ]
region_lit_wide$region[-1] <- paste("US", region_lit_wide$region[-1])
fable <- function(x, y, z, xlab = "", ylab = "",
  col_breaks = seq(0.5, 4, length.out = 13), log_colours = TRUE,
  text_cex = 1) {
  z <- z[nrow(z):1, ]
  y <- rev(y)
  col <- rev(grey(seq(0, 1, length.out = 18)))
  col <- col[2:13]
  if (log_colours)
    z_plot <- log(z + 1)
  else
    z_plot <- z
  image(1:length(x), 1:length(y), t(z_plot), axes = F, xlab = "", ylab = "",
    col = col, breaks = col_breaks)
  x_lines <- 1:(length(x) + 1) - 0.5
  if(!is.null(y))
    y_lines <- 1:(length(y) + 1) - 0.5
  axis(3, at = x_lines, labels = FALSE, col = "grey50")
  axis(3, tick = FALSE, at = 1:length(x), labels = x, col = "grey50", padj = 0.4)
  axis(2, at = y_lines, labels = FALSE, col = "grey50")
  axis(2, tick = FALSE, at = 1:length(y), labels = y, col = "grey50",
    padj = 0.5, hadj = 0.9, las = 1)
  abline(h = y_lines, col = "#00000050")
  abline(v = x_lines, col = "#00000050")
  for(x_i in 1:length(x)) {
    for(y_i in 1:length(y)) {
      col <- ifelse(z[y_i, x_i] == 0, "white", "grey10")
      text(x_i, y_i, z[y_i, x_i], cex = text_cex, col = col)
    }
  }
  box(col = "grey50")
  mtext(xlab, side = 3, line = 1.75, cex = 0.8)
  if(!is.null(y))
    mtext(ylab, side = 2, line = 2.00, cex = 0.8)
}
pdf("figures/fig1_lit_review.pdf", width = width, height = height)
par(mar = c(1, 8, 3, 1), oma = c(1, 1, 1, 1), cex = 0.75)
m <- c(rep(1, 3), rep(2, 5))
layout(m)
z <- region_lit_wide[,-1] %>% as.matrix
fable(y = region_lit_wide$region, x = names(region_lit_wide)[-1], z = z, text_cex = 0.9)
z <- taxa_lit_wide[,-1] %>% as.matrix
fable(y = taxa_lit_wide$species_type, x = names(taxa_lit_wide)[-1], z = z, text_cex = 0.9)
dev.off()
