  #Cleaning the workspace
  rm(list=ls())
  graphics.off()
  library(tm) #Text dataminin
  library(ggplot2)
  library(class)
  library(FactoMineR)
  
  source("C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework3\\ml_kmeans.R")
  set.seed(172)
  # We will use K means to depicts the centroids, as we already worked with it a lot
  # Same as k_mean, with a corpus instead of dataset, and a minimum frequence for a word to be used
  ml_k_means_text <- function(corpus_path, freq_word_min, K=3, print_all=FALSE, f_damping=FALSE)
  {
    # Loading & preparing the data to be used
    my_corpus <- file.path(corpus_path)
    dir(my_corpus)
    docs <- VCorpus(DirSource(my_corpus)) #Get
    if(print_all){print(summary(docs))}
    docs <- tm_map(docs, removePunctuation)   #remove punctuation symbols
    docs <- tm_map(docs, removeNumbers)   #remove numbers
    docs <- tm_map(docs, tolower)   #remove capitalization - to lowcase
    docs <- tm_map(docs, removeWords, c("the", "and", stopwords("english")))   #remove common words such as "a, and, also, the"
    #docs <- tm_map(docs, removeWords, c("tennis", "football"))   #remove particular words
    docs <- tm_map(docs, stripWhitespace)  #remove whitespaces from previous eliminations
    docs <- tm_map(docs, PlainTextDocument) # As text
    
    dtm  <- DocumentTermMatrix(docs)
    dtm_sparse <- removeSparseTerms(dtm, 0.15)
    
    length_corpus <- length(docs)
    if(print_all){cat("Nb of docs : ", length_corpus, "\n")}
    
    frequency <- colSums(as.matrix(dtm))
    word_f <- data.frame(names(frequency), frequency)
    colnames(word_f) <- c("Words", "Frequency")
    
    #We select the word that have sufficient frequency (otherwise there is too much words)
    common_words <- word_f[word_f$Frequency > freq_word_min,]
    
    if(print_all) {cat("Number of common words in the corpus : ", nrow(common_words), "\n")}
    #Print the most common words
    p <- ggplot(common_words, aes(x = reorder(Words, -Frequency), y = Frequency)) +
      geom_bar(stat = "identity") + xlab("Most common words") +
      theme(axis.text.x=element_text(angle=45, hjust=1, face="bold"))
    print(p)
    
    #Using inverse doc freq and term freq to create a dataframe (onyl common words)
    freq_matrix <- matrix(, nrow = nrow(common_words), ncol = length_corpus)
    rownames(freq_matrix)<-rownames(common_words) #To keep the corresponding word
    for(i in seq(nrow(common_words)))
    {
      word <- common_words[i,1]
      for(doc in seq(length_corpus))
      {
        f <- as.matrix(as.matrix(dtm)[doc,]) #frequencies for this documetn
        word_freq <- data.frame(Words=names(f[,1]), Freq=f)
        #Term frequency
        #Get the frequency and 
        #log((1+ ) instead of log() otherwise inf values
        f_term <- log(1+word_freq[which(word_freq==word),]$Freq)
        #Getting the number of time it appears in the doc
        tmp_dtm <- DocumentTermMatrix(docs, control=list(dictionary = c(word)))
        search <- data.frame(docs=tmp_dtm$dimnames$Docs, as.matrix(tmp_dtm), row.names = NULL)
        f_inv <- log(1+length_corpus / nrow(search[search[2] != 0,]))
        freq_matrix[i, doc] <- f_term * f_inv
      }
    }
    numeric_f_matrix <-matrix(as.numeric(freq_matrix), ncol=ncol(freq_matrix), nrow=nrow(freq_matrix))
    rownames(numeric_f_matrix) <- rownames(freq_matrix)
    d <- dist(t(dtm_sparse), method="euclidian")
    f_pca <- PCA(as.matrix(numeric_f_matrix))
    
    classified <- ml_k_means(numeric_f_matrix, K=2)
    #We use 6 and 7 based on the PCA
    class2d <- cbind(classified[,1], classified[,2], classified[, ncol(classified)])
    plot(class2d[,1:2], col=class2d[,3], pch=20, main="Words clustering of our corpus")
    
    #decision boundary
    #Helping data
    
    max_value <- as.integer(max(class2d[,1:2])) +1
    min_value <- as.integer(min(class2d[,1:2])) -1
    resol <- 15
    win_size <- (-max_value*resol):(max_value*resol)/resol
    grid_boundary <- expand.grid(x = win_size, y=-win_size )
    labels <- class2d[,3]
    labels.grid <- knn(as.data.frame(class2d[,1:2]), grid_boundary, labels, k=7, prob=TRUE) 
    labels.grid <- as.integer(labels.grid) + 1L
    #Boundary
    my_boundary <- matrix(as.integer(labels.grid), nrow=length(win_size))
    for(row in 2:(length(win_size)-1))
    {
      for(col in 2:(length(win_size)-1))
      {
        around_vect <- c(my_boundary[row, col], my_boundary[row - 1, col], my_boundary[row + 1, col], my_boundary[row, col - 1], my_boundary[row, col + 1])
        #For each if there is too much diff with around its boundary
        if (var(around_vect) != 0) {
          labels.grid[row + col * length(win_size)] = 1
        }
      }
    }
    dev.new()
    plot.new()
    plot.window(xlim= c(min_value, max_value), ylim=c(min_value, max_value), xlab="Var 1", ylab="Var 2")
    points(grid_boundary, col=labels.grid+2, pch=3, cex=1, main="Decision boundary",xlim= c(min_value, max_value), ylim=c(min_value, max_value))
    points(class2d[,1:2], col=class2d[,3], pch=20,xlim= c(min_value, max_value), ylim=c(min_value, max_value))
    return(classified)
  }
  
  corpus_text_path <- "C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework3\\data\\ww2_data"
  #corpus_text_path <- "C:\\Users\\maeli\\Documents\\INSA\\4A\\Taltech\\data_mining\\Homework3\\data\\tmp"
  
  
  tmp <- ml_k_means_text(corpus_text_path, 4, print_all = TRUE)
print("Done")