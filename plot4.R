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
#' > make_plot4(data_dir = "data", data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", output_file = "plot4.png")
#'
#' @export
make_plot4 <- function(
  data_dir = "data", 
  data_zip_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
  output_file = "plot4.png"
) {
  source("downloader.R")
  
  plot4_df <- read_expand_format_dataframe(data_dir = data_dir, data_zip_url = data_zip_url)
  
  ## STEP 2, CREATE DEVICE, MAKE THE PLOT AND CLOSE
  
  png(file = output_file, width = 480, height = 480)
  
  par(mfrow=c(2,2))

  plot(plot4_df$Global_active_power~plot4_df$Datetime3, type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
  
  plot(plot4_df$Voltage~plot4_df$Datetime3, type="l", ylab = "Voltage", xlab = "datetime")
  
  plot(plot4_df$Sub_metering_1~plot4_df$Datetime3, type="l", ylab = "Energy sub metering", xlab = "")
  lines(plot4_df$Sub_metering_2~plot4_df$Datetime3, col = "red")
  lines(plot4_df$Sub_metering_3~plot4_df$Datetime3, col = "blue")
  legend("topright", legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), lty = 1, cex=0.9)
  
  plot(plot4_df$Global_reactive_power~plot4_df$Datetime3, type="l", ylab = "Global_reactive_power", xlab = "datetime")
  
  dev.off()
  closeAllConnections()
}

make_plot4()