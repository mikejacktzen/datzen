
datzen::rmabd()
setwd("~/projects/datzen/")
devtools::load_all()
devtools::document()
roxygen2::roxygenise()



rd2html_all(dir_man_rd = "~/projects/datzen/man/",
            dir_man_html = "~/projects/datzen/man_html/")






# devtools::install_github('mikejacktzen/datzen',force=TRUE)
library(datzen)

?mandate
?scheme
?dictate_outin
?yankovise
?simlm
?clean_name
?match_2_bank
?garble
?iterload
?itersave
?datzen
?class_df_from_term
?rmabd
?theme_zen
?freadss
?logit
?expit
?save_coord_nb
?moran_op

# devtools::use_readme_rmd()
