#Have total emissions from PM2.5 decreased in the United States from 1999 to 2008

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

png("plot1.png", width=480, height=480 )
plot(total$year  ,total$V1,main="USA Emissions",type="l",ylab="Emissions",xlab="Year" )
dev.off()