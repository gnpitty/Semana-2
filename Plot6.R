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

LABaltimoreCtities <- filter(DT,fips == LAZip |fips == BaltimoreZip )
total    <- DT[, sum(Emissions), by = year]
totalBC <- baltimoreCity[, sum(Emissions), by = year]

 
png("plot6.png", width=480, height=480 )
 

vehiclesSCC <- SCC[grep ("Vehicles$",SCC$EI.Sector ),]

 

vehiclesMergeLABal  <- merge(vehiclesSCC,LABaltimoreCtities,by= "SCC")
totalvehiclesLABal<- aggregate(vehiclesMergeLABal$Emissions, by=list(vehiclesMergeLABal$type,vehiclesMergeLABal$year,vehiclesMergeLABal$fips), FUN=sum)
colnames(totalvehiclesLABal)= c("Type","Year","Zip","Emissions")
qplot(Year,Emissions, data=totalvehiclesLABal  ,main="Los Angeles Emissions vehicles ",ylab="Emissions",xlab="Year",facets=.~Zip)
dev.off()
