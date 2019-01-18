#' Time bar transformations from raw data
#'
#' Function to transform raw transactions data into a time bar for a specific timeframe.
#'
#' @param data a data.frame with follwing headers name: "Time", "Price", "Size", "cum_volume" and "ppt"
#' @param type type of time bar from "minute", "hour" or "day"
#'
#' @return a data.frame in the form OHLC with ending date for each bar.
#' @export
#'
#' @examples
#' transform_data <- bar_time(SSI_data, "minute")
timebar <-
function(data,type){

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


