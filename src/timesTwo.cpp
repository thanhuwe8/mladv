#include <Rcpp.h>
using namespace Rcpp;


//' Multiply by 2
//'
//' @param x A single integer
//' @export
// [[Rcpp::export]]

Rcpp::NumericVector timesTwo(Rcpp::NumericVector x) {
  return x * 2;
}


// You can include R code blocks in C++ files processed with sourceCpp
// (useful for testing and development). The R code will be automatically
// run after the compilation.
//

/*** R
timesTwo(42)
*/
