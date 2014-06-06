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

#tail(relevant)
#head(relevant[,c("Date","Time", "Global_active_power","DateTime","DayOfWeek")])
#tail(relevant[,c("Date","Time", "Global_active_power","DateTime","DayOfWeek")])



library(lubridate)
head( weekdays( relevant$DateTime, abbreviate = TRUE ) )

relevant$DayOfWeek <- weekdays( relevant$DateTime, abbreviate = TRUE )


#head(relevant)
#tail(relevant)
#tail( as.numeric( relevant$Sub_metering_3) )

# open a PNG device
png(file = "plot3.png", bg = "transparent", width = 480, height = 480)

# create the plot
plot( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_1) ), 
      type = "n",
      , ylab = "Energy sub metering"
      , ylim = c(0,30)
      , xlab = ""
)
legend( "topright"
       , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
       , col = c("black", "red", "blue"),  pch = c("_____",3,4)
)
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_1 ) ), col = "black")
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_2 ) ), col = "red" )
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_3 ) ), col = "blue" )


axis(2, seq( by= 10,from = 0, to = 30 ) )


# close the PNG device
dev.off()
