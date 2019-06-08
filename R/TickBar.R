TickBar <- function(data, transaction){
    if(!inherits(data, "data.frame"))
        stop("data should be a data.frame type")
    n <- dim(data)[1]
    Index <- as.factor(floor((1:n)/transaction))

    Date <- aggregate(data$Time, by=list(Index), function(x) x[length(x)])
    Open <- aggregate(data$Price, by=list(Index), function(x) x[1])$x
    High <- aggregate(data$Price, by=list(Index), max)$x
    Low <- aggregate(data$Price, by=list(Index), min)$x
    Close <- aggregate(data$Price, by=list(Index), function(x) x[length(x)])$x
    Volume <- aggregate(data$Size, by=list(Index), sum)$x

    TickFinal <- data.frame(Time=Date, Open=Open, High=High,
                            Low=Low, Close=Close, Volume=Volume)
    return(TickFinal)
}


