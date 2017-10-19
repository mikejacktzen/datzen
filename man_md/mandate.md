# `mandate`: The mandate() function enforces a data.frame to follow a schema

## Description


 The mandate() function converts each column of the supplied data.frame to the type listed in the supplied schema.
 If the schema specs that data.frame column j should be numeric, then 'as.numeric(df[,j])' will be the result.


## Usage

```r
mandate(df, schema_df)
```


## Arguments

Argument      |Description
------------- |----------------
```df```     |     a data.frame of data whose column types and names will be mandated against a schema
```schema_df```     |     a data.frame used as a schema to mandate each column in the df argument

## Details


 the schema_df argument should be the output of [`scheme`](scheme.html) .


## Value


 an output data.frame similar to the input 'df' but the column types of 'df' may have been converted according to 'schema_df'


## Seealso


 [`scheme`](scheme.html) 


## Examples

```r 
 iris2=cbind(iris,Species_chr=as.character(iris$Species))
 save_df_schema(x=iris2,outdir='~/projects/datzen/tests/')
 schema_in = jsonlite::read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)
 
 library(dplyr)
 
 mandate(iris2,schema_df = schema_in) %>% str
 
 iris3 = iris2 %>% mutate_all(.funs=funs(as.character))
 iris3 %>% str
 
 mandate(iris3,schema_df = schema_in) %>% str
 
 ``` 

