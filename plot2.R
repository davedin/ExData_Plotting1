#setwd('C:/www/r/exdata-project1')

if( !file.exists("household_power_consumption.txt") ) { # go get the file
    # download, unzip, and read file
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","household_power_consumption.zip")
    unzip( "household_power_consumption.zip")
    data <- read.table( "household_power_consumption.txt"
                        , nrows = 100000
                        , sep = ";"
                        , header = TRUE
    )

# download, unzip, and read a TEMP file
#temp <- tempfile()
#download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
#     data <- read.table( unz( temp, "household_power_consumption.txt" )
#                        , nrows = 100000
#                        , sep = ";"
#                        , header = TRUE
#     )
# unlink(temp)
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

#head(relevant)
#head(relevant[,c("Date","Time", "Global_active_power","DateTime","DayOfWeek")])
#tail(relevant[,c("Date","Time", "Global_active_power","DateTime","DayOfWeek")])



library(lubridate)
head( weekdays( relevant$DateTime, abbreviate = TRUE ) )

relevant$DayOfWeek <- weekdays( relevant$DateTime, abbreviate = TRUE )

# testing:
# head( sort(relevant$Global_active_power, decreasing= TRUE) )                 # RAW
# head( sort( as.numeric( relevant$Global_active_power, decreasing= TRUE ) ) ) # NOT RIGHT
# head( as.numeric( as.character(relevant$Global_active_power ) ) )            # RIGHT
# min( as.numeric( as.character(relevant$Global_active_power ) ) )
# max( as.numeric( as.character(relevant$Global_active_power ) ) )
# head(relevant)
# tail(relevant)


# open a PNG device
png(file = "plot2.png", bg = "transparent", width = 480, height = 480)


# create the plot
plot( relevant$DateTime, as.numeric( as.character(relevant$Global_active_power ) ), 
      type = "n",
      , ylab = "Global Active Power (kilowatts)"
      
      , xlab = ""
)
lines( relevant$DateTime, as.numeric( as.character(relevant$Global_active_power ) ) )
axis(2, seq( by= 2,from = 0, to = 6 ) )


# close the PNG device
dev.off()
