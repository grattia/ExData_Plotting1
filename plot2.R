#
#  plot2.R
# This program graph information from household power consuption data set. it download the dataset, read the file then subset
# relevant information from the dates 2007-02-01 and 2007-02-02.
# Finally save the plot within a PGN file.
#
# readr and lubridate packages are required
#
#preparing the storage dir on disk and required libraries
setwd("C:/Users/ratti/Projects/ExploratoryDataAnalysis")
require(readr)
require(lubridate)
if (!file.exists("proj")) {
   dir.create("proj")
}

#Downloading and uncompressing files

if (!file.exists("./proj/Dataset.zip")) {
   dataSetUrl <-
      "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
   download.file(dataSetUrl, destfile = "./proj/Dataset.zip")
}
dataFile <- "./proj/household_power_consumption.txt"
if (!file.exists(dataFile)) {
   unzip("./proj/Dataset.zip", exdir = "./proj")
}

# read complete file
X_test <- read_delim(dataFile, ";", na = c("?"), col_types = "ccddddddd")
# subset the requested dates
data <- subset.data.frame(X_test, dmy(Date)>=dmy("01/02/2007")&dmy(Date)<=dmy("02/02/2007"))
# combine Date and time
data$datetime <- with(data, strptime(paste(Date,Time),'%d/%m/%Y %H:%M:%S'))

plot.new()
par(mfrow = c(1,1), mar = c(4, 4, 2, 1), oma = c(0, 0, 2, 0))

png(filename = "./proj/plot2.png")
with(data, plot(datetime,Global_active_power, type="l" ,ylab = "Global Active Power (kilowatts)", xlab = ""))
dev.off()
