library(tidyverse)
library(rpart) # para a construção da árvore de decisão
library(rpart.plot) # para a visualização gráfico da árvore
library(factoextra)

mpg
summary(mpg)
count(mpg, class)

# Funcao para dividir conjunto de dados em treino e teste
prepare_hold_out <- function(tbl, training_perc) {
  # misturando as observações
  tbl_mixed <- tbl[sample(1:nrow(tbl)), ]
  nrow <- nrow(tbl_mixed)
  
  # de acordo com %, separamos entre treino e teste
  nrow_train <- ceiling(training_perc * nrow)
  data_trn <- tbl_mixed[1:nrow_train, ]
  data_tst <- tbl_mixed[(1+nrow_train):(nrow), ]
  
  # retorna como uma lista nomeda
  list(training = data_trn, test = data_tst)
}

set.seed(753)
mpg_split <- prepare_hold_out(mpg, 0.8)

# treino 
mpg_split$training

# test
mpg_split$test

# construímos a árvore de decisão usando o cojunto de treino
tree <- rpart(class ~ displ + cyl + trans + cty + hwy, 
              data = mpg_split$training)

# visualização gráfica da árvore
rpart.plot(tree)


# predições do modelo
classes_preditas <- predict(tree, mpg_split$test, type = "class")

# quantidade de elementos de cada classe em cada vetor
table(mpg_split$test$class)
table(classes_preditas)

# matriz de confusão
confusion_matrix <- table(mpg_split$test$class, classes_preditas)
confusion_matrix


# K-means
mpg_numeric <- select(mpg, displ, cyl, cty, hwy)
mpg_numeric

# calculo do k idela, wss = within sum of square
fviz_nbclust(mpg_numeric, FUNcluster = kmeans, method = 'wss')

kmeans_clust <- kmeans(mpg_numeric, 4, nstart = 25)
print(kmeans_clust)

# informação de qual grupo cada observação pertence
mpg$cluster <- kmeans_clust$cluster
mpg


# representação gráfica dos clusters
fviz_cluster(kmeans_clust, mpg_numeric)
