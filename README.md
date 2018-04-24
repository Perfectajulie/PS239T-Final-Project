**Short Description**

This project uses the New York Times archive API to collect 700+ web urls related to "community policing." Using R, the contents of these urls are then scraped, cleaned, and the text is analyzed.

**Dependencies**

R, version 3.4.2  

**Data**

nyt_urls: first attempt at url scrape and save   
COP.articles.csv: All 714 weburls related to "community policing" from New York times API archive   
All_articles.csv:the content from all NYT articles saved as a csv file   
All_content: the contenct from all scraped articles as a text file   
NYT_corpus.csv: the content of all the NYT articles saved as a single csv corpus for text editing  
Doc_Term_Matrix.csv: the document term matrix of all articles, cleaned, for text editing saved as a csv  

**Code**  

PS239 T Final.rmd: Collects data from New York Times API and exports data to the file COP.articles.csv. Scrapes the content of web urls from COP.articles.csv, saves at All_articles.csv. Loads and cleans raw data, saves as NYT_corpus for text analysis. Conducts descriptive analysis of the data, producing the tables and visualizations found in the Visualizations directory.

**Visualizations**

First Draft Word Cloud.pdf: first attempt of the word cloud, using only scraped and cleaned data from 220 NYT web urls. This data was stemmed. Future word cloud data was not stemmed  
Final_Dark_Blud_Cloud: Final version of the word cloud, solid dark blud color  
Final_Multi_Cloud: Final version of word cloud, with most frequent words centralized and in red; less frequent words are on the periphery and in blue   
20_most: bar chart of the 20 most frequent words  
Top_3_Topics_Models: top words for three models  
4_Topic_Models:top words for four models  
Top_5: top words for five models  
Top_5_summary: summary plot of the top five word models  
Top10_summary: summary plot of the top 10 word models  
