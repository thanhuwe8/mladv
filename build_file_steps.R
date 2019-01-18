# Workflow for R data analysis
library("available")

bar_time <- function(data,type){

    type <- match.arg(type, c("minute", "hour", "day"))

    t0 <- min(data$Time)
    dtime_vec <- difftime(data$Time,t0, units="secs")

    if(!inherits(data, "data.frame"))
        stop("data should be a data.frame type")

    switch(type,
           minute = {
               time_group = as.numeric(floor(dtime_vec/60))
           },
           hour = {
               time_group = as.numeric(floor(dtime_vec/(60*60)))
           },
           day = {
               time_group = as.numeric(floor(dtime_vec/(60*60*24)))
           })

    Open <- aggregate(data$Price, by=list(time_group), function(x) x[1])$x
    High <- aggregate(data$Price, by=list(time_group), max)$x
    Low <- aggregate(data$Price, by=list(time_group), min)$x
    Close <- aggregate(data$Price, by=list(time_group), function(x) x[length(x)])$x
    Time <- aggregate(data$Time, by=list(time_group), function(x) x[length(x)])$x
    Volume <- aggregate(data$Size, by=list(time_group), sum)$x

    time_group <- data.frame(Date=Time, Open=Open, High=High,
                             Low=Low, Close=Close, Volume=Volume)
    return(time_group)
}


SSI_data <- read.csv("SSI.csv", header=T)
head(data)

date <- as.Date(SSI_data$Time, format="%Y-%m-%d %H:%M:%S")
SSI_data$Time <- date
SSI_data <- SSI_data[,-1]

use_data(SSI_data)

use_github(protocol = "https")

volumebarr <- function(data,  vol){
    nor <- nrow(data)
    temp_vol <- 0; Date <- NULL; Open <- NULL; High <- NULL;
    Low <- NULL; Close <- NULL; count=0; Transaction <- NULL;
    Volume <- NULL;
    price_vec <- data$Price;
    for (i in 1:nor){
        temp_vol <- temp_vol + data[i,3]
        count <- count + 1;
        print(i)
        if (temp_vol > vol){
            start_index <- i-count+1
            price <- price_vec[start_index:i]

            Date <- append(Date, data$Time[i])
            Open <- append(Open,price[1])
            High <- append(High,max(price))
            Low <- append(Low,min(price))
            Close <- append(Close,price[length(price)])
            Volume <- append(Volume, temp_vol)
            Transaction <- append(Transaction, count)

            temp_vol = 0
            count = 0
        }
    }
    data.frame(Date = Date, Open=Open, High=High, Low=Low,
               Close=Close,Volume=Volume, Transaction=Transaction)


}

dump("volumebarr", file="R/volumebarr.r")

SSI_data <- read.csv("SSI.csv", stringsAsFactors = F)

date <- as.POSIXct(SSI_data$Time, format="%Y-%m-%d %H:%M:%S", tz="GMT")
SSI_data$Time <- date

SSI_data <- SSI_data[,-1]
use_data(SSI_data)
