
<!-- README.md is generated from README.Rmd. Please edit that file -->

# mladv

The package `mladv` provide tools to clean, convert and analyze the
financial data. It also provides various tools to apply machine learning
to financial data.

## Installation

We expect to release the package as soon as possible in
[CRAN](https://CRAN.R-project.org). At the mean time, you can install it
with devtools:

``` r
devtools::install_github("thanhuwe8/mladv")
```

## Example

First you load the data from the package

``` r
library(mladv)
head(data1,3)
#>                  Time Price   Size cum_volume  ppt
#> 1 2018-12-17 10:15:36  21.6 123460     123460 1.31
#> 2 2018-12-17 10:15:47  21.6    400     123860 0.00
#> 3 2018-12-17 10:16:07  21.6   3000     126860 0.03
```

With the data\_set, we can convert the raw market data into different
bars such as time bars or volume bars as examples below with `SSI_data`

``` r
volume6000 <- volumebarr(data1, 15000)
head(volume6000)
#>                  Time  Open  High   Low Close Volume Transaction
#> 1 2018-12-17 12:15:36 21.60 21.60 21.60 21.60 123460           1
#> 2 2018-12-17 12:16:22 21.60 21.60 21.60 21.60  50340           4
#> 3 2018-12-17 12:17:12 21.60 21.60 21.55 21.60  15530           4
#> 4 2018-12-17 12:18:01 21.60 21.60 21.60 21.60  21930           9
#> 5 2018-12-17 12:18:43 21.60 21.65 21.60 21.65  31330           4
#> 6 2018-12-17 12:20:56 21.65 21.65 21.60 21.65  16410          12
```

``` r
minute_bar <- timebar(data1, "minute")
head(minute_bar)
#>                  Time  Open  High   Low Close Volume
#> 1 2018-12-17 12:16:22 21.60 21.60 21.60 21.60 173800
#> 2 2018-12-17 12:17:25 21.60 21.60 21.55 21.60  23270
#> 3 2018-12-17 12:18:31 21.60 21.60 21.60 21.60  15470
#> 4 2018-12-17 12:19:34 21.65 21.65 21.60 21.65  33930
#> 5 2018-12-17 12:20:30 21.65 21.65 21.60 21.60   5060
#> 6 2018-12-17 12:21:33 21.60 21.65 21.60 21.65  37130
```

We can still use functions from popular packages such as `quantmod` or
`ggplot2` with the return data.frame

We will add more useful functions later.

# License

This project is licensed under the GPL3 License
