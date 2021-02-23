# Plot 3

# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
# which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
# Which have seen increases in emissions from 1999–2008? 
# Use the ggplot2 plotting system to make a plot answer this question


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

if (!exists("baltimore")) {
  baltimore <- NEI[NEI$fips=="24510",]

}


g <- ggplot(baltimore, aes(as.factor(year),Emissions,fill = type))

png("plot3.png")

g + geom_col() + 
  facet_grid(. ~ type) +
  xlab("Years") +
  ggtitle("Emissions by type from 1999 to 2008 in Baltimore, MA") +
  theme(legend.position = "bottom")
  
dev.off()