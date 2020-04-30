library(dplyr)
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
emissiondata<-summarise(group_by(nei,year),emissions=sum(Emissions))
barplot(emissiondata$emissions/1000,names.arg = emissiondata$year,col=c("red","blue","green","yellow"))
title(main="total Emissions of PM2.5 vs years",xlab = "Year",ylab = "PM2.5 emissions in Kiloton")
dev.copy(png,file="plot1.png")
dev.off()
