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

# change the language to english (instead of greek)
Sys.setlocale("LC_TIME", "English") 

#pick the variables of interest for the 3rd plot 

Sub_metering_1<-hpc[,7]
Sub_metering_2<-hpc[,8]
Sub_metering_3<-hpc[,9]

# make an empty plot
with(hpc,plot(Date_time,Sub_metering_1,type="n"))

#and then fill it with the variables and legend and copy it as plot3.png
yrange<-range(c(Sub_metering_1,Sub_metering_2,Sub_metering_3))
with(hpc,plot(Date_time,Sub_metering_1,type="l",ylab="Energy sub metering",xlab=" ",col="black",ylim=yrange))
par(new=T)
with(hpc,plot(Date_time,Sub_metering_2,type="l",ylab="Energy sub metering",xlab=" ",col="red",ylim=yrange,))
par(new=T)
with(hpc,plot(Date_time,Sub_metering_3,type="l",ylab="Energy sub metering",xlab=" ",col="blue",ylim=yrange,))
legend("topright",cex=0.75,lty=c(1,1,1),col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
dev.copy(png,file="plot3.png",height=480,width=480)
dev.off()
