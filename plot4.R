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
coal <- grepl("Fuel Comb.*Coal", scc$EI.Sector)
coalsources<-scc[coal,]
coalc<-nei[(nei$SCC %in% coalsources$SCC), ]
coalemissions<-summarise(group_by(coalc, year), Emissions=sum(Emissions))
with(coalemissions,qplot(year,Emissions/1000,fill=year)+geom_bar(stat="identity")+ggtitle("Emissions from coal combustion-related sources in kilotons")+ylab("total PM2.5 emissions in kilotons"))
dev.copy(png,file="plot4.png")
dev.off()