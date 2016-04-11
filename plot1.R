plot1 <- function(){
    #load data
    NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
    SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
    
    NEI <- transform(NEI, year = as.factor(year))
    #get total pm25 emissions per year 
    emissions <- with(NEI, tapply(Emissions, year, sum))
    #open png graphics device
    png(filename = "plot1.png", width = 480, height = 480)
    #plot
    plot(names(emissions), emissions, type= "l", ylab = "PM25 Values", xlab = "Years", main = "Total PM25 Emissions by Year")
    # close ghaphics device
    dev.off()
}