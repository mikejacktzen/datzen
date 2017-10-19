#' The mandate() function enforces a data.frame to follow a schema
#'
#' @description The mandate() function converts each column of the supplied data.frame to the type listed in the supplied schema.
#' If the schema specs that data.frame column j should be numeric, then  then 'as.numeric(df[,j])' will be the result.
#'
#' @param df a data.frame of data whose column types and names will be mandated against a schema
#' @param schema_df a data.frame used as a schema to mandate each column in the df argument
#'
#' @details the schema_df argument should be the output of \code{\link[datzen]{scheme}}.
#'
#' @seealso \code{\link[datzen]{scheme}}
#'
#' @return an output data.frame similar to the input 'df' but the column types of 'df' may have been converted according to 'schema_df'
#' @export
#'
#' @examples
#' iris2=cbind(iris,Species_chr=as.character(iris$Species))
#' save_df_schema(x=iris2,outdir='~/projects/datzen/tests/')
#' schema_in = jsonlite::read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)
#'
#' library(dplyr)
#'
#' mandate(iris2,schema_df = schema_in) %>% str
#'
#' iris3 = iris2 %>% mutate_all(.funs=funs(as.character))
#' iris3 %>% str
#'
#' mandate(iris3,schema_df = schema_in) %>% str
#'
mandate = function(df,schema_df){

  # schema_df = schema_in
  # schema_df$schema_global
  # schema_df$schema_local

  # enforce data type
  # as.numeric() as.factor()

  mandate_col_type = lapply(1:(nrow(schema_df$schema_local)),FUN=function(xx){

    # xx = 1

    col_ind = schema_df$schema_local$indx_col[[xx]]
    col_type = schema_df$schema_local$class_col[[xx]]

    # meta programming
    prefix_as = paste0('as.',col_type)
    col_df_converted = do.call(eval(parse(text=prefix_as)),list(df[,col_ind]))

    return(col_df_converted)

  })

  # enforce col name
  names(mandate_col_type) = schema_df$schema_local$names_col
  out = data.frame(mandate_col_type)


  # String values are always quoted. Values of other types are never quoted.


  return(out)

}


# library(dplyr)
# schema_in = read_json('~/projects/datzen/tests/iris_schema.json',simplifyVector = TRUE)
# mandate(iris,schema_df = schema_in) %>% str
