## store the current directory
initial.dir<-getwd()
## change to the new directory
setwd("R WD/ExData_Plotting1")
library(datasets)
##
## download file
temp<-tempfile("zipfile","/Users/istamato", fileext=".zip")
fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile=temp,method="curl")
unzip(temp)
unlink(temp)
## 
## read data
hpc<-read.table("household_power_consumption.txt",sep=";",col.names=c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3"),colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"), nrows=2880,skip=66637)
##
## combine date and time in Date as POSIXlt  
hpc$Date<-paste(hpc$Date,hpc$Time)
hpc$Date<-strptime(hpc$Date,"%d/%m/%Y %H:%M")
##
## open the png graphics device; create "plot1.png" in the working dir
png(filename = "plot4.png",
    width = 480, height = 480, units = "px", pointsize = 12,
    bg = "white",  res = NA, 
    type = c("quartz"))
##
## create plot
par(mfcol=c(2,2))
## first graph
plot(hpc$Date,hpc$Global_active_power,type="l",xlab="",ylab="Global active power")
## second graph
plot(hpc$Date,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
points(hpc$Date,hpc$Sub_metering_1,type="l")
points(hpc$Date,hpc$Sub_metering_2,type="l",col="red")
points(hpc$Date,hpc$Sub_metering_3,type="l",col="blue")
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"),bty="n")
## third graph
plot(hpc$Voltage,xlab="datetime",ylab="Voltage",type="l")
## fourth graph
plot(hpc$Date,hpc$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power", type="l")
## close the png graphics device
dev.off()
##
## unload the libraries
detach("package:datasets")
## change back to the original directory
setwd(initial.dir)
##