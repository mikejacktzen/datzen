# http://corpustext.com/index.html

# library(dplyr)
# library(datzen)
# library(stringr)


##################################
# abbreviate for twitter brevity
# via brevitweet()
##################################

brevitweet = function(snip){
  require(dplyr);require(datzen);require(stringr);

  out = snip %>% datzen::clean_name(.) %>% stringr::str_split(.,pattern=" ") %>% unlist %>%
    stringr::str_replace(.,pattern="'|`","") %>%
    stringr::str_replace(.,pattern="you","u") %>%
    stringr::str_replace(.,pattern="the","da") %>%
    stringr::str_replace(.,pattern="^to$","2") %>%
    stringr::str_replace(.,pattern="too","2")
  return(out)
}

# snip = "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop"
# 'to too blah d' %>% brevitweet


##################################
# 1-1 swap via dictate_outin()
##################################

# ?stringr::str_replace_all
# for replacement, use a named vector
# the vector name is outswaped with vector value

#' @title the dictate_outin() function
#' @description An extremely simple function that creates a named vector.
#' A useful helper to create key-value dictionaries to use in \code{\link[stringr]{str_replace_all}}
#'
#' @param swap_out vector whose elements will be used as the names of the resulting character vector
#' @param swap_in vector whose elements will be used as the values of the resulting character vector
#'
#' @return a character vector with values from swap_in and names from swap_out
#' @export
#'
#' @examples
dictate_outin = function(swap_out,swap_in){

  # swap_out = 'rim'
  # out_in1 = c('RAM')
  # names(out_in1) = swap_out

  out_in = as.character(swap_in)
  names(out_in) = swap_out
  return(out_in)

  #note: generalize to many-many

}



##################################
# actual substitution via swap_out_in()
# using dictionary output of dictate_outin()
##################################

# dict_out_in = c(dictate_outin('bitch','statisBihhcian'),
#                 dictate_outin('dick','DATA'),
#                 dictate_outin('rim','RAM'))

swap_out_in = function(snip,dict_out_in){
  require(stringr)

  snip %>%
    # brevitweet %>%
    # stringr::str_replace(.,pattern=swap_out,swap_in) %>%
    stringr::str_replace_all(string=.,dict_out_in) %>%
    paste(.,collapse=" ")
}




##################################
# weird al datzen::yankovise()
##################################


#' The yankovise() function to Weird Al Yankovise a string
#' @description The function helps the user revise a lyric by substituting original words for thematic keywords.
#' NOTE: the input string will immediately be lowercased via tolower(snip)
#'
#' @param snip a character string of lyrics
#' @param brev a logical (default TRUE) determining whether to pass 'snip' into brevitweet(snip)
#' which abbreviates 'snip' for twitter brevity
#' @param dict_out_in a named character vector (default NULL) where an element's name will later be
#' swapped out for its associated value. When NULL, an internally hardcoded 'dict_out_in' is used.
#' See \code{\link[stringr]{str_replace_all}}
#' @param suffix a character string used as a suffix, say for a signed name.
#'
#' @return a character string that has been Weird Al yankovised() using elements
#' in 'dict_out_in' swapping value 4 name.
#' @export
#'
#' @examples
#'
#' snip = "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop"
#'
#' yankovise(snip,brev=FALSE)
#' yankovise(snip)
#' yankovise(snip,brev=TRUE,suffix="- @2chainz")
#'
#' # user supplied dictionary
#' dict_out_in = c(datzen::dictate_outin('dealership','SERVER ROOM'),
#'                 datzen::dictate_outin('big','LAP'),
#'                 datzen::dictate_outin('rim','RAM'))
#'
#' yankovise(snip,brev=TRUE,suffix="- @2chainz",dict_out_in = dict_out_in)

yankovise = function(snip,brev=TRUE,dict_out_in=NULL,suffix=NULL){
  require(dplyr)

  if(is.null(dict_out_in)){
    # default dictionary internal hardcode
    # optional arg if user wants to supply own
    dict_out_in = c(datzen::dictate_outin('rim','RAM'),
                    datzen::dictate_outin('bands','data'))
  }


  if(brev==TRUE){snip = brevitweet(tolower(snip))}

  # suffix="- @2chainz"

  snip_yankovised = swap_out_in(tolower(snip),dict_out_in) %>% append(.,suffix) %>% paste0(.,collapse=" ")

  return(snip_yankovised)
}



# snip = "Suede sun roof, hanging out the big top We leave the dealership, head to the rim shop"
#
# yankovise(snip,brev=FALSE)
# yankovise(snip)
# yankovise(snip,brev=TRUE,suffix="- @2chainz")
#
#
# list(nchar=nchar(snip_yankovised),snip_yankovised=snip_yankovised,
#      # title=title,
#      snip_orig=snip)
#
## user supplied dictionary
#
# dict_out_in = c(datzen::dictate_outin('dealership','SERVER ROOM'),
#                 datzen::dictate_outin('big','LAP'),
#                 datzen::dictate_outin('rim','RAM'))
#
# yankovise(snip,brev=TRUE,suffix="- @2chainz",dict_out_in = dict_out_in)


