# `simlm`: The simlm function

## Description


 Quickly simulate data from a basic linear model.
 
 Each of the n noise elements are from [`rnorm`](rnorm.html) (mean=0,sd=1).
 
 Except for columns 1 and 2, each of the design-matrix elements are from [`runif`](runif.html) (min=0,max=1).
 
 The outcome y is noise added to the linear combination of the design matrix with 'coef_true'.


## Usage

```r
simlm(n = 10, p = 4, coef_true = seq(1:p), seed = NULL,
  output_meta = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
```n```     |     integer for number of observations
```p```     |     integer for total number of cols in the design matrix. Note, offset from '3:p'. Since col 1 is reserved for intercept-column of 1s and col 2 is reserved for treatment-column of 1s/0s
```coef_true```     |     vector (length p) for true lm coefficients
```seed```     |     a seed for RNG (default NULL)
```output_meta```     |     a logical (default FALSE) determining if meta info is returned as list elements

## Value


 If 'output_meta=FALSE' (the default), only the data.frame 'yx' is returned.
 The column names of yx are names(yx)=c('y',paste0("x",seq(1:p))).
 
 If 'output_meta=TRUE', a 3 element list with yx, coef_true, noise.


## Examples

```r 
 
 simlm()
 
 out = simlm(n=1000,p=10)
 lm(data=out,y~-1+.)
 
 out = simlm(n=1000,seed=123)
 lm(data=out,y~-1+.)
 
 out = simlm(n=1000,seed=123,output_meta=TRUE)
 str(out)
 
 out = simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=TRUE)
 lm(data=out$yx[,-2], y ~ 1+.)
 
 ``` 

