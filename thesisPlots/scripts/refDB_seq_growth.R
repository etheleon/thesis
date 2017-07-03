#!/usr/bin/env Rscript

library(lubridate)
library(tidyverse)
library(cowplot)

sequences_total <- data.frame(
    type = "accession",
    year = seq(ymd("2014-07-09"), by="year", length.out=4),
    nseq = c(43671159, 52494032, 65964245, 84756971)
)

numberOfSpecies <- data.frame(
    type = "All Species",
    year = seq(ymd("2014-07-09"), by="year", length.out=4),
    num = c(41263, 55267, 60892, 69035)
)


numberOfBact <- data.frame(
    type = "Bacteria",
    year = seq(ymd("2014-07-09"), by="year", length.out=4),
    num = c(28400, 39660, 42080, 45650)
)

numberOfArch <- data.frame(
    type = "Archae",
    year = seq(ymd("2014-07-09"), by="year", length.out=4),
    num = c(849, 952, 959, 1006)
)


p = list(numberOfSpecies, numberOfBact, numberOfArch) %>% do.call(rbind,.) %>%
    ggplot(aes(year, num)) +
    geom_line(aes(color=type)) +
    scale_color_brewer("Species", palette = 'Dark2') +
    xlab("Years") + ylab("Number of species in NR reference DB (proteins)")
    #facet_wrap(~type, ncol=1)

ggsave(plot=p, file="nrDBgrowth.pdf")
