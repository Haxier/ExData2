plot5 <- function(){
    library(ggplot2)
    #load data
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
    
    # use the grep function to subset the SCC values of the car emissions
    data <- SCC[grep("Vehicles", SCC$EI.Sector),]
    #subset the data to get only Baltimore subset
    baltimore <- subset(NEI, fips == "24510")
    # merge the NEI data and the SCC values for the "Vehicles" rows 
    data <- merge(baltimore, data, by.x = "SCC", by.y = "SCC", all = FALSE)
    data <- transform(data, year = as.factor(year))
    #get total pm25 emissions per year 
    emissions <- aggregate(Emissions~year, data=data, FUN= sum)
    #open png graphics device
    png(filename = "plot5.png", width = 480, height = 480)
    #plot
    qplot(year, Emissions, data = emissions, geom = "point", xlab = "Year", 
          ylab = "Emissions", main = "Vehicle Emissions in Baltimore")
    # close ghaphics device
    dev.off()
}