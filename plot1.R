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

#pick the variable of interest for the 1st plot (g_a_p=Global Active Power)
g_a_p<-hpc[,3]

#make the histogramm and copy (save) it as plot1.png
hist(g_a_p,main="Global Active Power",xlab="Global Active Power (kilowatts)",ylab="Frequency",col="red")
dev.copy(png,file="plot1.png",height=480,width=480)
dev.off()
