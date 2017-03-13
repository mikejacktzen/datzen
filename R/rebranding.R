
#' the logit() function, rebranding of stats::qlogis
#'
#' @param ... see args of ?qlogis
#'
#' @return a numeric
#' @export
#'
#' @examples plot(x=seq(from=0,to=1,by=0.01),y=logit(seq(from=0,to=1,by=0.01)))
logit = stats::qlogis


#' the expit() function, rebranding of stats::qlogis
#'
#' @param ... see args of ?plogis
#'
#' @return a numeric
#' @export
#'
#' @examples plot(x=seq(from=-10,to=10,by=1),y=expit(seq(from=-10,to=10,by=1)))
expit = stats::plogis

