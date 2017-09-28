#' The simlm function
#'
#' @description Quickly simulate data from a basic linear model.
#'
#' Each of the n noise elements are from \code{\link[stats]{rnorm}}(mean=0,sd=1).
#'
#' Each of the n x p design-matrix elements are from \code{\link[stats]{runif}}(min=0,max=1).
#'
#' The outcome y is noise added to the linear combination of the design matrix with 'coef_true'.
#'
#' @param n integer for number of observations
#' @param p integer for number of cols in design matrix
#' @param coef_true vector (length p) for true lm coefficients
#' @param seed a seed for RNG (default NULL)
#'
#' @return a 3 element list with coef_true, yx, noise.
#'
#' The column names of yx are names(yx)=c('y',paste0("x",seq(1:p)))
#'
#' @export
#'
#' @examples
#'
#' simlm()
#'
#' out = simlm(n=1000,p=10)
#' lm(data=out$yx,y~-1+.)
#'
#' out = simlm(n=1000,seed=123)
#' lm(data=out$yx,y~-1+.)

simlm = function(n=10,p=4,coef_true=seq(1:p),seed=NULL){

  # n=10;p=4;coef_true=seq(1:p);seed=NULL

  if(!is.null(seed)){set.seed(seed)}


  noise = rnorm(mean=0,sd=1,n=n)
  mat_x = matrix(runif(p*n,min=0,max=1), ncol=p)
  y = (mat_x %*% coef_true) + noise

  yx = data.frame(y=y,mat_x)
  names(yx)=c('y',paste0("x",seq(1:p)))

  out = list(coef_true=coef_true,yx=yx,noise=noise)

  return(out)
}


