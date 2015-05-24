    ## Load the data
    nei <- readRDS('summarySCC_PM25.rds')
    scc <- readRDS('Source_Classification_Code.rds')
    
    ## Load necessary libraries
    library('reshape2')
    
    ## Transform the data so that the year is a factor
    neiYr <- transform(nei, year = factor(year))
    
    ## Melt the data keeping the year and using the Emissions as the variable
    neimelt <- melt(neiYr, id = 'year', measure.vars = 'Emissions')
    
    ## Cast the melted data summing Emissions for each year
    neicast <- dcast(neimelt, year ~ variable, sum)
    
    ## Open png device and create plot, then close png device
    png(filename = 'plot1.png')
    
    plot(neicast)
    title(main = 'Total Emissions of PM2.5 in the United States')
    
    dev.off()