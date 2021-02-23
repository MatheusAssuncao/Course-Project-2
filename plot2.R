# Plot 2

# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") 
#from 1999 to 2008? Use the base plotting system to make a plot answering this question.

# Loading Packages
library(tidyverse)

# Downloading data and reading data

# Downloading the file
if (!file.exists("FNEI_data.zip")) {
  download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                destfile = "FNEI_data.zip" )
}

# Unzipping the file
if (!file.exists("summarySCC_PM25.rds") & !file.exists("Source_Classification_Code.rds")) {
  unzip("FNEI_data.zip")
}  

# Reading the files
if (!exists("NEI")) {
  NEI <- readRDS("summarySCC_PM25.rds")
  
}

if (!exists("SCC")) {
  SCC <- readRDS("Source_Classification_Code.rds")
  
}

baltimore <- NEI[NEI$fips=="24510",]

baltimore_emissions <- aggregate(Emissions ~ year, baltimore, FUN = sum)

png("plot2.png")

barplot(baltimore_emissions$Emissions/1000, baltimore_emissions$year, names.arg = baltimore_emissions$year,
        col = baltimore_emissions$year,
        main = "Total Emissions PM2.5 fom 1998 to 2008 in Baltimore, MA",
        xlab = "Years",
        ylab = "PM2.5 Emissions in kilotons")

dev.off()