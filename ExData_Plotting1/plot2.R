
## download dataset

if(!file.exists("exdata-data-household_power_consumption.zip")) {
    temp <- tempfile()
    download.file("http://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",temp)
    file <- unzip(temp)
    unlink(temp)
}


## load data (only data for the given time period)
first_row <-read.csv(file, sep=";",na.strings="?",nrows =1) ## load 1st row only
dt_start <-as.Date(first_row$Date,format="%d/%m/%Y")
time_init <- paste(dt_start,first_row[,2]) ## extract time info of the 1st fow
dt1<-"2007-02-01 00:00:00" ## start date
dt2<-"2007-02-02 23:59:00" ##end date

row_start<-as.numeric(difftime(dt1,time_init),units="mins") ## row number to be skipped for specified time start
row_delta<-as.numeric(difftime(dt2,dt1),units="mins")+1 # row numbers within specified time period

data <-read.csv(file, sep=";",na.strings="?",skip = row_start+1,nrows=row_delta,header=F) ## load data from download
colnames(data)<-colnames(first_row) # get colnames


## plot figure 2
data$DateTime <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S") # add new column into Data
plot(data$DateTime, data$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")


## Saving to png file
dev.copy(png, file="Plot2.png", height=480, width=480)
dev.off()