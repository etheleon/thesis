#!/usr/bin/env Rscript
library(IRanges)
library(multicore)
library(plyr)

info <- read.delim('out/8215.genome.info.txt', colClass = c('character', 'integer', 'factor', 'character', 'character'))
gname <- info$info
names(gname) <- info$id
gsize <- info$len
names(gsize) <- info$id
gchrom <- info$chrom
names(gchrom) <- info$id

files <- list.files('out/8210.map.pair/', full = T)

raw <- mclapply(files, function(f) {
	data <- read.delim(f, h = F)
	colnames(data) <- c('q', 't', 'identity', 'aln', 'mis', 'gap', 'qs', 'qe', 'ts', 'te', 'e', 'score')
	data$sample <- sub('.+/', '', f)
	data
})

#save.image('a.rda')

genome.cov <- function(data) {
	sample <- data$sample[1]
	detail <- lapply(unique(data$t), function(id) {
		temp <- subset(data, t == id)
		nreads <- nrow(temp)

		if(nreads <= 50) return(NULL)

		start <- pmin(temp$ts, temp$te)
		end <- pmax(temp$ts, temp$te)
		map <- IRanges(start, end)
		map.reduce <- reduce(map)
		covered <- sum(width(map.reduce))
		cov <- coverage(map)
		bad <- runValue(cov) == 0
		longest.gap <- max(0, runLength(cov)[bad])
		longest.cov <- max(width(map.reduce))
		maxcov <- max(runValue(cov))
		meancov <- weighted.mean(runValue(cov)[!bad], runLength(cov)[!bad])
		length <- gsize[as.character(id)]
		name <- gname[as.character(id)]
		chrom <- gchrom[as.character(id)]
		data.frame(sample, id, length, nreads, covered, maxcov, meancov, longest.gap, longest.cov, name, chrom)
	})
	do.call(rbind, detail)
}

#save.image('b.rda')

individual <- do.call(rbind, mclapply(raw, genome.cov))

#save.image('c.rda')

raw <- do.call(rbind, raw)

#save.image('d.rda')

print(head(raw))
raw$sample <- factor(raw$sample)
str(raw)
samples <- sort(levels(raw$sample))
print(samples)
good <- which(samples == '0058_s_1')
print(good)
b1 <- samples[1:good]
print(b1)
b2 <- samples[-1 * (1:good)]
print(b2)
batch1 <- subset(raw, sample %in% b1)
batch1$sample <- 'batch1'

#save.image('e.rda')

batch1 <- genome.cov(batch1)

#save.image('f.rda')

batch2 <- subset(raw, sample %in% b2)
batch2$sample <- 'batch2'
batch2 <- genome.cov(batch2)

#save.image('g.rda')

all <- raw
all$sample <- 'all'
all <- genome.cov(all)

save(all, batch1, batch2, individual, raw, file = 'out/8220.genome.rda')

