
# formula_tab = 1 ~ hair_color + gender + species +
#   mass + birth_year

# eventually generalize to allow (|) spec for cut points
# internal processed for categorization

# formula_tab_gen = 1 ~ (hair_color|'raw') +
#   (gender|'3') + 
#   (species|'4') +
#   (mass|'median') + (birth_year|'iqr')

# eventually fold in weights for counts

# formula_tab_gen = (1|ipw=weights_design) ~ (hair_color|'raw') +
#   (gender|'3') +  # 3 most freq categories
#   (species|'4') +  # 4 most freqq categories
#   (mass|'median') +  # hi/lo split at median
# (birth_year|'iqr')  # hi/med/lo split via iqr 

# (mass|3) +  # if (numeric|numeric) then cutpoint
# (mass|c(30,40))  # 3 categories cut at 30 and 40

# library(dplyr)
# dat_in = starwars

tree_tab = function(formula_tab,dat_in){
  
  require(dplyr)
  
  # data(starwars)
  # names(starwars)
  # test = starwars %>% 
  #   count(hair_color, gender,species, sort = TRUE)
  # 
  # test %>% count(hair_color,gender)
  # test %>% count(hair_color)
  
  # model = 1 ~ hair_color + gender + species +
  # mass + birth_year
  
  # model = wt ~ hair_color + gender + species
  
  stopifnot('formula' %in% class(formula_tab))
  
  # terms_inorder = attr(terms(formula(model)),'term.labels')
  terms_inorder = row.names(attr(terms(formula(formula_tab)),'factor'))
  
  terms_rhs = terms_inorder[!(terms_inorder %in% "1")]
  
  # subset data to formula terms 
  dat_in = dat_in[terms_rhs]
  
  class_terms_rhs = lapply(terms_rhs,function(x)class(dat_in[[x]]))
  
  names(class_terms_rhs) = terms_rhs
  
  # cutpoint pre process ----------------------------------------------------
  
  
  # categorical split top 3 -------------------------------------------------
  
  # figure out non numeric
  # terms_rhs
  
  # var_cat = c(6,7)
  # var_cat = terms_rhs
  
  var_cat = which(class_terms_rhs %in% c("character","factor"))
  
  dat_lumped = dat_in %>% 
    mutate_at(.,.vars=var_cat,
              .funs=funs(cut_datzen=forcats::fct_lump(f=.,
                                                      n=2,
                                                      ties.method="min") ) )
  
  
  # median split ------------------------------------------------------------
  
  
  # var_cont = c(3,5,9)
  # var_cont = terms_rhs
  
  var_cont = which(class_terms_rhs %in% c("numeric","integer"))
  
  dat_tab_dplyr = dat_lumped %>% 
    mutate_at(.vars=var_cont,
              .funs=funs(cut_datzen=ntile(.,n=2)))
  
  # View(dat_out)
  
  # iqr split ---------------------------------------------------------------
  
  
  # list of count tables ----------------------------------------------------
  # iterate rollback via dplyr 
  
  list_tab_count = vector(mode='list',length=length(terms_rhs))
  # length(terms_rhs)
  
  terms_roll = paste0(terms_rhs,"_cut_datzen")
  
  # start at last child table (ull depth)
  tab_child = dat_tab_dplyr %>% 
    count_(terms_roll, sort = TRUE)
  
  # assign at end of list
  list_tab_count[[length(terms_rhs)]] = tab_child
  
  # iterate forward from first ancester
  # note: for loop is easiest syntax
  
  for(i in 1:(length(terms_rhs)-1)){
    terms_roll_i = terms_roll[1:i]
    tab_ancs_i = tab_child %>% count_(terms_roll_i)
    
    # assign to list prospectively
    list_tab_count[[i]] = tab_ancs_i
  }
  
  
  # View(list_tab_count)
  # View(list_tab_count[[1]])
  # View(list_tab_count[[2]])
  # View(list_tab_count[[3]])
  # View(list_tab_count[[4]])
  # View(list_tab_count[[5]])
  # 
  # sum(list_tab_count[[1]][,2])
  # sum(list_tab_count[[4]][,5])
  # sum(list_tab_count[[5]][,6])
  
  # tree printout -----------------------------------------------------------
  # terms_roll_i
  
  # dim(tab_child)
  # figure out how to pass in vector of vars
  # terms_roll_i

  # dat_tree$pathString <- paste("all",
  #                              # these define 'primary keys'
  #                              # order matters
  #                              tab_child$hair_color_cut_datzen,
  #                              tab_child$gender_cut_datzen,
  #                              tab_child$species_cut_datzen,
  #                              tab_child$mass_cut_datzen,
  #                              sep = "/")
 
 
  dat_tree = tab_child
  # names(dat_tree)
  
# paste var name into var val ---------------------------------------------

  
  list_paste_var_in2_val = lapply(names(dat_tree[-ncol(dat_tree)]),
         FUN=function(x){
           # x = names(dat_tree)[[1]]
           paste0(gsub(x,
                       pattern="cut_datzen",
                       replacement=""),unlist(dat_tree[x]))
           
           })
  
  cbinded_var_in2_val = do.call(cbind,list_paste_var_in2_val)
  
  dat_tree_var_in_val = cbind(cbinded_var_in2_val,dat_tree[ncol(dat_tree)])
  names(dat_tree_var_in_val) = names(dat_tree)
  
  require(data.tree)
  
  # dat_tree$pathString = paste("all",
  #                             unlist(tidyr::unite(dat_tree,terms_roll_i,sep="/")),
  #                             sep="/")
  # # dat_tree$pathString
  # dat_tree = as.Node(dat_tree)
  
  dat_tree_var_in_val$pathString = paste("all",
                              unlist(tidyr::unite(dat_tree_var_in_val,
                                                  terms_roll_i,sep="/")),
                              sep="/")
 
  dat_tree = as.Node(dat_tree_var_in_val)
  
  
  # print(dat_tree)
  # starting with last child n's, get ns of all ancestors
  
  dat_tree$Do(function(node) node$n_tree <- Aggregate(node,
                                                      attribute = "n",
                                                      aggFun = sum), 
              traversal = "post-order")
  
  # print(dat_tree, "n_tree", limit = Inf)
  
  list_out = list(list_tab_count=list_tab_count,
                  tree_print=print(dat_tree, "n_tree", limit = 200))
  
  # str(list_out)
  # list_out$tree_print
  
  return(list_out)
}

names(starwars)
test = tree_tab(1 ~ gender + eye_color + skin_color +
                  mass + height,starwars)
# View(test)

test$list_tab_count[[1]]
test$list_tab_count[[1]] %>% tally(nn)  # removed NAs
test$list_tab_count[[5]]

test$list_tab_count[[5]] %>% tally(n)  # counted NAs
nrow(starwars)

test$tree_print
