

#' The match_2_bank() function
#'
#' @param bank_entity a single column data.frame that contains the unique population of entities inside bank_entity$bank_entity
#' @param col_name a single string for the name of the column in 'df_raw' to be processed and matched to bank_entity
#' @param df_raw a data.frame that contains the column specified by the 'col_name' argument
#' @param method the method argument passed to \code{\link[fuzzyjoin]{stringdist_left_join}}
#' @param max_dist the max_dist argument passed to \code{\link[fuzzyjoin]{stringdist_left_join}}
#'
#' @description Elements in df_raw[,col_name] will be fuzzyjoined to elements in bank_entity
#'
#' @return A 2 column data.frame with elements in df_raw[,col_name] fuzzyjoined to 'bank_entity' via \code{\link[fuzzyjoin]{stringdist_left_join}}
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
#' bank_entity = name_all_unique %>% clean_name() %>% unique %>% sort %>%
#'   gsub(.,pattern='^(Jo3)$|(J0)|(j0)|(jo3)',replace='') %>% # Joseph
#'   # spotcheck additional manual gsubs()
#'   unique %>% sort
#'
#' bank_entity = data.frame(bank_entity=bank_entity)
#' str(bank_entity)
#'
#'
#' library(stringdist)
#'
#' # run one example to figure out distance boundary
#' stringdist::stringdist("Jo","Joseph",method='jw')
#' # c("osa", "lv","dl", "hamming", "lcs", "qgram", "cosine", "jaccard", "jw", "soundex")
#'
#' match_2_bank(bank_entity=bank_entity,col_name="name_a",df_raw=df_raw)
#'
#' match_2_bank(bank_entity=bank_entity,
#'              col_name="name_b",df_raw=df_raw,
#'              max_dist=0.6,method='jw')
#'
# match_2_bank(bank_entity=bank_entity,
#              col_name="name_c",df_raw=df_raw,
#              max_dist=0.2,method='qgram')
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
#' # dat_edit[,'name_a'] = match_2_bank(bank_entity=bank_entity,col_name="name_a",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' # dat_edit[,'name_b'] = match_2_bank(bank_entity=bank_entity,col_name="name_b",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' # dat_edit[,'name_c'] = match_2_bank(bank_entity=bank_entity,col_name="name_c",df_raw=df_raw,max_dist=0.2,method='jw')[,2]
#' #
#' # head(dat_edit)
#' #
#' #' # dat_edit[,c('name_a','name_b','name_c')]
#' # df_raw[,c('name_a','name_b','name_c')]

match_2_bank = function(bank_entity,
                        col_name,df_raw,
                        method='jw',max_dist=0.2
                        ){

  require(fuzzyjoin)
  require(data.table)

  # subset and clean here, to standardize use of 'col_name_temp' name of column

  # note, clean_name() function can be used to clean 'words' too, going forward, add to it

  raw_entity = data.frame(col_name_temp=clean_name(df_raw[,col_name]))

  joined = tbl_df(raw_entity) %>%
    fuzzyjoin::stringdist_left_join(.,tbl_df(bank_entity),
                                    by = c(col_name_temp = "bank_entity"),
                                    max_dist = max_dist,
                                    method=method,
                                    ignore_case=TRUE)

  out = data.table::setnames(joined,old='col_name_temp',new=col_name)
  return(data.frame(out))
}
