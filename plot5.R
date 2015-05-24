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

## Find the SCC for Vehicles
veh <- scc[grep('vehicle', scc$EI.Sector, perl = T, ignore.case = T),]

## Subset the data. Keep data where SCC is in veh
baltveh <- subset(balt, balt$SCC %in% veh$SCC)

## Melt the data keeping the year and using the Emissions as the variable
baltmelt3 <- melt(baltveh, id = 'year', measure.vars = 'Emissions')

## Cast the melted data summing Emissions for each year
baltcast3 <- dcast(baltmelt3, year ~ variable, sum)

## Open png device and create plot, then close png device
png(filename = 'plot5.png')

qplot(year, Emissions, data = baltcast3, main = 'Vehicle Emissions in Baltimore City')

dev.off()