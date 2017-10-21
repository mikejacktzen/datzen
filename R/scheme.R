#' @title The scheme() function creates a simple schema for a data.frame
#'
#' @description The schema should describe global characteristics of the data.frame (eg the number of rows and columns)
#' and local characteristics of the data.frame (eg each column name and type).
#' The resulting schema is saved as an external json file that complements the csv version of data.frame x.
#'
#' @param x a data.frame whose properties will be schemed() to a schema.
#' @param outdir a character string designating the output filepath (default NULL).
#' @param description_col a named character vector whose name elements are the column names of data.frame x and
#' each value element is a brief human-readable description of the column of x (default NA).
#' @param pattern_null a character string that contains the pattern for NULL values (default "NULL").
#' @param pattern_sep_row a character string that contains the pattern for seperating rows (default "\\n").
#' @param pattern_sep_col a character string that contains the pattern for seperating columns (default ",").
#' @param pattern_quote_string a character string that contains the pattern for quoting character values (default '"').
#' @param pattern_escape_quote a character string that contains the pattern for escaping quotes (default "\\").
#' @param ... optional arguments
#'
#' @return A nested list with 'schema_global' and 'schema_local' .
#' Note if the input argument 'outdir' is not NULL, a physical .json file is written to disk at the specified directory.
#'
#' @details This assumes the values in data.frame x contain the exhaustive scoped-population values
#' NOTE: Does not have to be population, just ensure coverage / support.
#'
#' @seealso \code{\link[datzen]{mandate}}
#'
#' @export
#'
#' @examples
#' iris2=cbind(iris,Species_chr=as.character(iris$Species))
#' scheme(x=iris2,outdir='~/projects/datzen/tests/')
#' jsonlite::read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)

scheme = function(x,
                  outdir=NULL,
                  pattern_null = "NULL",
                  pattern_sep_row = "\\n",
                  pattern_sep_col = ",",
                  pattern_quote_string = '"',
                  pattern_escape_quote = "\\",
                  description_col = NA,
                  ...){

  require(jsonlite)

  # x = iris


  #################################
  ## schema global for overall dataset
  #################################

  num_row = nrow(x)
  num_col = ncol(x)

  # enforce default options if user does not supply

#
#   # optional assign these default values in function scope
#   if(is.null(pattern_null)){pattern_null = "NULL"}
#
#   if(is.null(pattern_sep_row)){pattern_sep_row = "\n"}
#
#   if(is.null(pattern_sep_col)){pattern_sep_col = ","}
#
#   if(is.null(pattern_quote_string)){pattern_quote_string = "'"}
#
#   if(is.null(pattern_escape_quote)){pattern_escape_quote = "\\"}


  schema_global = list(num_row=num_row,
                       num_col=num_col,
                       pattern_sep_row=pattern_sep_row,
                       pattern_sep_col=pattern_sep_col,
                       pattern_null=pattern_null,
                       pattern_quote_string=pattern_quote_string,
                       pattern_escape_quote=pattern_escape_quote
                       )

  #################################
  # schema for columns
  #################################


  class_col = lapply(X=x[0,],FUN=class)
  names_col = names(x[0,])

  ####################
  # TODO: more assertions
  # chr length
  # number of factor levels
  # https://specs.frictionlessdata.io/table-schema/
  ####################

  # pattern not too useful if there are NAs

  pattern = lapply(X=x,FUN=function(xx){
    if ( is.factor(xx)||is.character(xx)) {
      # all possible categorical values
      return(paste0(unique(xx),collapse="|"))
    } else if ( is.double(xx) ) {
      return("[0-9]*\\.?[0-9]*")
    } else if ( is.integer(xx)) {
      return("[0-9]+")
    } else if (is.logical(xx)) {
      return("TRUE|FALSE")
    }
  })


  # have a 'description' column
  if(is.na(description_col)==FALSE){
    # make sure named vector of 'description_col' is ordered
    if(base::setequal(names(description_col),names_col)==FALSE){
      stop("The names of your character vector 'description_col' is not identical
           to the column names of your data.frame 'x' (they should be).")
      }
  }


  schema_local = as.data.frame(cbind(indx_col=seq_along(names_col),names_col,class_col,
                                     pattern,
                                     description_col),
                               row.names=NULL)


  schema = list(schma_global=schema_global,
                schema_local=schema_local)


  name_outfile = paste0(deparse(substitute(x)),"_schema.json")

  if(!is.null(outdir)){
    message("saved as: ",paste0(outdir,'/',name_outfile))

    jsonlite::write_json(x=schema,
                         path=paste0(outdir,'/',name_outfile))
    }

  return(schema)

}


#' The schema_df argument should contain 4 columns: ind_col, names_col, class_col, pattern.
#' The schema_df argument should have nrow(schema_df) == ncol(df).

# scheme(x=iris,outdir='~/projects/datzen/tests/')
# #
# setwd('~/projects/datzen/tests/')
# #
# scheme(x=iris)
# read_json('~/projects/datzen/tests/iris_schema.json',simplifyVector = TRUE)
#
# scheme(x=cars)
# read_json('~/projects/datzen/tests/cars_schema.json',simplifyVector = TRUE)
#
# iris2=cbind(iris,Species_chr=as.character(iris$Species),
#             width_int=as.integer(iris$Petal.Width),
#             tf=sample(c(TRUE,FALSE),size=nrow(iris2),replace=TRUE),
#             letters=sample(letters,size=nrow(iris2),replace=TRUE)
#             )
# scheme(x=iris2)
# read_json('~/projects/datzen/iris2_schema.json',simplifyVector = TRUE)
