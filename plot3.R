plot3 <- function(){
    library(ggplot2)
    #load data
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
    
    # Subset Baltimore data
    baltimore <- subset(NEI, fips == "24510")
    baltimore <- transform(baltimore, year = as.factor(year))
    baltimore <- transform(baltimore, type = as.factor(type))
    # Aggregate total emissions for each year by type
    emissions <- aggregate(Emissions ~ year + type, baltimore, sum)
    
    #open png graphics device
    png(filename = "plot3.png", width = 480, height = 480)
    #plot
    qplot(year, Emissions, data = emissions, group =type, geom= "line", col= type, main = "Total PM25 Emissions by Type and by Year")
    # close ghaphics device
    dev.off()
}