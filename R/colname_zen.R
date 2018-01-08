
#' The colname_zen() function zenifies a data frame's column names by lower and caterpillar casing
#'
#' @param df a data.frame
#' @param suffix a single character string (optional) to attach as a suffix to column names (default NULL)
#' @param ind_suffix an integer vector (optional) that picks the specific columns to attach the suffix (default NULL)
#'
#' @return a modified character vector of names that have been lower and caterpillar cased,
#' perhaps with an optional suffix attached
#'
#' @export
#'
#' @examples
#' df_foo = iris
#'
#' df_foo %>% colname_zen()
#' df_foo %>% colname_zen(.,suffix="src_1")
#' df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
#'
#' # assign names to original data frame
#' names_new = df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
#' names(df_foo) = names_new
#' names(df_foo)
#'
#' # use ?grepl() to pick col indices
#' names(df_foo)
#' ind_grep = which(grepl(names(df_foo),pattern=".Width"))
#' names_new_grep = df_foo %>% colname_zen(.,suffix="src_1",ind_grep)
#' names(df_foo) = names_new_grep
#' names(df_foo)
#'

colname_zen = function(df,
                       suffix=NULL,
                       ind_suffix=NULL){

  require(dplyr)
  require(stringr)
  # names(df)
  # suffix = NULL
  # suffix = 'src1'

  if(!is.null(suffix)){
    suffix_fin = paste0("_",suffix)
  } else {
    suffix_fin = NULL
  }
  # specific column index for suffix
  if(is.null(ind_suffix)){
    ind_suffix = seq_along(df)
    # else user supplied integer vector
  }
  if(any(!(ind_suffix %in% seq_along(df)))){
    stop('A column index you specified in "ind_suffix" is outside the range of seq_along(df)')
  }
  names_raw = names(df)
  names_case = names_raw %>%
    str_replace_all(.,pattern="\\.",replacement="_") %>%
    str_replace_all(.,pattern=" ",replacement="_") %>%
    tolower()
  # ind_suffix = c(1,4)
  names_new = paste0(names_case[ind_suffix],
                     suffix_fin)
  names_case[ind_suffix] = names_new
  return(names_case)

}




# df_foo = iris
#
# df_foo %>% colname_zen()
# df_foo %>% colname_zen(.,suffix="src_1")
# df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
#
# names_new = df_foo %>% colname_zen(.,suffix="src_1",c(1,5))
#
# # assign names to original data frame
# names(df_foo) = names_new
# names(df_foo)

## ?grepl() to pick col indices
# names(df_foo)
# ind_grep = which(grepl(names(df_foo),pattern=".Width"))
# names_new_grep = df_foo %>% colname_zen(.,suffix="src_1",ind_grep)
# names(df_foo) = names_new_grep
# names(df_foo)
