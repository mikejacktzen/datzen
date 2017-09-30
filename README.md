The 'datzen' package for R
==========================

The **datzen** package provides three categories of commonly used miscellaneous functions to achieve Data Zen
`٩(^ᴗ^)۶`

-   Themed Branding
-   Special Computations
-   Data In/Out

The goal of this package is to provide data analysts a few tools to rapidly prototype analysis scripts.

``` r
# devtools::install_github('mikejacktzen/datzen',force=TRUE)  
library(datzen)
library(dplyr)
```

Themed Branding
---------------

### I forgot about the wierd base R name of that link function used in logistic regression.

Uhhh, it was what's his face! The one with the logis! Oh, you mean logit?

``` r
# ?logit
identical(logit(0.5),stats::qlogis(0.5))
#> [1] TRUE
xx=seq(from=0.01,to=0.99,by=0.01);txtplot::txtplot(x=xx,y=logit(xx))
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
xxx=seq(from=-10,to=10,by=1);txtplot::txtplot(x=xxx,y=expit(xxx))
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

I'm too much of a homo-sapien, my phrases are never random enough (I blame my parents). I wish I could be more like a computer, or a homo-erectus.

``` r
dats_wat_she_said = 10

junk = garble(size_out=dats_wat_she_said)

junk
#> [1] "b72j&obm5%"
```

### Is your workspace environment too clutered?

It was like that when I got here.

``` r
jimmy = 'johns'
nuts = 'planters'

ls()
#> [1] "dats_wat_she_said" "jimmy"             "junk"             
#> [4] "nuts"              "xx"                "xxx"
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

Here you go, have this `lm` object I made. Bye!

``` r
model = lm(data = iris,
           Sepal.Length ~ Species + as.numeric(Species) +
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

Did you hear? That `data.frame` standing over there started hanging around with the wrong crowd. Boy [I tell you hwat](https://www.youtube.com/watch?v=p-JgNTvTA4E&feature=youtu.be), `lm` totally changed him.

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

Since you met up with `lm` and started interacting with `Species` you think you're too much of a `factor` for your old crew, the numeric types, huh?

Get out of my face!

Data In/Out
-----------

### Ever wanted a generic simulated dataset to prototype modeling commands?

How did you know? I'm tired of using `data(iris)` because the column names aren't boring enough. Turn up the boring! I just want something fast and generic to swap out later.

``` r
simlm(p=7,n=5,output_meta=TRUE)
#> $yx
#>          y x1 x2         x3         x4        x5        x6         x7
#> 1 18.04269  1  0 0.38995131 0.30898081 0.7369026 0.8511742 0.59610793
#> 2 19.96108  1  1 0.07772854 0.19305340 0.9119151 0.2635585 0.87053907
#> 3 16.14936  1  1 0.35906798 0.90059001 0.8573467 0.5128589 0.07243884
#> 4 11.51232  1  0 0.07469696 0.09487568 0.9713800 0.1519406 0.62070524
#> 5 14.27700  1  1 0.68849400 0.12147687 0.4005183 0.6421575 0.58810625
#> 
#> $coef_true
#> [1] 1 2 3 4 5 6 7
#> 
#> $noise
#> [1]  1.6726035  3.7209787  0.5988407 -0.2047494 -1.2466728

simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=FALSE) %>% lm(data=., y ~ -1+.)
#> 
#> Call:
#> lm(formula = y ~ -1 + ., data = .)
#> 
#> Coefficients:
#>     x1      x2      x3  
#> 69.569  22.380   6.467
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

So... of course. I just want a taste of the data. Give me a taste!

I'll use the subset to prototype something that works. Later, I'll run it on the whole shebang.

``` r
freadss(input=tf,ss=5,replace=TRUE) %>% dim
#> [1]   5 100
```

### The Glorious Franken-function `itersave()`

Ever wanted to just brute force some for loop? Aw poop, it crapped the bed during iteration 69. Now I have to manually restart it. I hope it doesn't do it again. I'm running out of patience, and linen.

``` r
shaq = function(meatbag){
  if(meatbag %in% 'scrub'){return('dunk on em')}
  if(meatbag %in% 'sabonis'){return('elbow his face')}
  if(!(meatbag %in% c('scrub','sabonis'))){
    stop('shaq is confused')}
  }

meatbags = c('scrub','sabonis','scrub','kobe')
names(meatbags) = paste0('arg_',seq_along(meatbags))

testthat::expect_failure(lapply(meatbags,FUN=shaq))
#> Error in FUN(X[[i]], ...): shaq is confused
```

Uh, some error confused Shaq.

*enter, stage trap door*
"Meet `itersave()` "
*front row faints*
"It's... hideously beautiful"

In a nutshell, `itersave` works like `lapply` but when it meets an ugly, unskilled, unqualified, and ungraceful error it will keep trucking along like Shaquille The Diesel O'Neal hitchhiking a ride on Chris Dudley's [back](https://www.youtube.com/watch?v=0ICBi-ku-G0)

``` r
mainDir=paste0(getwd(),'/tests/proto/')
subDir='/temp/'

itersave(func_user=shaq,
         vec_arg_func=meatbags,
         mainDir,subDir)
#> [1] "1 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_1"
#> [1] "2 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_2"
#> [1] "3 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_3"
#> [1] "4 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_4"
```

The meatbags that Shaq succesfully turned into bodybags.

``` r
print('the successes')
#> [1] "the successes"
list.files(paste0(mainDir,subDir))
#> [1] "arg_1.rds" "arg_2.rds" "arg_3.rds" "failed"
```

It'll also book keep any errors along the way (via `purrr::safely()` and `R.utils::withTimeout()`).

``` r
print('the failures')
#> [1] "the failures"
list.files(paste0(mainDir,subDir,'/failed/'))
#> [1] "arg_4.rds"
```

Along with the **out**, itersave has an **in** companion

*enter, zipline from balcony*
"meet `iterload()` "
*audience faints*

``` r
iterload(paste0(mainDir,subDir,'/failed'))
#> $arg_4
#> $arg_4$ind_fail
#> [1] 4
#> 
#> $arg_4$input_bad
#> [1] "kobe"
#> 
#> $arg_4$result_bad
#> <simpleError in (function (meatbag) {    if (meatbag %in% "scrub") {        return("dunk on em")    }    if (meatbag %in% "sabonis") {        return("elbow his face")    }    if (!(meatbag %in% c("scrub", "sabonis"))) {        stop("shaq is confused")    }})("kobe"): shaq is confused>
```

Ahh, it was the 4th argument, Kobe, that boggled Shaq's mind.

Hmm, Shaq wisened up in Miami. He also fattened up in Phoenix, Cleveland, Boston, Hawaii, Catalina, etc.

``` r
shaq_wiser = function(meatbag){
  if(meatbag %in% 'scrub'){return('dunk on em')}
  if(meatbag %in% 'sabonis'){return('elbow his face')}
  if(meatbag %in% 'kobe'){return('breakup & makeup')}

  if(!(meatbag %in% c('scrub','sabonis','kobe'))){
    stop('shaq is confused')}
}


itersave(func_user=shaq_wiser,
         vec_arg_func=meatbags,
         mainDir,subDir)
#> [1] "1 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_1"
#> [1] "2 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_2"
#> [1] "3 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_3"
#> [1] "4 of 4"
#> [1] "2017-09-30 15:46:54 PDT"
#> [1] "arg_4"
```

So, give me the whole shebang. What was the whole story of Shaqs road trip?

``` r
out_il = iterload(paste0(mainDir,subDir))
cbind(meatbags,out_il)
#>       meatbags  out_il            
#> arg_1 "scrub"   "dunk on em"      
#> arg_2 "sabonis" "elbow his face"  
#> arg_3 "scrub"   "dunk on em"      
#> arg_4 "kobe"    "breakup & makeup"
```

By itself `purrr::map` with `purrr::safely` is great, but by design, it'll do everything in one shot (eg batch results). This is not ideal when working with stuff online.

For web data in the wild, expect the unexpected. You have non-homogeneous edge cases aplenty. These Chris Dudley looking edge cases are just waiting in the bushes for you.
Dunk thru them.
