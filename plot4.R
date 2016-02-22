plot4<-function() {
        library(lubridate)
        library(dplyr)
        setwd("~/")
        if(!dir.exists("./temp")) dir.create("./temp")
        setwd("./temp")
        if(!file.exists("temp.zip")) {
                download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip","temp.zip")
                unzip("temp.zip")
        }
        power<-read.table("household_power_consumption.txt",stringsAsFactors = F,
                          header=T, sep=";",na.strings="?",colClasses = c(rep("character",2),rep("numeric",7)))
        dates<-ymd(c("2007-02-01","2007-02-02"))
        power<-power %>% mutate(Date=dmy(Date)) %>% filter(Date %in% dates)
        power<-power %>% mutate(Time=hms(Time))
        vars<-colnames(power)[7:9]
        cols<-c("gray","red","blue")
        png(file = "plot4.png")
        par(mfrow=c(2,2))
        with(power, {
                plot(Date+Time,Global_active_power,type="n", xlab = "", ylab = "Global Active Power")
                lines(Date+Time,Global_active_power)                
                plot(Date+Time,Voltage,type="n", xlab = "datetime", ylab = "Voltage")
                lines(Date+Time,Voltage)
        })
        with(power,plot(Date+Time,Sub_metering_1,type="n", xlab = "", ylab = "Energy sub metering"))
        for (i in 1:3) {lines(power$Date+power$Time,power[,i+6],col=cols[i])}
        legend("topright",lty=c(1,1),col=cols,legend=vars)
        with(power, {
                plot(Date+Time,Global_reactive_power,type="n", xlab = "datetime")
                lines(Date+Time,Global_reactive_power)
        })
        dev.off()
}

        