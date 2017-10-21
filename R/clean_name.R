
#' @title The clean_name() function scrubs out common artifacts in a character string of names
#'
#' @param name_unique a character vector containing a set of names to be parsed
#'
#' @return a character vector that has symbols removed from the supplied input 'name_unique'
#' @export
#'
#' @examples
#' # not run
#' # library(dplyr)
#' # name_all = c('joseph','joe','jo ',' joesephine','joseph','jo')
#' # name_all %>% clean_name()
#' #
#' # name_all_unique = name_all %>% clean_name() %>% unique %>% sort
#' #
#' # name_all_unique %>%
#' #   # other spot check manual gsubs
#' #   gsub(.,pattern='n/a',replace='') %>%
#' #   gsub(.,pattern='N/A',replace='') %>%
#' #   gsub(.,pattern="can't answer.*",replace='') %>%
#' #   gsub(.,pattern='dk',replace='') %>%
#' #   gsub(.,pattern='^x$',replace='')

clean_name = function(name_unique){

  require(dplyr)

  out_name_cleaner = name_unique %>%
    gsub(.,pattern='-',replace=' ') %>%
    gsub(.,pattern='\\?',replace='') %>%
    gsub(.,pattern='\\.',replace='') %>%
    gsub(.,pattern=',',replace='') %>%
    gsub(.,pattern=' \\(.*\\)',replace='') %>%  # parenthesis and its contents

    gsub(.,pattern='\\s{2}',replace='') %>%
    gsub(.,pattern='^\\s{1}$',replace='') %>%

    trimws() %>%
    ifelse(is.na(.),"9999",.) %>%  # replace formal R NA with 9999
    gsub(.,pattern='(^$)',replace='9999') # replace blank with 9999

  return(out_name_cleaner)
}


