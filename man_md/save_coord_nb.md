# `save_coord_nb`: The save_coord_nb() function

## Description


 The save_coord_nb() function


## Usage

```r
save_coord_nb(foo_spdf, style = "B", dir_out = NULL)
```


## Arguments

Argument      |Description
------------- |----------------
```foo_spdf```     |     an object of class [`SpatialPolygonsDataFrame`](SpatialPolygonsDataFrame.html)
```style```     |     an optional character representing the style of spatial weights The same 'style' arg in [`nb2listw`](nb2listw.html)
```dir_out```     |     an optional character representing the output directory if the user wishes to write to a '.csv'

## Value


 A data.frame of the nb-coordinate triplets ("from","to","weights") with 'spatial.neighbour' class returned from [`listw2sn`](listw2sn.html) 


## Examples

```r 
 example(columbus); save_coord_nb(foo_spdf=columbus)
 ``` 

