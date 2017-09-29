The 'datzen' R Package of Miscellaneous Helper Functions the Zen Way
====================================================================

The **datzen** package provides three categories of commonly used Zen functions:

-   Data In/Out
-   Themed Branding
-   Special Computations

The goal of this package is to help data analysts rapidly prototype common analysis scripts.

``` r
# devtools::install_github('mikejacktzen/datzen',force=TRUE)  
library(datzen)
library(dplyr)
```

Data In/Out
-----------

### Ever wanted a generic simulated dataset to prototype modeling commands?

How did you know? I hate using `data(iris)` because the column names aren't generic enough!

``` r
simlm(p=7,n=5,output_meta=TRUE)
#> $yx
#>          y x1 x2        x3          x4        x5        x6        x7
#> 1 12.84826  1  1 0.5383498 0.709865254 0.2681348 0.5326178 0.3656095
#> 2 15.54874  1  1 0.4557906 0.582226413 0.7507016 0.1426762 0.7435417
#> 3 22.62202  1  1 0.7631094 0.615097756 0.6831683 0.8213452 0.7548770
#> 4 13.41777  1  0 0.6334965 0.006803898 0.4388427 0.4336515 0.8400323
#> 5 15.71854  1  1 0.4457046 0.826879892 0.7199102 0.4678335 0.1874187
#> 
#> $coef_true
#> [1] 1 2 3 4 5 6 7
#> 
#> $noise
#> [1] -1.7019001 -0.9618911  1.2442444 -0.1862855  0.3554275

simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=TRUE)$yx %>% lm(data=., y ~ -1+.)
#> 
#> Call:
#> lm(formula = y ~ -1 + ., data = .)
#> 
#> Coefficients:
#>     x1      x2      x3  
#> 68.950  22.741   7.252
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

Themed Branding
---------------

### I forgot about the wierd base R name of that link function used in logistic regression.

Uhhh, it was what's his face! The one with the logis! Oh, you mean logit?

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

I'm too much of a homo-sapien, my phrases are never random enough. I wish I could be more like a computer, or a homo-erectus.

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

Special Computations
--------------------

Here you go, have this lm object.

``` r
model = lm(data = iris,Sepal.Length ~ Species + as.numeric(Species) +
             Species:Sepal.Width + as.factor(Sepal.Width)+
             as.factor(Sepal.Width)*as.factor(Petal.Length)+
             as.numeric(Species)*as.factor(Petal.Length)+
             poly(Sepal.Width,degree = 2))
```

What's in it? What'd you do to it? Does it have cooties?

``` r
class_df_from_term(model,class_post_formula = FALSE)
#> $Species
#>  Species 
#> "factor" 
#> 
#> $`as.numeric(Species)`
#>  Species 
#> "factor" 
#> 
#> $`as.factor(Sepal.Width)`
#> Sepal.Width 
#>   "numeric" 
#> 
#> $`as.factor(Petal.Length)`
#> Petal.Length 
#>    "numeric" 
#> 
#> $`poly(Sepal.Width, degree = 2)`
#> Sepal.Width 
#>   "numeric" 
#> 
#> $`Species:Sepal.Width`
#>     Species Sepal.Width 
#>    "factor"   "numeric" 
#> 
#> $`as.factor(Sepal.Width):as.factor(Petal.Length)`
#>  Sepal.Width Petal.Length 
#>    "numeric"    "numeric" 
#> 
#> $`as.numeric(Species):as.factor(Petal.Length)`
#>      Species Petal.Length 
#>     "factor"    "numeric"
```

Did you hear? That `data.frame` standing over there started hanging around with the wrong crowd. Yeah, `lm` totally changed him.

``` r
class_df_from_term(model,class_post_formula = TRUE)
#> $Species
#>  Species 
#> "factor" 
#> 
#> $`as.numeric(Species)`
#> as.numeric(Species) 
#>           "numeric" 
#> 
#> $`as.factor(Sepal.Width)`
#> as.factor(Sepal.Width) 
#>               "factor" 
#> 
#> $`as.factor(Petal.Length)`
#> as.factor(Petal.Length) 
#>                "factor" 
#> 
#> $`poly(Sepal.Width, degree = 2)`
#> poly(Sepal.Width, degree = 2) 
#>                   "nmatrix.2" 
#> 
#> $`Species:Sepal.Width`
#>     Species Sepal.Width 
#>    "factor"   "numeric" 
#> 
#> $`as.factor(Sepal.Width):as.factor(Petal.Length)`
#>  as.factor(Sepal.Width) as.factor(Petal.Length) 
#>                "factor"                "factor" 
#> 
#> $`as.numeric(Species):as.factor(Petal.Length)`
#>     as.numeric(Species) as.factor(Petal.Length) 
#>               "numeric"                "factor"
```

What happened `Petal.Length` ? You used to be cool.

Since you met up with `lm` and started interacting with `Species` you think you're too much of a `factor` for us?

Get out of my face!
