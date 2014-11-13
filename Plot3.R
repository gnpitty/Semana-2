# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable,
# which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City

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

 
 
png("plot3.png", width=480, height=480 )
 

res1<- aggregate(baltimoreCity$Emissions, by=list(baltimoreCity$type,baltimoreCity$year), FUN=sum)
colnames(res1)=c("Type","Year","Emissions")
#qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",color=Type )
qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",color=Type ,geom=c("point","smooth"))
#qplot(Year,Emissions, data=res1  ,main="Baltimore Emissions",ylab="Emissions",xlab="Year",facets=.~Type )

 
dev.off()
