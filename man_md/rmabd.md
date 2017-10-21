# `rmabd`: The rmabd() function removes 'all but deeze' objects

## Usage

```r
rmabd(list_keep = NULL, envir = globalenv())
```


## Arguments

Argument      |Description
------------- |----------------
```list_keep```     |     an optional list of names for objects to keep from '?rm()'. The default 'list_keep=NULL' will remove all objects.
```envir```     |     an optional environment. Defaults to '?globalenv()'.

## Value


 nothing but a message will be printed for the kept objects


## Examples

```r 
 x1 = 1
 x2 = 2
 x3 = 3
 ls()
 rmabd(list_keep=list('x1','x2'));ls()
 rmabd()
 ``` 

