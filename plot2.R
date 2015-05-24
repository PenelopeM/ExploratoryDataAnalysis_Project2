## Load the data
nei <- readRDS('summarySCC_PM25.rds')
scc <- readRDS('Source_Classification_Code.rds')

## Load necessary libraries
library('reshape2')

## Transform the data so that the year is a factor
neiYr <- transform(nei, year = factor(year))

## Subset the data. Keep data where fips == '24510' for Baltimore
balt <- subset(neiYr, fips == '24510')

## Melt the data keeping the year and using the Emissions as the variable
baltmelt <- melt(balt, id = 'year', measure.vars = 'Emissions')

## Cast the melted data summing Emissions for each year
baltcast <- dcast(baltmelt, year ~ variable, sum)

## Open png device and create plot, then close png device
png(filename = 'plot2.png')

plot(baltcast)
title(main = 'Total PM2.5 Emissions for Baltimore')

dev.off()