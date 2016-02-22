plot1<-function() {
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
        png(file = "plot1.png")
        hist(power$Global_active_power, col="red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
        dev.off()
}