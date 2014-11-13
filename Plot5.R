# Baltimore City, Emissions from motor vehicle sources changed from 1999-2008.

setwd("E:/apps/NEW PROYECTOS/Coursera/Exploratory Data/proyecto 2")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
 
library (dplyr)
library(data.table)
library (ggplot2)

DT <- data.table(NEI)
BaltimoreZip  <- "24510" 
LAZip         <- "06037" 
baltimoreCity <- filter(DT,fips == BaltimoreZip)
laCity        <- filter(DT,fips == LAZip)

total    <- DT[, sum(Emissions), by = year]
totalBC <- baltimoreCity[, sum(Emissions), by = year]

 
png("plot5.png", width=480, height=480 )
 
vehiclesSCC <- SCC[grep ("Vehicles$",SCC$EI.Sector ),]

vehiclesMerge <- merge(vehiclesSCC,baltimoreCity,by= "SCC")
totalvehicles<- aggregate(vehiclesMerge$Emissions, by=list(vehiclesMerge$type,vehiclesMerge$year), FUN=sum)
colnames(totalvehicles)=c("Type","Year","Emissions")
qplot(Year,Emissions, data=totalvehicles  ,main="Baltimore Emissions vehicles ",ylab="Emissions",xlab="Year",facets=.~Type )

 
dev.off()
