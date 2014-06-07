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


# open a PNG device
png(file = "plot4.png", bg = "transparent", width = 480, height = 480)


# make 2 x 2
par( mfrow = c(2, 2) )

#create plot 1x1 from plot2
plot( relevant$DateTime, as.numeric( as.character(relevant$Global_active_power ) ), 
      type = "n",
      , ylab = "Global Active Power (kilowatts)"
      
      , xlab = ""
)
lines( relevant$DateTime, as.numeric( as.character(relevant$Global_active_power ) ) )
axis(2, seq( by= 2,from = 0, to = 6 ) )

# create plot 1x2 - Voltage
plot( relevant$DateTime, as.numeric( as.character(relevant$Voltage ) )
      , type = "n",
      , ylab = "Voltage"
      , xlab = "datetime"
)
lines( relevant$DateTime, as.numeric( as.character(relevant$Voltage ) ) )



#create plot 2x1 from plot3
plot( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_1) ), 
      type = "n",
      , ylab = "Energy sub metering"
      , ylim = c(0,30)
      , xlab = ""
)
legend( "topright"
        , legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
        , col = c("black", "red", "blue")
        ,  pch = c("_____")
        , bty  = "n"# no box
)
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_1 ) ), col = "black")
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_2 ) ), col = "red" )
lines( relevant$DateTime, as.numeric( as.character( relevant$Sub_metering_3 ) ), col = "blue" )





#create plot 2x2 - Global Reactive Poer
plot( relevant$DateTime, as.numeric( as.character(relevant$Global_reactive_power ) )
      , type = "n",
      , ylab = "Global_reactive_power"
      , xlab = "datetime"
)
lines( relevant$DateTime, as.numeric( as.character(relevant$Global_reactive_power ) ) )




# close the PNG device
dev.off()
