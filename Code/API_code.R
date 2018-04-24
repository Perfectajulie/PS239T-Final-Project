# Load Libraries & Set Working Directory 

library(tidyr)
library(tidyverse)
library(ggplot2)
library(dplyr)
library(plyr)
library(rvest)
library(splitstackshape)

library(stm)
library(readxl)
library(RJSONIO)
library (RCurl)

library(RTextTools)
library(data.table)
library(qdap)
library(qdapDictionaries)
library(tm)
library(SnowballC)
library(wordcloud)
library(wordcloud2)
library(RColorBrewer)

setwd("~/PS239T-Final-Project")


# Create API Function
# Enter parameters 
apikey <- "cd4fc0f238e04222bf79856b243299d5" #hotmail email
#apikey <- "5756cf3d791442b490c1972c80d2c5a8" # uc berkeley email 

base_url<-"https://api.nytimes.com/svc/search/v2/articlesearch.json"

query<-"community policing"

# Send GET request and save the request in a dataframe 
get_article <- function(page){
  r <- httr::GET(base_url, 
                 query=list(q="community policing",
                            "api-key"=apikey,
                            "fq"="body:\"community policing\"",
                            "begin_date"=19940101,
                            "end_date"=20161231,
                            "page"=page,
                            "sort"="oldest"))
  json <- httr::content(r, as = "text") 
  data <- jsonlite::fromJSON(json, simplifyDataFrame = TRUE, flatten=T)
  return(data$response$docs$web_url)
}


# Get urls from API call, save in NYT 

NYT <- list()
for (i in 0:71){
  nytSearch <- get_article(i)
  message("Retrieving page ", i)
  NYT[[i + 1]] <- nytSearch
  Sys.sleep(3)
}

#Convert NYT from list of NYT urls to a data frame 

NYT_to_COP <- do.call(rbind, lapply(NYT, data.frame, stringsAsFactors=FALSE))
write.csv(NYT_to_COP,"COP.articles.csv")


