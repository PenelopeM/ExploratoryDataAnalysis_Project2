## Load the data
nei <- readRDS('summarySCC_PM25.rds')
scc <- readRDS('Source_Classification_Code.rds')

## Load necessary libraries
library('reshape2')
library('ggplot2')

## Transform the data so that the year is a factor
neiYr <- transform(nei, year = factor(year))

## Subset the data. Keep data where fips == '24510' for Baltimore
balt <- subset(neiYr, fips == '24510')

## Melt the data keeping the year and type and using the Emissions as the variable
baltmelt2 <- melt(balt, id = c('year', 'type'), measure.vars = 'Emissions')

## Cast the melted data summing Emissions for each year and type
baltcast2 <- dcast(baltmelt2, year + type ~ variable, sum)

## Transform the data so that type is a factor
baltcast2 <- transform(baltcast2, type = factor(type))

## Open png device and create plot, then close png device
png(filename = 'plot3.png')

qplot(year, Emissions, data = baltcast2, facets = .~type, main = 'Emissions in Baltimore City by type')

dev.off()