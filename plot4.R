## Load the data
nei <- readRDS('summarySCC_PM25.rds')
scc <- readRDS('Source_Classification_Code.rds')

## Load necessary libraries
library('reshape2')
library('ggplot2')

## Transform the data so that the year is a factor
neiYr <- transform(nei, year = factor(year))

## Find the SCC for Coal Combustion
combcoal <- scc[grep('(?=.*comb)(?=.*coal)', scc$EI.Sector, perl = T, ignore.case=T),]

## Subset the data. Keep data where SCC is in combcoal
cc <- subset(neiYr, neiYr$SCC %in% combcoal$SCC)

## Melt the data keeping the year and using the Emissions as the variable
ccmelt <- melt(cc, id = 'year', measure.vars = 'Emissions')

## Cast the melted data summing Emissions for each year
cccast <- dcast(ccmelt, year ~ variable, sum)

## Open png device and create plot, then close png device
png(filename = 'plot4.png')

qplot(year, Emissions, data = cccast, main = 'Coal Combustion Emissions')

dev.off()