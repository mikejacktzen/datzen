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

### I forgot about the weird base R name of that link function used in logistic regression.

Uhhh, it was what's his face! The one with the logis! Oh, you mean `logit`?

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

I forgot about the weird name of its inverse function too! Oh yeah... his ugly cousin, plogis. I know him as `expit`.

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

I'm too much of a homo-sapien, my phrases are never garbled enough (I blame my parents). I wish I could be more like a computer, or a homo-erectus.

``` r
dats_wat_she_said = 10
junk = garble(size_out=dats_wat_she_said)
junk
#> [1] "q*19xo$@rd"
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

### Weird Al `yankovise()` a String

I have a character string snipped from a song by [Daniel Son the Necklace Don](https://en.wikipedia.org/wiki/2_Chainz).
Let's get all Weird Al Yankovic with it.
I'll revise some words with the `yankovise()` function.

``` r
paste0(snip <<- "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop",
       " - @2chainz aka the Hair Weave Killer")
#> [1] "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop - @2chainz aka the Hair Weave Killer"
```

You can swap out words using a dictionary of name-value pairs. Below, we have a yankovised lyric from \[@2Chainz\_PhD\](<https://twitter.com/2Chainz_PhD?lang=en>).

aka CPU Core Killer
aka ProbaBittyBoi
aka Daniel Son the Data Don
aka El [Efron](http://statweb.stanford.edu/~ckirby/brad/) Jr.

``` r
# user supplied dictionary
dict_outin = c(datzen::dictate_outin('dealership','SERVER ROOM'),
                datzen::dictate_outin('big','LAP'),
                datzen::dictate_outin('rim','RAM'))

yankovise(snip,suffix="- @2Chainz_PhD",dict_outin = dict_outin)
#> Loading required package: stringr
#> [1] "suede sun roof hanging out da LAP top we leave da SERVER ROOM head 2 da RAM shop - @2Chainz_PhD"
```

You might ask, isn't this just a wrapper to `gsub` or `stringr::str_replace_all` with some added flavor? I might say, yes it is... with a narrower scope and outputs tweet-ready text.

Special Computations
--------------------

### Here you go, have this `lm` object I made. Bye!

Oh yeah, call me when you reach peak MSE!

``` r
model = lm(data = iris,
           Sepal.Length ~ Species + as.numeric(Species) +
             Species:Sepal.Width + as.factor(Sepal.Width) +
             as.factor(Sepal.Width)*as.factor(Petal.Length) +
             as.numeric(Species)*as.factor(Petal.Length) +
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

Since you met up with `lm` and started interacting with `Species` you think you're too much of a `factor` for your old crew, the `numeric` types, huh?

Get out of my face!

Data In/Out
-----------

### Ever wanted a generic simulated dataset to prototype modeling commands?

How did you know? I'm tired of using `data(iris)` because the column names aren't boring enough. Turn up the boring! I just want something fast and generic to swap out later.

``` r
simlm(p=7,n=5,output_meta=TRUE)
#> $yx
#>          y x1 x2        x3         x4        x5        x6         x7
#> 1 18.98098  1  1 0.8663830 0.46480265 0.9483923 0.9183236 0.01579857
#> 2 19.04144  1  1 0.4833880 0.94183665 0.5831352 0.3245085 0.92601212
#> 3 13.11357  1  1 0.8296948 0.08246333 0.1491715 0.8196555 0.09937781
#> 4 16.31561  1  0 0.7586169 0.43129564 0.3002075 0.9725371 0.63500377
#> 5 16.02722  1  1 0.6940746 0.43165829 0.3682681 0.4640613 0.75885503
#> 
#> $coef_true
#> [1] 1 2 3 4 5 6 7
#> 
#> $noise
#> [1]  1.1601290 -0.5208821  0.9351969 -0.4667076 -0.7193341

simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=FALSE) %>% lm(data=., y ~ -1+.)
#> 
#> Call:
#> lm(formula = y ~ -1 + ., data = .)
#> 
#> Coefficients:
#>     x1      x2      x3  
#> 68.837  22.720   7.629
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

# list.files(paste0(mainDir,subDir))
unlink(list.files(paste0(mainDir,subDir),full.names = TRUE),recursive=TRUE)

itersave(func_user=shaq,
         vec_arg_func=meatbags,
         mainDir,subDir)
```

The meatbags that Shaq successfully put into bodybags.

``` r
print('the successes')
#> [1] "the successes"
list.files(paste0(mainDir,subDir))
#> [1] "arg_1.rds" "arg_2.rds" "arg_3.rds" "failed"
```

It'll also book keep any errors along the way via [purrr](http://purrr.tidyverse.org/)::`safely()` and [R.utils](https://cran.r-project.org/web/packages/R.utils/index.html)::`withTimeout()`.

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

Ah, it was the 4th argument, Kobe, that boggled Shaq's mind.

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
```

So, give me the whole shebang. What was the whole story of Shaq's road trip?

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
