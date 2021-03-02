#' This function retrieves data originally from the UC Irvine Machine Learning 
#' Repository website, http://archive.ics.uci.edu/ml/, and now saved at 
#' https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip .
#' Only the data from the dates 2007-02-01 and 2007-02-02 will be used. It then
#' formats the Date and Time columns as dates and timestamps
#' 
#' 
#' @param data_dir A directory where the downloaded data will expanded, defaults
#' to "data"
#' @param dataZipUrl A url where the data zip file is located, defaults to 
#' "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
#' @param output_file The name of the file to output the graph to.
#' @returns a dataframe with formatted date and time
#' @examples
#' > make_plot1(data_dir = "data", data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", output_file = "plot1.png")
#'
#' @export
read_expand_format_dataframe <- function(
  data_dir = "data", 
  data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
) {
  packages <- c("RCurl", "sqldf")
  for (package in packages)
  {
    if (!package %in% installed.packages()) {
      install.packages(package)
    }
  }
#  install.packages(setdiff(packages, rownames(installed.packages())))
  ## LIBRARIES
  library(RCurl)
  library(sqldf)
  
  ## STEP 1A, CREATE LOCATION AND DOWNLOAD THE FILE
  
  if(!file.exists(data_dir)) {
    dir.create(data_dir)
  }
  zip_file = paste(data_dir, "dataset.zip", sep = "/")
  download.file(data_zip_url, destfile=zip_file, method="curl")
  
  ## STEP 1B, UNZIP THE FILE
  
  unzip(zipfile=zip_file, exdir=data_dir)
  
  ## STEP 2, CREATE DATAFRAME FILTERED BY DATES 2007-02-01 and 2007-02-02 AND FORMAT
  
  plot1_df <- read.csv.sql("data/household_power_consumption.txt", "select * from file where (Date = '1/2/2007' or Date = '2/2/2007') and Global_active_power <> '?' ", sep=";")

  plot1_df$Datetime <- as.Date(paste(plot1_df$Date, plot1_df$Time, sep = " ") , format = "%e/%m/%Y %H:%M:%S")
  plot1_df$Datetime2 <- strptime(paste(plot1_df$Date, plot1_df$Time, sep = " ") , format = "%e/%m/%Y %H:%M:%S", tz = "America/Denver")
  plot1_df$Datetime3 <- as.POSIXct(paste(plot1_df$Date, plot1_df$Time, sep = " ") , format = "%e/%m/%Y %H:%M:%S", tz = "America/Denver")
  plot1_df$DatetimeStr <- paste(plot1_df$Date, plot1_df$Time, sep = " ") 
  plot1_df$Date <- as.Date(plot1_df$Date , format = "%d/%m/%y")
  plot1_df$Time <- strptime(plot1_df$Time , format = "%H:%M:%S")
  
  return(plot1_df)
}