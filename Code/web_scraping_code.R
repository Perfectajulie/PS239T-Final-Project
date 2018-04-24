
# Webscraping 

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

#Load data
COP.articles <- read.csv("COP.articles.csv", stringsAsFactors = FALSE)
```
#Create scraping function 

scrape_article_contents<-function(url) {
  
  NYT_archive1 <- read_html(url)
  #NYT_archives <- read_html(COP.articles$web_url)
  
  NYT_art_content <- NYT_archive1 %>% html_nodes(css = "p")
  # alternative code: article_content <- NYT_art_content %>% html_nodes(css = ".story-content")
  #NYT_art_content <- NYT_archive1 %>% html_nodes(xpath = '//*[contains(concat( " ", @class, " " ), concat( " ", "story-content", " " ))]')
  
  # Create empty placeholder for my NYT articles 
  Article_contents <- vector("list", length = length(NYT_archive1))
  
  # Create function to save document names and urls
  for (i in seq_along(NYT_art_content)) {
    docname <- xml_contents(NYT_art_content[i]) %>%
      html_text(trim = TRUE)
    url <- html_attr(NYT_art_content[i], "div p")
    #Article_contents[[i]] <- data_frame(docname = docname, url = url)
    Article_contents[[i]] <- docname
    #Sys.sleep(3)
  }
  
  final_art <-  paste(Article_contents, sep = " ", collapse = "")
  #nyt.review.out<-getURLContent(as.character(COP.articles[1]),curl=getCurlHandle())
  #a2 <- htmlTreeParse(nyt.review.url)
  
  # article_df <- as.character(Article_contents)
  return(final_art)
}

#Test it
example_contents <- scrape_article_contents(COP.articles$web_url[3])

#Get NYT article content using webscraper function

# sapply loop for all articles 
#all_content <- sapply(X = 1:length(COP.articles$web_url), FUN = function(row_index) {
entries_to_fetch<- length(COP.articles$web_url)
all_content <- sapply(X = 1:entries_to_fetch, FUN = function(row_index) {
  result<-tryCatch(expr = {
    # Get the URL form dataframe
    url <- COP.articles$web_url[row_index];
    # Return the scraped contents (as a row in our resulting dataframe)
    return(scrape_article_contents(url))
  },
  error = function(e) {
    # For debugging, why did this row fail
    sprintf("error on row %d", row_index)
    print(e)
    # Return null so we can filter this row out
    return(NULL)
  })
  return(result)
})

all_content

#Transform list with all scraped articles to dataframe 
All_content <- do.call(rbind, lapply(all_content, data.frame, stringsAsFactors=FALSE))

#Save the scraped content as csv 
write.csv(All_content,"All_articles.csv")

