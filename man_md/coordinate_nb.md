# `coordinate_nb`: The coordinate_nb() function returns spatial neighborhoods in a coordinate triplet format

## Usage

```r
coordinate_nb(foo_spdf, style = "B", dir_out = NULL, ...)
```


## Arguments

Argument      |Description
------------- |----------------
```foo_spdf```     |     an object of class [`SpatialPolygonsDataFrame`](SpatialPolygonsDataFrame.html)
```style```     |     an optional character representing the style of spatial weights The same 'style' arg in [`nb2listw`](nb2listw.html)
```dir_out```     |     an optional character representing the output directory if the user wishes to write to a '.csv'
```...```     |     optional arguments passed to [`nb2listw`](nb2listw.html)

## Details


 If dir_out=NULL (the default), then a data.frame of (i,j,k) coordinate triplets is returned to the environment.
 See [`listw2sn`](listw2sn.html) for more details.
 Otherwise a '.csv.' will be created at the specified destination path.


## Value


 A data.frame of the nb-coordinate triplets ("from","to","weights") with 'spatial.neighbour' class returned from [`listw2sn`](listw2sn.html) 


## Examples

```r 
 example(columbus,package="spdep")
 out_ijk = coordinate_nb(foo_spdf=columbus, zero.policy=TRUE)
 
 # above output is in coordinate structure
 # below converts to adjacency matrix
 mat_adj = spdep::as.spam.listw(sn2listw(out_ijk))
 ``` 

