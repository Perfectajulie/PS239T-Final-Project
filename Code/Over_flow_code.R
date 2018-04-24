
NYT.key <-"cd4fc0f238e04222bf79856b243299d5" #from hotmail 
#"5756cf3d791442b490c1972c80d2c5a8" #from berkeley

base.url<-"https://api.nytimes.com/svc/search/v2/articlesearch"
response.format<-".json"

COP.search.term<-"community policing"
COP.filter.query<-"body:\"community policing\"" # Specify and encode filters (fq)

print(COP.filter.query)
cat(COP.filter.query)

# URL-encode the search and its filters
COP.search.term<-URLencode(URL = COP.search.term, reserved = TRUE)
COP.filter.query<-URLencode(URL = COP.filter.query, reserved = TRUE)
print(COP.search.term)
print(COP.filter.query)

# Paste components together to create URL for get request
get.COP.request<-paste0(base.url, response.format, "?", "q=", COP.search.term, "&fq=", COP.filter.query, "&api-key=", NYT.key)
print(get.COP.request)

# Send the GET request using httr package
NYT.COP.response<-httr::GET(url = get.COP.request)
print(NYT.COP.response)

# Inspect the content of the response, parsing the result as text
NYT.COP.response <-httr::content(x = NYT.COP.response, as = "text")
substr(x = NYT.COP.response, start = 1, stop = 1000)

# Convert JSON response to a dataframe
COP.response.df<-jsonlite::fromJSON(txt = NYT.COP.response, simplifyDataFrame = TRUE, flatten = TRUE)

# Inspect the dataframe
str(COP.response.df, max.level = 3)

# Get number of hits
print(COP.response.df$response$meta$hits)


# Function for API  request 

# Write a function to create get requests
COP.api<-function(COP.search.terms=NULL, begin.date=NULL, end.date=NULL, page=NULL,
                  base.url="http://api.nytimes.com/svc/search/v2/articlesearch",
                  response.format=".json",
                  key="13ff759582b04c6d8050e178b2dc8d0e"){
  
  # Combine parameters
  params<-list(
    c("q", COP.search.terms),
    c("begin_date", begin.date),
    c("end_date", end.date),
    c("page", page)
  )
  params<-params[sapply(X = params, length)>1]
  params<-sapply(X = params, FUN = paste0, collapse="=")
  params<-paste0(params, collapse="&")
  
  # URL encode query portion
  query<-URLencode(URL = params, reserved = FALSE)
  
  # Combine with base url and other options
  get.request<-paste0(base.url, response.format, "?", query, "&api-key=", key)
  
  # Send GET request
  response<-httr::GET(url = get.request)
  
  # Parse response to JSON
  response<-httr::content(response, "text")  
  response<-jsonlite::fromJSON(txt = response, simplifyDataFrame = T, flatten = T)
  
  return(response)
}




# Create total hits variable 
total_hits <- COP.response.df$response$meta$hits
#1015



## Makes Request, Stores Articles as Data Frame 


# Geoff, force fewer than 1000+ pages here
#total_pages<-total_hits/10
# to be safe 
# total_pages<-71
# Get all articles   

COP.articles<-sapply(X =0:total_hits, FUN = function(page){
  #cat(page, "")
  response<-tryCatch(expr = {
    r<-COP.api(COP.search.terms = "community policing", begin.date = 19940101, end.date = 20180301, page = page)
    r$response$docs
  }, error=function(e) {
    print(e)
    return(NULL)
  }
  )
  return(response)
})

# Combine list of dataframes
COP.articles<-COP.articles[!sapply(X = COP.articles, FUN = is.null)]
COP.articles<-dplyr::bind_rows(COP.articles)



just_one <- unlist(strsplit(all_content, split='Advertisement', fixed=TRUE))[2]
no_ads_all <- sapply(strsplit(all_content, split='Advertisement', fixed=TRUE), function(x) (x[2]))

# Remove unwanted text like "Advertisementc"
 no_adtext  <- sapply(X = 1:210) FUN = function(row_index) {
     remove_advert <- unlist(strsplit(all_content[row_index], split='Advertisement', fixed=TRUE))[2];
}

list1 <-  NYT[[1]]
list1 <- data.frame(unlist(strsplit(list1," ")))
list1[] <- lapply(list1, as.character)

list2 <- NYT[[7]]
list2 <- data.frame(unlist(strsplit(list2," ")))
list2[] <- lapply(list2, as.character)

list3 <- NYT[[16]]
list3 <- data.frame(unlist(strsplit(list3," ")))
list3[] <- lapply(list3, as.character)

list4 <- NYT[[19]]
list4 <- data.frame(unlist(strsplit(list4," ")))
list4[] <- lapply(list4, as.character)

list5 <- NYT[[28]]
list5 <- data.frame(unlist(strsplit(list5," ")))
list5[] <- lapply(list5, as.character)

list6 <- NYT[[36]]
list6 <- data.frame(unlist(strsplit(list6," ")))
list6[] <- lapply(list6, as.character)

list7 <- NYT[[40]]
list7 <- data.frame(unlist(strsplit(list7," ")))
list7[] <- lapply(list7, as.character)

list8 <- NYT[[49]]
list8 <- data.frame(unlist(strsplit(list8," ")))
list8[] <- lapply(list8, as.character)

list9 <- NYT[[62]] 
list9 <- data.frame(unlist(strsplit(list9," ")))
list9[] <- lapply(list9, as.character)

list10 <- NYT[[68]]
list10 <- data.frame(unlist(strsplit(list10," ")))
list10[] <- lapply(list10, as.character)

all_nyt_urls <- dplyr::bind_rows(list1, list2, list3, list4, list5, list6, list7, list8, list9, list10)
#all <- full_join(list1, list2, list3, list4, list5, list6, list7, list8, list9, list10, by = "x1")
#all_nyt_urls <- rbind(list1, list2, list3, list4, list5, list6, list7, list8, list9, list10)
#all <- merge(merge(list1, list2, list3, list4, list5, list6, list7, list8, list9, list10, by=0, all=T))
#all_nyt_urls <- join_all(list(list1, list2, list3, list4, list5, list6, list7, list8, list9, list10))

# From Text Analysis 
 # How many terms?
freq <- colSums(m)
length(freq)

# order
ord <- order(freq)

# Least frequent terms
freq[head(ord)]

# most frequent
freq[tail(ord)]

# frequency of frenquencies
head(table(freq),15)
tail(table(freq),15)

# plot
plot(table(freq))
