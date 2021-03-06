% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/coordinate_nb.R
\name{coordinate_nb}
\alias{coordinate_nb}
\title{The coordinate_nb() function returns spatial neighborhoods in a coordinate triplet format}
\usage{
coordinate_nb(foo_spdf, style = "B", dir_out = NULL, ...)
}
\arguments{
\item{foo_spdf}{an object of class \code{\link[sp]{SpatialPolygonsDataFrame}}}

\item{style}{an optional character representing the style of spatial weights
The same 'style' arg in \code{\link[spdep]{nb2listw}}}

\item{dir_out}{an optional character representing the output directory
if the user wishes to write to a '.csv'}

\item{...}{optional arguments passed to \code{\link[spdep]{nb2listw}}}
}
\value{
A data.frame of the nb-coordinate triplets ("from","to","weights") with 'spatial.neighbour' class returned from \code{\link[spdep]{listw2sn}}
}
\details{
If dir_out=NULL (the default), then a data.frame of (i,j,k) coordinate triplets is returned to the environment.
See \code{\link[spdep]{listw2sn}} for more details.
Otherwise a '.csv.' will be created at the specified destination path.
}
\examples{
example(columbus,package="spdep")
out_ijk = coordinate_nb(foo_spdf=columbus, zero.policy=TRUE)

# above output is in coordinate structure
# below converts to adjacency matrix
mat_adj = spdep::as.spam.listw(sn2listw(out_ijk))
}
