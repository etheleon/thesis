library(sqldf)
library(ggplot2)
theme_set(theme_bw())
load('../Dropbox/ulu/data/ko.name.rda')
x <- read.delim('9105.ko.hit.freq.txt', h = F)
colnames(x) <- c('ko', 'hit', 'n')
a <- subset(x, ko != 'unclassified')
b <- subset(x, ko == 'unclassified')

cutt <- function(data, nbreak = 150) {
	data$bin <- cut(data$hit, nbreak)
	sqldf('select avg(hit) as hit, sum(n) as n from data group by bin')
}


xmax <- max(a$hit)
dat <- cutt(a)
pdf('hit.freq.classified.pdf')
qplot(hit, n, data = dat, main = 'classified', geom = 'bar', stat = 'identity', colour = I('white'), size = I(0.1)) + scale_y_sqrt()
dev.off()
dat <- cutt(b)
pdf('hit.freq.unclassified.all.pdf')
qplot(hit, n, data = dat, main = 'unclassified [all]', geom = 'bar', stat = 'identity', colour = I('white'), size = I(0.1)) + scale_y_sqrt() + geom_vline(x = xmax, colour = 'red')
dev.off()
dat <- cutt(subset(b, hit <= xmax))
pdf('hit.freq.unclassified.cut.pdf')
qplot(hit, n, data = dat, main = 'unclassified [classified range]', geom = 'bar', stat = 'identity', colour = I('white'), size = I(0.1)) + scale_y_sqrt()
dev.off()


for(k in unique(a$ko))
{
	data <- subset(a, ko == k)
	nsum <- sum(data$n)
	cat(paste(k, " : ", nsum), fill = T);
	if(nsum <= 8000) last
	
	name <- subset(ko.name, ko == k)
	
	top <- quantile(rep(data$hit, data$n), 0.999)
	data <- subset(data, hit <= top)
	dat <- cutt(data)
	p <- qplot(hit, n, data = dat, main = sprintf("%s %s (%d)\n%s", k, name$symbol, nsum, name$name), geom = 'bar', stat = 'identity', colour = I('white'), size = I(0.1)) + scale_y_sqrt()
	png(sprintf('fig/%s.png', k), w = 7, h = 7, res = 200, unit = 'in')
	print(p)
	dev.off()
}


