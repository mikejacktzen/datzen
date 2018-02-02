# `moran_op`: The moran_op() function computes the moran operator

## Usage

```r
moran_op(x_features, coord_nb)
```


## Arguments

Argument      |Description
------------- |----------------
```x_features```     |     a data.frame of features that will be coerced [`as.matrix`](as.matrix.html)
```coord_nb```     |     a data.frame of the nb-coordinate triplets (i,j,k) returned from [`coordinate_nb`](coordinate_nb.html) or [`listw2sn`](listw2sn.html)

## Value


 A list of quantities related to the Moran Operator.
 NOTE: the list structure is ready to be passed to the STAN mcmc software


## Examples

```r 
 library(spdep); example(columbus)
 x_features = columbus$AREA
 coord_nb = save_coord_nb(foo_spdf=columbus)
 moran_op(x_features,coord_nb)
 ``` 

