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

baltimore<-subset(nei,nei$fips=="24510"&nei$type=="ON-ROAD")
baltimoreemission<-summarise(group_by(baltimore,year),emissions=sum(Emissions))
losangeles<-subset(nei,nei$fips=="06037"&nei$type=="ON-ROAD")
losangelesemission<-summarise(group_by(losangeles,year),emissions=sum(Emissions))
baltimoreemission$county<-"Baltimore"
losangelesemission$county<-"LA"
bothemissions<-rbind(baltimoreemission,losangelesemission)
ggplot(bothemissions,aes(x=year,y=emissions,fill=county))+geom_bar(stat="identity")+facet_grid(county~.,scales="free")
dev.copy(png,file="plot6.png")
dev.off()