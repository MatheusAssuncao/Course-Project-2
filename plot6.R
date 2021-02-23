# PLot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
# in Los Angeles County, California (fips == "06037"). Which city has seen greater changes over time 
# in motor vehicle emissions?

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

vehicles <- SCC[grep("[Vv]ehicles",SCC$EI.Sector),]

vehicles_compare <- NEI %>% filter(SCC %in% vehicles$SCC & fips %in% c("06037", "24510")) %>% 
  group_by(fips,year) %>% 
  summarise(Emissions = sum(Emissions))

vehicles_compare$fips <- as.factor(vehicles_compare$fips)
levels(vehicles_compare$fips)
levels(vehicles_compare$fips) <- c("Los Angeles", "Baltimore")

png("plot6.png")

b <- ggplot(vehicles_compare, aes(as.factor(year), Emissions/1000, fill = Emissions)) 

b + geom_col() +
  facet_grid(. ~ fips) +
  xlab("Years") +
  ylab("Emissions in kilotons") +
  ggtitle("Emissions from vehicles from 1999-2008")

dev.off()