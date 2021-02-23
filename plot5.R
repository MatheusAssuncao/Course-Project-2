# Plot 5

# How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

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

vehicles_NEI <- NEI %>% filter(SCC %in% vehicles$SCC & fips == "24510") %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("plot5.png")

h <- ggplot(vehicles_NEI, aes(as.factor(year), Emissions/1000, fill = Emissions)) 

h + geom_col() +
  scale_fill_distiller(palette = "Greens", direction = 1) + 
  xlab("Years") +
  ylab("Emissions in kilotons") +
  ggtitle("Emissions from vehicles from 1999-2008 in Baltimore, MA")

dev.off()