#read in the downloaded data set
fulldataset <- read.table("household_power_consumption.txt",sep=";", header = TRUE, na.strings = "?", colClasses = c("character","character", "numeric","numeric","numeric","numeric","numeric","numeric","numeric"))

#get the subset of data that relates to the range we are interested in
feb2days <- subset(fulldataset, Date == "1/2/2007" | Date == "2/2/2007")

#drop the full data set to relieve memory pressure
rm("fulldataset")

#create a png plot device
png(filename = "plot1.png", width = 480, height = 480, units = "px")

#create the histogram
with(feb2days, #specify the data set to use 
	hist(Global_active_power, #specify the variable to plot
		xlab = "Global Active Power (kilowats)", #specify the x-axis label
		ylab = "Frequency", #specify the y-axis label
		main = "Global Active Power", #specify the main title
		col = "red" #specify the plot color
	) 
) 

#close the plot device
dev.off()

