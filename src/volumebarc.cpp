#include <Rcpp.h>
using namespace Rcpp;

//' data
//'
//' @param DataFrame data
//' @param Integer volume
//'
//' @export
// [[Rcpp::export]]
DataFrame volumebarc(DataFrame data, int Vol){

    int nor = data.nrow();
    int temp_Vol, count, start_index = 0;

    NumericVector Price = data[1];
    NumericVector Volume = data[2];

    NumericVector Open, High, Low, Close, Volume_after, Transaction;
    //NumericVector Suma(nor);
    NumericVector temp;
    IntegerVector Index;

    int a = sum(Price);
    // 1
    //Rcout << a << std::endl;

    for(int i=0;i<nor;i++){
        temp_Vol += Volume[i];
        count = count + 1;
        // 2
        Rcout << i;
        if(temp_Vol > Vol){

            if(i==0){
                start_index = 0;
            } else {
                start_index = (i+1)-count;
            }
            // 3
           // Rcout << start_index << std::endl;

            Index = Range(start_index,i);

            // 4

            //Rcout << Index << std::endl;

            temp = Price[Index];

            // 5
            //Rcout << temp << std::endl;

            Open.push_back(Price[start_index]);
            High.push_back(max(temp));
            Low.push_back(min(temp));
            Close.push_back(Price[i]);
            Volume_after.push_back(temp_Vol);
            Transaction.push_back(count);

            count = 0;
            temp_Vol = 0;

        }
    }
    DataFrame NDF = DataFrame::create(Named("Open") = Open,
                                      Named("High") = High,
                                      Named("Low") = Low,
                                      Named("Close") = Close,
                                      Named("Volume") = Volume_after,
                                      Named("Transaction") = Transaction);
    return NDF;
}



// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
timesTwo(42)
*/
