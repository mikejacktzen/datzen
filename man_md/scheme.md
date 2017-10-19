# `scheme`: The scheme() function creates a simple schema for a data.frame

## Description


 The schema should describe global characteristics of the data.frame (eg the number of rows and columns)
 and local characteristics of the data.frame (eg each column name and type).
 The resulting schema is saved as an external json file that complements the csv version of data.frame x.


## Usage

```r
scheme(x, outdir = NULL, pattern_null = "NULL", pattern_sep_row = "\\n",
  pattern_sep_col = ",", pattern_quote_string = "\"",
  pattern_escape_quote = "\\", description_col = NA, ...)
```


## Arguments

Argument      |Description
------------- |----------------
```x```     |     a data.frame whose properties will be schemed() to a schema.
```outdir```     |     a character string designating the output filepath (default NULL).
```pattern_null```     |     a character string that contains the pattern for NULL values (default "NULL").
```pattern_sep_row```     |     a character string that contains the pattern for seperating rows (default "\n").
```pattern_sep_col```     |     a character string that contains the pattern for seperating columns (default ",").
```pattern_quote_string```     |     a character string that contains the pattern for quoting character values (default '"').
```pattern_escape_quote```     |     a character string that contains the pattern for escaping quotes (default "\").
```description_col```     |     a named character vector whose name elements are the column names of data.frame x and each value element is a brief human-readable description of the column of x (default NA).
```...```     |     optional arguments

## Details


 This assumes the values in data.frame x contain the exhaustive scoped-population values
 NOTE: Does not have to be population, just ensure coverage / support.


## Value


 A nested list with 'schema_global' and 'schema_local' .
 Note if the input argument 'outdir' is not NULL, a physical .json file is written to disk at the specified directory.


## Seealso


 [`mandate`](mandate.html) 


## Examples

```r 
 iris2=cbind(iris,Species_chr=as.character(iris$Species))
 scheme(x=iris2,outdir='~/projects/datzen/tests/')
 jsonlite::read_json('~/projects/datzen/tests/iris2_schema.json',simplifyVector = TRUE)
 ``` 

