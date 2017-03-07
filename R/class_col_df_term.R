

#' Title
#'
#' @param model an 'lm' object
#' @param class_post_formula if FALSE (default) returns class of df col BEFORE any in-formula transformations applied to terms
#' if TRUE returns class of df col AFTER any in-formula transformations applied to terms
#'
#' @return a named list containing named character vectors. the list names are model terms. the vector names are data frame column names. the vector values are characters for the data frame column's class
#' @export
#'
#' @examples
class_df_from_term = function(model,class_post_formula=FALSE){

  hash_term = attr(terms(formula(model)),'factor')

  if(class_post_formula==TRUE){

    # class_post_formula=TRUE

    # return class of df col AFTER in-formula transformations applied to terms
    # note: informula '~ as.factor(x_cntns)' will return class 'factor'
    # looksup against 'attr(terms(model),'dataClasses')'

    list_class_df_from_term = apply(X=hash_term,MARGIN=2,
                                    FUN=function(X){

                                      # X=hash_term[,6]
                                      names(which(X != 0))
                                      attr(terms(model),'dataClasses')[names(which(X != 0))]
                                    })
  } else {

    # return class of df col BEFORE in-formula transformations applied to terms
    # note: informula '~ as.factor(x_cntns)' will return class of original 'x_cntns' and NOT 'factor'
    # looksup against 'dat_in = (eval(getCall(model)$data,environment(terms(model))))[1,]'

    # just one row
    dat_in = (eval(getCall(model)$data,environment(terms(model))))[1,]

    # iterate for each term in original parent formula
    # using colnames terms factor

    all_rhs_par_form = colnames(hash_term)


    # for each term, chop to individual formula involving only that term

    list_term_form_uses_col_df = sapply(X=all_rhs_par_form,USE.NAMES=TRUE,
                                        FUN=function(one_term){
                                          return(all.vars(as.formula(paste0('~',one_term))))
                                          # crucial that all.vars() interprets formula right
                                        })


    list_class_df_from_term = lapply(list_term_form_uses_col_df,
                                     FUN=function(list_colnames_df_oneterm){
                                       # list_colnames_df_oneterm=list_term_form_uses_col_df[2]
                                       classes_col_df = sapply(dat_in[1,unlist(list_colnames_df_oneterm)],class,USE.NAMES = TRUE)
                                       names(classes_col_df) = as.character(unlist(list_colnames_df_oneterm,use.names=FALSE))

                                       return(classes_col_df)
                                     })

  }


  # NOTE: result is a string hence
  # is.factor(list_class_df_from_term[1]) will be false
  # since is.factor() checks class

  return(list_class_df_from_term)
}


# # df col classes pre 'in-formula' transforms
# class_df_from_term(model,class_post_formula = FALSE)
#
# # df col classes post 'in-formula' transforms
# class_df_from_term(model,class_post_formula = TRUE)
#
# str(iris)
#
# model  <- lm(data = iris,Sepal.Length ~ Species + as.numeric(Species) +
#                Species:Sepal.Width + as.factor(Sepal.Width)+
#                as.factor(Sepal.Width)*as.factor(Petal.Length)+
#                as.numeric(Species)*as.factor(Petal.Length))
#
# terms(model)
#
# str(iris)
