#análise de palavras

install.packages('NLP')
install.packages('tm')
install.packages('wordcloud2')

library(NLP)
library(tm)
library(wordcloud2)

getSources()
getReaders()

redac<- VCorpus(DirSource("C:/Users/baixi/OneDrive/github/palavras/textos", encoding="UTF-8"),readerControl = list(reader=readPlain,language='por') )
inspect(redac)

stopwords('portuguese')

#pre-processamento
redac<- tm_map(redac, removeWords,stopwords('portuguese')) # palavras relativamente desnecessárias descartadas
redac<- tm_map(redac, stripWhitespace) # remoção de espaços
redac<- tm_map(redac, removePunctuation) # remoção da pontuação
redac<- tm_map(redac, removeNumbers) #remoção de números
redac<- tm_map(redac, content_transformer(tolower)) #transformação de todos as letras em minúsculas
doc_mtz<- TermDocumentMatrix(redac) #Constrói ou força uma matriz de documento 
mtz<- as.matrix(doc_mtz) #transformação em matriz para melhorar averiguação
View(mtz) #vizualização

org<- sort(rowSums(mtz), decreasing = TRUE) #Objeto 'org' é criado para vizualização em  ordem decrescente 
df<- data.frame(word = names(org),freq=org) #dataframe para vizualização  

head (df,10) # visualização das 10 palavras mais frequentes
set.seed(300)
wordcloud2(df) #elaboração da nuvem de palavras
