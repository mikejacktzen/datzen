

#' The match_2_bank() function
#'
#' @param name_bank a single column data.frame that contains the unique population of names inside name_bank$name_bank
#' @param name_col a single string for the name of the colum in 'df_raw' to be processed
#' @param df_raw a data.frame that contains the column specified by the 'name_col' argument
#' @param method the method argument passed to \code{\link[fuzzyjoin]{stringdist_left_join}}
#' @param max_dist the max_dist argument passed to \code{\link[fuzzyjoin]{stringdist_left_join}}
#'
#' @return a 2 column data.frame with elements in 'name_col' fuzzyjoined to 'name_bank' via \code{\link[fuzzyjoin]{stringdist_left_join}}
#' @export
#'
#' @examples
#'
#' #######################################
#' # Create name bank of unique names
#' # all population of names
#' # need to disambiguate, get rid of redundant
#' # most likely manually
#' #######################################
#' library(dplyr)
#'
#'
#' df_raw = data.frame(name_a=c('joseph','joe','jo ',' joesephine','joseph','jo'),
#'                     name_b=c('joseph','jo3','jo ',' joesephine','joseph','jo'),
#'                     name_c=c('joseph','j0 '))
#'
#' names_col_to_pool = c('name_a','name_b','name_c')
#' name_all_unique = as.character(unlist(df_raw[,names_col_to_pool])) %>% unique %>% sort
#'
#' # creating name bank: drop mispelled, appeal to appx string match latter
#' name_bank = name_all_unique %>% clean_name() %>% unique %>% sort %>%
#'   gsub(.,pattern='^(Jo3)$|(J0)|(j0)|(jo3)',replace='') %>% # Joseph
#'   # spotcheck additional manual gsubs()
#'   unique %>% sort
#'
#' name_bank = data.frame(name_bank=name_bank)
#' str(name_bank)
#'
#'
#' library(stringdist)
#'
#' # run one example to figure out distance boundary
#' stringdist::stringdist("Jo","Joseph",method='jw')
#' # c("osa", "lv","dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex")
#'
#' match_2_bank(name_bank=name_bank,name_col="name_a",df_raw=df_raw)
#'
#' match_2_bank(name_bank=name_bank,
#'              name_col="name_b",df_raw=df_raw,
#'              max_dist=0.6,method='jw')
#'
#' match_2_bank(name_bank=name_bank,
#'              name_col="name_c",df_raw=df_raw,
#'              max_dist=0.2,method='qgram')
#'
#' # make sure output of match_2_bank() == nrow(df_raw)
#' nrow(df_raw)
#'
#' ##############################
#' # Replace
#' ##############################
#' # head(df_raw)
#' #
#' # dat_edit = df_raw
#' # dat_edit[,'name_a'] = match_2_bank(name_bank=name_bank,name_col="name_a",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' # dat_edit[,'name_b'] = match_2_bank(name_bank=name_bank,name_col="name_b",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' # dat_edit[,'name_c'] = match_2_bank(name_bank=name_bank,name_col="name_c",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' #
#' # head(dat_edit)
#' #
#' #' # dat_edit[,c('name_a','name_b','name_c')]
#' # df_raw[,c('name_a','name_b','name_c')]

match_2_bank = function(name_bank,
                        name_col,df_raw,
                        method='jw',max_dist=0.2
                        ){

  require(fuzzyjoin)
  require(data.table)

  # subset and clean here, to standardize use of 'name_col_temp' name of column

  name_raw = data.frame(name_col_temp=clean_name(df_raw[,name_col]))

  joined = tbl_df(name_raw) %>%
    fuzzyjoin::stringdist_left_join(.,tbl_df(name_bank),
                                    by = c(name_col_temp = "name_bank"),
                                    max_dist = max_dist,
                                    method=method,
                                    ignore_case=TRUE)

  out = data.table::setnames(joined,old='name_col_temp',new=name_col)
  return(data.frame(out))
}
