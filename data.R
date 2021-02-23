# Exploratory Data Analysis

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
