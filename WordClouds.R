#Word Clouds in R
#CODE BY JATIN DHALL
#tm = text mining
#wordcloud will create the visualization

#Loading the libraries
library(tm)
library(wordcloud)

dir.create("/resources/data/wordcloud")
download.file("https://ibm.box.com/shared/static/cmid70rpa7xe4ocitcga1bve7r0kqnia.txt",
              destfile = "/resources/data/wordcloud/churchill_speeches.txt", quiet = TRUE)

# Select the directory that our text is located
dirPath <- "/resources/data/wordcloud/"

# Load the data as a corpus(Loads up data from that directory)
speech <- Corpus(DirSource(dirPath))

inspect(speech) # to inspect the content

#DATA CLEANING
# Convert the text to lower case
speech <- tm_map(speech, content_transformer(tolower))

# Remove numbers
speech <- tm_map(speech, removeNumbers)

# Remove english common stopwords
speech <- tm_map(speech, removeWords, stopwords("english"))

# Remove your own stop word
# specify your stopwords as a character vector
speech <- tm_map(speech, removeWords, c("floccinaucinihilipification", "squirrelled")) 

# Remove punctuations
speech <- tm_map(speech, removePunctuation)

# Eliminate extra white spaces
speech <- tm_map(speech, stripWhitespace)

# Create a Term Document Matrix
dtm <- TermDocumentMatrix(speech)

# Matrix transformation
m <- as.matrix(dtm)

#Sort it to show the most frequent words
v <- sort(rowSums(m),decreasing=TRUE)

#transform to a data frame
d <- data.frame(word = names(v),freq=v)
head(d, 10)

#GENERATING A WORD CLOUD
wordcloud(words = d$word, freq = d$freq,min.freq = 1,max.words = 250,colors=brewer.pal(8, "Dark2"),random.order = FALSE)

