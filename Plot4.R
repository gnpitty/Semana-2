# Across the United States, how have emissions from 
#coal combustion-related sources changed from 1999-2008

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

 
png("plot4.png", width=480, height=480 )
CoalSCC    <- SCC[grep ("Coal$",SCC$EI.Sector ),]
CoalMerge  <- merge(CoalSCC,DT,by= "SCC")
totalCoal<- aggregate(CoalMerge$Emissions, by=list(CoalMerge$type,CoalMerge$year), FUN=sum)
colnames(totalCoal)=c("Type","Year","Emissions")
qplot(Year,Emissions, data=totalCoal  ,main="US Emissions coal combustion-related ",ylab="Emissions",xlab="Year",facets=.~Type )
dev.off()
