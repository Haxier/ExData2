plot6 <- function(){
        library(ggplot2)
        #load data
        NEI <- readRDS("./exdata_data_NEI_data/summarySCC_PM25.rds")
        SCC <- readRDS("./exdata_data_NEI_data/Source_Classification_Code.rds")
        
        # Subset Baltimore & LA data
        compare <- subset(NEI, fips == "24510" | fips == "06037")
        # Subset vehicle combustion-related SCC classificators
        vehicles <- SCC[grepl("vehicles", SCC$EI.Sector, ignore.case = T), ]
        # Merge Baltimore-LA NEI data where SCC in it matches SCC
        data <- merge(compare, vehicles, by.x = "SCC", by.y = "SCC", all = FALSE)
        # Aggregate total emissions for each year by type
        emissions <- aggregate(Emissions ~ year+fips, data, sum)
        
        #open png graphics device
        png(filename = "plot6.png", width = 480, height = 480)
        #plot
        qplot(year, Emissions, data = emissions, group = fips, color= fips, geom = "line", xlab = "Year", 
              ylab = "Emissions", main = "Vehicle Emissions in Baltimore and LA")
        # close ghaphics device
        dev.off()
}