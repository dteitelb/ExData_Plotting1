plot2<-function() {
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
        png(file = "plot2.png")
        with(power, {
                plot(Date+Time,Global_active_power,type="n", xlab = "", ylab = "Global Active Power (kilowatts)")
                lines(Date+Time,Global_active_power)
        })
        dev.off()
}