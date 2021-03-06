#an�lise de palavras

install.packages('NLP')
install.packages('tm')
install.packages('wordcloud2')

library(NLP)
library(tm)
library(wordcloud2)

getSources()
getReaders()

redac<- VCorpus(DirSource("C:/Users/baixi/OneDrive/github/Woldcloud/min_text/textos/", encoding="UTF-8"),readerControl = list(reader=readPlain,language='por') )
inspect(redac)

stopwords('portuguese')

#pre-processamento
redac<- tm_map(redac, removeWords,stopwords('portuguese')) # palavras relativamente desnecess�rias descartadas
redac<- tm_map(redac, stripWhitespace) # remo��o de espa�os
redac<- tm_map(redac, removePunctuation) # remo��o da pontua��o
redac<- tm_map(redac, removeNumbers) #remo��o de n�meros
redac<- tm_map(redac, content_transformer(tolower)) #transforma��o de todos as letras em min�sculas
doc_mtz<- TermDocumentMatrix(redac) #Constr�i ou for�a uma matriz de documento 
mtz<- as.matrix(doc_mtz) #transforma��o em matriz para melhorar averigua��o
View(mtz) #vizualiza��o

org<- sort(rowSums(mtz), decreasing = TRUE) #Objeto 'org' � criado para vizualiza��o em  ordem decrescente 
df<- data.frame(word = names(org),freq=org) #dataframe para vizualiza��o  

head (df,10) # visualiza��o das 10 palavras mais frequentes
set.seed(300)

wordcloud2(df, backgroundColor = '#ffdfff') #elabora��o da nuvem de palavras

