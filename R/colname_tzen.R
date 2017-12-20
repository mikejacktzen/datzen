

#' the colname_zen() function zenifies a data frame's column names by lower and caterpillar casing
#'
#' @param df a data.frame
#' @param suffix a single character string to attach as a suffix to column names
#'
#' @return a data.frame whose column names have been lower and caterpillar cased
#' @export
#'
#' @examples
#' iris %>% colname_zen() %>% head
#'
#' iris %>% colname_zen(.,suffix="src_1") %>% head


colname_zen = function(df,suffix=NULL){

  require(dplyr)
  require(rlang)

  # names(df)

  # suffix = NULL
  # suffix = 'src1'

  if(!is.null(suffix)){
    suffix_fin = paste0("_",suffix)
  } else {
    suffix_fin = NULL
  }

  rlang::set_names(df,~
                     str_replace_all(.x,pattern="\\.",replacement="_") %>%
                     str_replace_all(.,pattern=" ",replacement="_") %>%
                     tolower() %>%
                     paste0(.,suffix_fin))

}

# iris %>% colname_zen() %>% head
# iris %>% colname_zen(.,suffix="src_1") %>% head


