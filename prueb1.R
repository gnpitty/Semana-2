setwd("E:/apps/NEW PROYECTOS/Coursera/Exploratory Data/proyecto 2")
## This first line will likely take a few seconds. Be patient!
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
 
library (dplyr)
library(data.table)
library (ggplot2)

DT <- data.table(NEI)
baltimoreCity <- filter(DT,fips == "24510")
laCity        <- filter(DT,fips == "06037")

total    <- DT[, sum(Emissions), by = year]
totalBC <- baltimoreCity[, sum(Emissions), by = year]

par(mfrow = c(2,2))
plot(total$year  ,total$V1,main="USA Emissions",type="l",ylab="Emissions",xlab="Year" )
plot(totalBC$year  ,totalBC$V1,main="Baltimore Emissions",type="l",ylab="Emissions",xlab="Year" )

res1<- aggregate(baltimoreCity$Emissions, by=list(baltimoreCity$type,baltimoreCity$year), FUN=sum)
colnames(res1)=c("Type","Year","Emissions")
qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",color=Type )
qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",color=Type ,geom=c("point","smooth"))
qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",facets=.~Type )

CoalSCC    <- SCC[grep ("Coal$",SCC$EI.Sector ),]
CoalMerge  <- merge(CoalSCC,DT,by= "SCC")

totalCoal<- aggregate(CoalMerge$Emissions, by=list(CoalMerge$type,CoalMerge$year), FUN=sum)

colnames(totalCoal)=c("Type","Year","Emissions")
qplot(Year,Emissions, data=totalCoal  ,main="US Emissions coal combustion-related ",ylab="Emissions",xlab="Year",facets=.~Type )


vehiclesSCC <- SCC[grep ("Vehicles$",SCC$EI.Sector ),]

vehiclesMerge <- merge(vehiclesSCC,baltimoreCity,by= "SCC")
totalvehicles<- aggregate(vehiclesMerge$Emissions, by=list(vehiclesMerge$type,vehiclesMerge$year), FUN=sum)
colnames(totalvehicles)=c("Type","Year","Emissions")
qplot(Year,Emissions, data=totalvehicles  ,main="Baltimore Emissions vehicles ",ylab="Emissions",xlab="Year",facets=.~Type )

vehiclesMergeLA  <- merge(vehiclesSCC,laCity,by= "SCC")
totalvehiclesLA<- aggregate(vehiclesMergeLA$Emissions, by=list(vehiclesMergeLA$type,vehiclesMergeLA$year), FUN=sum)
colnames(totalvehiclesLA)=c("Type","Year","Emissions")

qplot(Year,Emissions, data=totalvehiclesLA  ,main="Los Angeles Emissions vehicles ",ylab="Emissions",xlab="Year",facets=.~Type )


