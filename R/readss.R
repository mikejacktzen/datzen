
#' The readss() function reads a csv, but returns a sampled subset of rows
#'
#' @seealso \code{\link[utils]{read.csv}}
#'
#' @param ss an integer for desired row sample size
#' @param replace a logical picking with/without-replacement sampling
#' @param ... args passed to \code{\link{read.csv}}
#'
#' @return a 'data.frame' with subsampled rows
#' @export
#'
#' @examples
#' test1 <- c(1:5, "6,7", "8,9,10")
#' tf <- tempfile()
#' writeLines(test1, tf)
#'
#' read.csv(tf, fill = TRUE) # 1 column
#' readss(ss = 5,tf,replace=TRUE)
#' readss(ss = 100,tf,replace=FALSE)
#' readss(ss = 5,tf,replace=FALSE)

readss = function(ss=10,replace=TRUE,...){

  # ss = 100  # samp size

  dots = list(...)
  dat_raw = do.call(read.csv,dots)
  # better if do not have to read full then subset
  # if can just read subset initially

  # must know nrow beforehand

  if(nrow(dat_raw) < ss){
    ind_samp = sample(x=(1:nrow(dat_raw)),size=ss,replace=TRUE)
    warning('nrow() less than ss, so will force replace=TRUE')
  } else {
    ind_samp = sample(x=(1:nrow(dat_raw)),size=ss,replace=replace)
  }


  dat_samp = dat_raw[ind_samp,];

  return(dat_samp)
}





# TODO: advanced
# read all, figure out range of values for each column
# uniformly sample range of values
