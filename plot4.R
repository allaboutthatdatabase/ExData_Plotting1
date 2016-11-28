#read in the downloaded data set
fulldataset <- read.table("household_power_consumption.txt",sep=";", header = TRUE, na.strings = "?", colClasses = c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#get the subset of data that relates to the range we are interested in
feb2days <- subset(fulldataset, Date == "1/2/2007" | Date == "2/2/2007")

#drop the full data set to relieve memory pressure
rm("fulldataset")

#create a new column called datetime that concatenates the date and time columns
feb2days$datetime <- paste(feb2days$Date, feb2days$Time, sep = " ")

#change the format of that concatenated column to be date time format
feb2days$datetime <- strptime(feb2days$datetime, format = "%d/%m/%Y %H:%M:%S")


#create a png plot device
png(filename = "plot4.png", width = 480, height = 480, units = "px")

#configure the plot view to have two charts by two charts
par(mfrow=c(2,2))

#add the first chart with two calls to create the chart, then populate with data
with(feb2days, 
	plot(datetime, 
		Global_active_power, 
		type = "n", 
		xlab = "", 
		ylab = "Global Active Power (kilowatts)"
	)
)
with(feb2days, lines(datetime, Global_active_power))

# add the second chart with two calls to create the chart, then populate with data
with(feb2days, 
	plot(datetime, 
		Voltage, 
		type = "n", 
		ylab = "Voltage"
	)
)
with(feb2days, lines(datetime, Voltage))

#add the third chart, with a call to create the chart, then populate with 
#three data sets and a legend
with(feb2days, 
	plot(datetime, 
		Sub_metering_1, 
		type = "n", 
		xlab="", 
		ylab = "Energy sub metering"
	)
)
with(feb2days, lines(datetime, Sub_metering_1))
with(feb2days, lines(datetime, Sub_metering_2, col = "red"))
with(feb2days, lines(datetime, Sub_metering_3, col = "blue"))
legend("topright", 
	lty=1, 
	col=c("black","red","blue"), 
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
	bty="n" #no box around the legend
)

#add fourth chart with two calls to create the chart, then populate with data
with(feb2days, plot(datetime, Global_reactive_power, type = "n"))
with(feb2days, lines(datetime, Global_reactive_power))


#close the plot device
dev.off()