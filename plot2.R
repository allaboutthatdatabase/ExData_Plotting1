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
png(filename = "plot2.png", width = 480, height = 480, units = "px")

#create the plot with type n, to fill in with lines
with(feb2days, #specify the data set to use 
	plot(datetime, #specify the variable to plot on the x-axis
		Global_active_power, #specify the variable to plot on the y-axis
		type = "n", #specify that the plot should be empty
		xlab = "", #specify the x-axis label (empty)
		ylab = "Global Active Power (kilowatts)" #specify the y-axis label
	)
)

#add data lines to the graph
with(feb2days, #specify the data set to use
	lines(datetime, Global_active_power) #specify the values to use on the x and y-axes
)

#close the plot device
dev.off()