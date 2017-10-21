
#' @title The garble() function spits out random gibberish
#'
#' @param size_out an integer for length of output, must be 3 or larger
#' @param pattern_bank a single string of patterns (no space)
#'
#' @return a character vector of random characters
#' @export
#'
#' @examples
#'
#' garble(1)
#' garble(10)
#' garble(10,'!&@')
#' garble(3)


garble = function(size_out,pattern_bank='~!@#$%^&*()-+'){

  stopifnot(size_out >= 3)
  # if(size_out<3){stop('size_out must be 3 or larger')}

  pattern = unlist(stringr::str_split(pattern_bank,pattern=''))

  blah1 = sample(pattern,size=1)
  blah2 = sample(c(letters),size=1)
  blah3 = sample(c(0:9),size=1)
  blah4 = sample(c(pattern,letters,0:9),size=(size_out-3))

  ind_order = sample(1:4,replace=FALSE,size=4)
  shuffle_blah = paste0('blah',ind_order)
  scramble = unlist(lapply(shuffle_blah,function(xx){eval(parse(text=xx))}))

  return(paste0(scramble,collapse=''))
}

