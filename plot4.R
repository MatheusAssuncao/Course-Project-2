# Plot 4

# Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

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

coal <- SCC[grep("[Cc][Oo][Aa][Ll]",SCC$EI.Sector),]

coal_NEI <- NEI %>% filter(SCC %in% coal$SCC) %>% 
  group_by(year) %>% 
  summarise(Emissions = sum(Emissions))

png("plot4.png")

f <- ggplot(coal_NEI, aes(as.factor(year), Emissions/1000, fill = Emissions)) 

f + geom_col() +
  xlab("Years") +
  ylab("Emissions in kilotons") +
  ggtitle("Emissions from coal combustion-related sources from 1999-2008")

dev.off()