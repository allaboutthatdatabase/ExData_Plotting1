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
png(filename = "plot3.png", width = 480, height = 480, units = "px")

#create the plot with type n, to fill in with lines
with(feb2days, #specify the data set to use 
	plot(datetime, #specify the variable to plot on the x-axis
		Sub_metering_1, #specify the variable to plot on the y-axis
		type = "n",#specify that the plot should be empty
		xlab = "", #specify the x-axis label (empty)
		ylab = "Energy sub metering" #specify the y-axis label
	)
)

#add data lines to the graph
#add the first data set, in default black
with(feb2days, lines(datetime, Sub_metering_1))

#add the second data set, in red lines
with(feb2days, lines(datetime, Sub_metering_2, col = "red"))

#add the third data set, in blue lines
with(feb2days, lines(datetime, Sub_metering_3, col = "blue"))

#add the legend in the top right corner
legend("topright", 
	lty=1, 
	col=c("black","red","blue"), 
	legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3")
)


#close the plot device
dev.off()