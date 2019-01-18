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
