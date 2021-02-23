# Plot 1

# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
# Using the base plotting system, make a plot showing the total PM2.5 emission 
# from all sources for each of the years 1999, 2002, 2005, and 2008

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

total_emissions <- aggregate(Emissions ~ year, NEI, FUN = sum)

png("plot1.png")

barplot(total_emissions$Emissions/1000, total_emissions$year, names.arg = total_emissions$year,
      col =  total_emissions$year,
      main = "Total Emissions PM2.5 fom 1998 to 2008",
      xlab = "Years",
      ylab = "PM2.5 Emissions in kilotons")

dev.off()