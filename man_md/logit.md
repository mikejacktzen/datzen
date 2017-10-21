# `logit`: The logit() function is a rebranding of [`qlogis`](qlogis.html)

## Usage

```r
logit(p, location = 0, scale = 1, lower.tail = TRUE, log.p = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
```...```     |     see args of [`qlogis`](qlogis.html)

## Value


 a numeric


## Seealso


 [`qlogis`](qlogis.html) 


## Examples

```r 
 plot(x=seq(from=0,to=1,by=0.01),y=logit(seq(from=0,to=1,by=0.01)))
 identical(logit(0.5),stats::qlogis(0.5))
 ``` 

