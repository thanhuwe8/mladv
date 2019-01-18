#' Volume bar transformations from raw data
#'
#' @param data a data.frame with follwing headers name: "Time", "Price", "Size", "cum_volume" and "ppt"
#' @param vol integer number for volume level
#'
#' @return a data.frame in the form OHLC with ending date for each bar.
#' @export
#'
#' @examples
#' tranform_data <- volumebarr(SSI_data, 5000)
volumebarr <-
function(data,  vol){

    if(!inherits(data, "data.frame"))
        stop("data should be a data.frame type")

    nor <- nrow(data)

    temp_vol <- 0; Date <- NULL; Open <- NULL; High <- NULL;
    Low <- NULL; Close <- NULL; Transaction <- NULL; Volume <- NULL;

    price_vec <- data$Price
    size <- data$Size
    count=0;

    for (i in 1:nor){
        temp_vol <- temp_vol + size[i]
        count <- count + 1
        #print(i)
        if (temp_vol > vol){
            # Starting index of a bar
            start_index <- i-count+1
            price <- price_vec[start_index:i]

            # Append to bars data.
            Date <- append(Date, data$Time[i])
            Open <- append(Open,price[1])
            High <- append(High,max(price))
            Low <- append(Low,min(price))
            Close <- append(Close,price[length(price)])
            Volume <- append(Volume, temp_vol)
            Transaction <- append(Transaction, count)

            # Reset the counter for volume and transactions.
            temp_vol = 0
            count = 0
        }
    }
    data.frame(Date = Date, Open=Open, High=High, Low=Low,
               Close=Close,Volume=Volume, Transaction=Transaction)


}
