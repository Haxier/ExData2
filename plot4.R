plot4 <- function(){
    #load data
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
    
    # use the grep function to subset the SCC values of the coal emissions
    data <- SCC[grep("Coal", SCC$EI.Sector),]
    # merge the NEI data and the SCC values for the "Coal" rows 
    data <- merge(NEI, data, by.x = "SCC", by.y = "SCC", all = FALSE)
    data <- transform(data, year = as.factor(year))
    #get total pm25 emissions per year 
    emissions <- with(data, tapply(Emissions, year, sum))
    
    #open png graphics device
    png(filename = "plot4.png", width = 480, height = 480)
    #plot
    plot(names(emissions), emissions, type= "l", ylab = "PM25 Values", xlab = "Years", main = "Total COAL Emissions")
    # close ghaphics device
    dev.off()
}