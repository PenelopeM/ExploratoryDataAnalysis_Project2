## Load the data
nei <- readRDS('summarySCC_PM25.rds')
scc <- readRDS('Source_Classification_Code.rds')

## Load necessary libraries
library('reshape2')
library('ggplot2')

## Transform the data so that the year is a factor
neiYr <- transform(nei, year = factor(year))

## Find the SCC for Vehicles
veh <- scc[grep('vehicle', scc$EI.Sector, perl = T, ignore.case = T),]

## Subset the data, keeping only SCC in veh
neiveh <- subset(neiYr, neiYr$SCC %in% veh$SCC)

## Subset the data, keeping only 'Baltimore' (fips 24510) and 'Los Angeles' (fips 06037)
cityveh <- subset(neiveh, neiveh$fips %in% c('24510', '06037'))

## Melt the data keeping the year and fips and using the Emissions as the variable
vehmelt <- melt(cityveh, id = c('year', 'fips'), measure.vars = 'Emissions')

## Cast the melted data summing Emissions for each year
vehcast <- dcast(vehmelt, year + fips ~ variable, sum)

## Make the data more readable by replacing the fips numbers by the city names
vehcast$fips <- sub('06037', 'Los Angeles', vehcast$fips)
vehcast$fips <- sub('24510', 'Baltimore', vehcast$fips)

## Open png device and create plot, then close png device
png(filename = 'plot6.png')
qplot(year, Emissions, data = vehcast, color = fips, main = 'Vehicle Emissions for Baltimore and Los Angeles')
dev.off()