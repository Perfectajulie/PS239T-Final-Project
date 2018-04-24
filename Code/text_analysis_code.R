# Structural Topic Modeling 

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


# Load Data 
STM.df <- read.csv('NYT_corpus.csv', stringsAsFactors = FALSE)


# Pre-process
STM.COP <-textProcessor(documents=STM.df$text, metadata=STM.df)
meta<-STM.COP$meta
vocab<-STM.COP$vocab
docs<-STM.COP$documents
out <- prepDocuments(docs, vocab, meta, lower.thresh=10)
docs<-out$documents
vocab<-out$vocab
meta <-out$meta

# Model without predictor 
COP.stm <- stm(out$documents, # the documents
               out$vocab, # the words
               K = 4, # 10 topics
               max.em.its = 50, # set to run for a maximum of 50 EM iterations
               data = out$meta, # all the variables (we're not actually including any predictors in this model, though)
               init.type = "Spectral")  


#Create Topic Model Plots 
labelTopics(COP.stm)
plot.STM(COP.stm, type = "labels") 
plot.STM(COP.stm, type = "summary") 

#Check correlations between topics 
round(topicCorr(COP.stm)$cor, 2)


