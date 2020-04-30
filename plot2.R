library(dplyr)
library(ggplot2)
filename <- "exdata_data_NEI_data.zip"
#Checks if a file called Courseproject.zip exists in the current working directory
if (!file.exists(filename)){
  url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
  download.file(url, filename, method="curl")
}  
#extracts contents of the zip file
if (!file.exists("Source_Classification_Code.rds")) { 
  unzip(filename) 
}
if (!file.exists("summarySCC_PM25.rds")) { 
  unzip(filename) 
}
nei <- readRDS("summarySCC_PM25.rds")
scc <- readRDS("Source_Classification_Code.rds")
baltimore<-subset(nei,nei$fips=="24510")
baltimoreemission<-summarise(group_by(baltimore,year),emissions=sum(Emissions))
barplot(baltimoreemission$emissions/1000,names.arg = baltimoreemission$year,col=c("red","blue","green","yellow"))
title(main="total Emissions of PM2.5 in Baltimore vs years",xlab = "Year",ylab = "PM2.5 emissions in Kiloton in Baltimore")
dev.copy(png,file="plot2.png")
dev.off()