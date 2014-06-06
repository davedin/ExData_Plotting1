# setwd('C:/www/r/exdata-project1')

# download, unzip, and read file
if( !file.exists("household_power_consumption.txt") ) { # go get the file
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
    unzip( "household_power_consumption.zip")
    data <- read.table( "household_power_consumption.txt"
                        , nrows = 100000
                        , sep = ";"
                        , header = TRUE
    )
    
} else { # use your local file
    
    data <- read.table( "household_power_consumption.txt"
                        , nrows = 100000
                        , sep = ";"
                        , header = TRUE
    )
    
}


# create a datetime field
data$DateTime <- strptime(paste(data$Date, data$Time),format="%d/%m/%Y %H:%M:%S")


# get the relevant data only
relevant <- data[grep("2007-02-0[1|2]",data$DateTime),]
head(relevant)
tail(relevant)


# open a PNG device
png(file = "plot1.png", bg = "transparent", width = 480, height = 480)


# create the histogram
    hist( as.numeric( as.character(relevant$Global_active_power ) )
         # , breaks = 12
          , col = "red" 
          , main = "Global Active Power"
          , xlab = "Global Active Power (kilowatts)"
          , ylab = "Frequency"
          #, xlim=c(0,6)
          #, ylim=c(0,1200)
          #, axes = FALSE
          )
    
#    axis(1, seq( by= 2,from = 0, to = 6 ) )
#    axis(2, seq( by= 100,from = 0, to = 1200 ) )

# close the PNG device
dev.off()
