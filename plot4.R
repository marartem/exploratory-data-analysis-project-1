library(lubridate)
library(dplyr)

#read at first the whole data, then keep(subsetting) just the two
# dates, remove the rest of data
hpc_all<- read.csv("~/household_power_consumption.txt", sep=";",na.strings="?",comment.char="", quote='\"')
hpc_all$Date<-as.Date(hpc_all$Date,format="%d/%m/%Y")
hpc<-filter(hpc_all,Date>="2007-02-01"& Date<="2007-02-02")
rm(hpc_all)

#convert dates and create a new variable where dates and times are combined
date_time<-paste(as.Date(hpc$Date),hpc$Time)
hpc$Date_time<-as.POSIXct(date_time)

# change the parameters to 2*2 plots
par(mfrow=c(2,2))

# change the language to english (instead of greek)
Sys.setlocale("LC_TIME", "English") 

# 1st plot
g_a_p<-hpc[,3]
plot(hpc$Global_active_power~hpc$Date_time,type="l",ylab="Global Active Power",xlab=" ")

# 2nd plot
Voltage<-hpc[,5]
plot(hpc$Voltage~hpc$Date_time,type="l",ylab="Voltage",xlab="datetime")

# 3rd plot
Sub_metering_1<-hpc[,7]
Sub_metering_2<-hpc[,8]
Sub_metering_3<-hpc[,9]
with(hpc,plot(Date_time,Sub_metering_1,type="n"))
yrange<-range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))
par(new=T)
with(hpc,plot(Date_time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black",ylim=yrange))
par(new=T)
with(hpc,plot(Date_time,Sub_metering_2,type="l",ylab="Energy sub metering",xlab=" ",col="red",ylim=yrange,))
par(new=T)
with(hpc,plot(Date_time,Sub_metering_3,type="l",ylab="Energy sub metering",xlab=" ",col="blue",ylim=yrange,))
legend("topright",cex=0.5,bty="n",lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# 4th plot
Global_reactive_power<-hpc[,4]
plot(hpc$Global_reactive_power~hpc$Date_time,type="l",ylab="Global_reactive_power",xlab="datetime")

dev.copy(png,file="plot4.png",height=480,width=480)
dev.off()
