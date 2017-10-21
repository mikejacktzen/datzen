#' @title The simlm() function quickly simulates data from a basic linear model
#'
#' @description
#'
#' Each of the n noise elements are from \code{\link[stats]{rnorm}}(mean=0,sd=1).
#'
#' Except for columns 1 and 2, each of the design-matrix elements are from \code{\link[stats]{runif}}(min=0,max=1).
#'
#' The outcome y is noise added to the linear combination of the design matrix with 'coef_true'.
#'
#' @param n integer for number of observations
#' @param p integer for total number of cols in the design matrix. Note, offset from '3:p'.
#' Since col 1 is reserved for intercept-column of 1s and col 2 is reserved for treatment-column of 1s/0s
#' @param coef_true vector (length p) for true lm coefficients
#' @param seed a seed for RNG (default NULL)
#' @param output_meta a logical (default FALSE) determining if meta info is returned as list elements
#'
#' @return
#' If 'output_meta=FALSE' (the default), only the data.frame 'yx' is returned.
#' The column names of yx are names(yx)=c('y',paste0("x",seq(1:p))).
#'
#' If 'output_meta=TRUE', a 3 element list with yx, coef_true, noise.
#'
#' @export
#'
#' @examples
#'
#' simlm()
#'
#' out = simlm(n=1000,p=10)
#' lm(data=out,y~-1+.)
#'
#' out = simlm(n=1000,seed=123)
#' lm(data=out,y~-1+.)
#'
#' out = simlm(n=1000,seed=123,output_meta=TRUE)
#' str(out)
#'
#' out = simlm(p=3,n=100,coef_true = c(69,23,7),output_meta=TRUE)
#' lm(data=out$yx[,-2], y ~ 1+.)
#'
simlm = function(n=10,p=4,coef_true=seq(1:p),seed=NULL,output_meta=FALSE){

  # n=10;p=4;coef_true=seq(1:(p+2));seed=NULL;output_meta=FALSE

  if(p<=1){stop('if p<=1 , no point of simlm, just use univariate methods')}

  if(!is.null(seed)){set.seed(seed)}

  noise = rnorm(mean=0,sd=1,n=n)

  # x1 is always intercept column
  x1=rep(1,n)

  # x2 is always binary
  x2=sample(c(0,1),n,replace=TRUE)

  if(p>2){
    mat_p = matrix(runif((p-2)*n,min=0,max=1), ncol=(p-2))  # p-2 rnorm cols
  }else{
    mat_p=NULL
  }

  # mat_x = matrix(runif(p*n,min=0,max=1), ncol=p)
  mat_x=cbind(x1,  # enforce intercept
              x2,  # enforce binary treatment
              mat_p)

  y = (mat_x %*% coef_true) + noise

  yx = data.frame(y=y,mat_x)
  names(yx)=c('y',paste0("x",seq(1:p)))

  # optional, coef_true and noise not really needed, since redundant
  if(output_meta==TRUE){
    out = list(yx=yx,coef_true=coef_true,noise=noise)
  }else{
    out = yx
  }

  return(out)
}

# simlm(n=10000) %>% lm(data=.,y~.-1)
# simlm(n=100) %>% lm(data=.,y~.-1)
# simlm() %>% lm(data=.,y~.-1)
# simlm(n=100,p=6) %>% lm(data=.,y~.-1)
# simlm(p=2,n=1000) %>% lm(data=.,y~.-1)
# simlm(p=3,n=1000) %>% lm(data=.,y~.-1)
# simlm(p=1)
