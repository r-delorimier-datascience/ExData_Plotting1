
#' This function retrieves data originally from the UC Irvine Machine Learning 
#' Repository website, http://archive.ics.uci.edu/ml/, and now saved at 
#' https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip .
#' Only the data from the dates 2007-02-01 and 2007-02-02 will be used. 
#' 
#' This function creates a png plot of type histogram, bars colored red. The plot 
#' will be titled, "Global Active Power". The Y axis will be of frequency (in ) 
#' and titled, "Frequency". The X axis will be measured in kilowatts, and titled, 
#' "Global Active Power (kilowatts)". By default the graphic is output at the 
#' top level.
#' 
#' @param data_dir A directory where the downloaded data will expanded, defaults
#' to "data"
#' @param dataZipUrl A url where the data zip file is located, defaults to 
#' "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#' @param output_file The name of the file to output the graph to.
#' @examples
#' > make_plot1(data_dir = "data", data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", output_file = "plot1.png")
#'
#' @export
make_plot1 <- function(
  data_dir = "data", 
  data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  output_file = "plot1.png"
) {
  
#  ## LIBRARIES
#  library(RCurl)
#  library(sqldf)

  ## STEP 1A, CREATE LOCATION AND DOWNLOAD THE FILE
  
#  if(!file.exists("./data")) {
#    dir.create("./data")
#  }
#  download.file( "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="./data/dataset.zip", method="curl")
  
  ## STEP 1B, UNZIP THE FILE
  
#  unzip(zipfile="./data/dataset.zip", exdir="./data")
  
  ## STEP 2, CREATE DATAFRAME FILTERED BY DATES 2007-02-01 and 2007-02-02 AND FORMAT
  
#  plot1_df <- read.csv.sql("data/household_power_consumption.txt", "select * from file where (Date = '1/2/2007' or Date = '2/2/2007') and Global_active_power <> '?' ", sep=";")
#  plot1_df$Date <- as.Date(plot1_df$Date , format = "%d/%m/%y")
#  plot1_df$Time <- strptime(plot1_df$Time , format = "%H:%M:%S")
  
  source("downloader.R")
  
  plot1_df <- read_expand_format_dataframe(data_dir = data_dir, data_zip_url = data_zip_url)
  
  ## STEP 2, CREATE DEVICE, MAKE THE PLOT AND CLOSE
  
  png(file = output_file, width = 480, height = 480)
  hist(plot1_df$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
  dev.off()
  closeAllConnections()
}

make_plot1()