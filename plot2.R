#' Only the data from the dates 2007-02-01 and 2007-02-02 will be used. 
#' 
#' This function creates a png plot of type line. The Y axis will be 
#' "Global Active Power (kilowatts)". The X axis will be blank. By default the 
#' graphic is output at the top level.
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
make_plot2 <- function(
  data_dir = "data", 
  data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  output_file = "plot2.png"
) {
  source("downloader.R")
  
  plot1_df <- read_expand_format_dataframe(data_dir = data_dir, data_zip_url = data_zip_url)
  
  ## STEP 2, CREATE DEVICE, MAKE THE PLOT AND CLOSE
  
  png(file = output_file, width = 480, height = 480)
  plot(plot1_df$Global_active_power, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
  dev.off()
  closeAllConnections()
}

make_plot2()
