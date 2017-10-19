# `expit`: the expit() function, rebranding of [`plogis`](plogis.html)

## Description


 the expit() function, rebranding of [`plogis`](plogis.html) 


## Usage

```r
expit(q, location = 0, scale = 1, lower.tail = TRUE, log.p = FALSE)
```


## Arguments

Argument      |Description
------------- |----------------
```...```     |     see args of see args of [`plogis`](plogis.html)

## Value


 a numeric


## Seealso


 [`plogis`](plogis.html) 


## Examples

```r 
 plot(x=seq(from=-10,to=10,by=1),y=expit(seq(from=-10,to=10,by=1)))
 identical(expit(10),stats::plogis(10))
 ``` 

