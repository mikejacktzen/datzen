The 'datzen' R Package of Miscellaneous Helper Functions the Zen Way
====================================================================

The **datzen** package provides three categories of commonly used Zen functions:

-   data in / out
-   themes (rebranded functions and visual aesthetics)
-   special computation functions

The goal of this package is to help data analysts rapidly prototype common analysis scripts.

``` r
# devtools::install_github('mikejacktzen/datzen',force=TRUE)  
library(datzen)
library(dplyr)
```

Data I/O
--------

### Ever wanted a generic simulated dataset to prototype modeling commands?

How did you know? I hate using `data(iris)` because the column names aren't generic enough!

``` r
simlm(p=7,n=5,output_meta=TRUE)
#> $yx
#>          y x1 x2        x3        x4        x5         x6        x7
#> 1 10.11231  1  0 0.2771357 0.1538832 0.1782407 0.94974434 0.3503234
#> 2 10.66133  1  0 0.8950751 0.2387364 0.6347591 0.11428512 0.2553693
#> 3 11.32011  1  0 0.6868025 0.4539976 0.2623193 0.48003953 0.2675704
#> 4 11.26159  1  0 0.6307101 0.9174421 0.1309155 0.07129148 0.6549941
#> 5 19.96733  1  0 0.5595002 0.9283897 0.8897339 0.87008055 0.6295226
#> 
#> $coef_true
#> [1] 1 2 3 4 5 6 7
#> 
#> $noise
#> [1] -1.3765590  0.3740682  0.3788845 -0.9675960 -0.5005362

simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=TRUE)$yx %>% lm(data=., y ~ -1+.)
#> 
#> Call:
#> lm(formula = y ~ -1 + ., data = .)
#> 
#> Coefficients:
#>     x1      x2      x3  
#> 68.837  22.962   7.187
```

### Ever wanted to read in 5 random rows of some physical spreadsheet?

Someone handed me this dumb csv with 100 columns. I don't even know what's in it!

``` r

set.seed(1); m = matrix(rnorm(100*100),ncol=100,nrow=100)
csv = data.frame(m)
dim(csv)
#> [1] 100 100

tf <- tempfile()
write.csv(csv,tf,row.names=FALSE)
```

So... of course! I want to use lightweight data and quickly piece together code before I run it on the full data!

``` r
freadss(input=tf,ss=5,replace=TRUE) %>% dim
#> [1]   5 100
```

Themes
------

### I forgot about the wierd base R name of that link function used in logistic regression.

Uhhh, it was what's his face! The one with the logis!

Oh, you mean logit?

``` r
# ?logit
identical(logit(0.5),stats::qlogis(0.5))
#> [1] TRUE
txtplot::txtplot(x=seq(from=0.01,to=0.99,by=0.01),y=logit(seq(from=0.01,to=0.99,by=0.01)))
#>    +-+---------+----------+---------+---------+----------+-+
#>  4 +                                                    *  +
#>    |                                                   **  |
#>    |                                                 **    |
#>  2 +                                            *****      +
#>    |                                     ********          |
#>    |                           **********                  |
#>  0 +                  **********                           +
#>    |          ********                                     |
#> -2 +      *****                                            +
#>    |    **                                                 |
#>    |   *                                                   |
#> -4 +  *                                                    +
#>    +-+---------+----------+---------+---------+----------+-+
#>      0        0.2        0.4       0.6       0.8         1
```

I forgot about the wierd name of its inverse function too! Oh yeah... his ugly cousin, plogis. I know him as expit.

``` r
# ?expit
identical(expit(10),stats::plogis(10))
#> [1] TRUE
txtplot::txtplot(x=seq(from=-10,to=10,by=1),y=expit(seq(from=-10,to=10,by=1)))
#>     +-+------------+-----------+------------+-----------+--+
#>   1 +                                  * *  * *  * *  * *  +
#>     |                               *                      |
#> 0.8 +                                                      +
#>     |                             *                        |
#> 0.6 +                                                      +
#>     |                                                      |
#>     |                          *                           |
#> 0.4 +                                                      +
#>     |                        *                             |
#> 0.2 +                                                      +
#>     |                     *                                |
#>   0 + *  * *  * *  * *  *                                  +
#>     +-+------------+-----------+------------+-----------+--+
#>      -10          -5           0            5          10
```

### Ever wanted a random string of garbage?

I'm too much of a homo-sapien, my phrases are never random enough?! I wish I could be more like a homo-erectus, or a computer.

``` r
thats_what_she_said = 10

garble(size_out=thats_what_she_said)
#> [1] "dcb8retq4^"

junk = garble(size_out=thats_what_she_said)
```

### Is your workspace environment too clutered?

It was like that when I got here.

``` r
jimmy = 'johns'
nuts = 'planters'

ls()
#> [1] "csv"                 "jimmy"               "junk"               
#> [4] "m"                   "nuts"                "tf"                 
#> [7] "thats_what_she_said"
```

I want to remove **All But Deeze** ...

``` r
rmabd('nuts')
#> kept: nuts

ls()
#> [1] "nuts"
```
