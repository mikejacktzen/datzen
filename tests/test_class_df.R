library(datzen)

?class_df_from_term

str(iris)

model  <- lm(data = iris,Sepal.Length ~ Species + as.numeric(Species) +
               Species:Sepal.Width + as.factor(Sepal.Width)+
               as.factor(Sepal.Width)*as.factor(Petal.Length)+
               as.numeric(Species)*as.factor(Petal.Length))

terms(model)


# df col classes pre 'in-formula' transforms
class_df_from_term(model,class_post_formula = FALSE)

# df col classes post 'in-formula' transforms
class_df_from_term(model,class_post_formula = TRUE)
