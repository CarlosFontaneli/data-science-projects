library(ggplot2) # somente usado na visualização dos dados

# compreendendo as colunas do conjunto de dados a ser usado
summary(cars)

ggplot(data = cars) +
  geom_point(aes(x = speed, y = dist))

ggplot(data = cars, aes(x = speed, y = dist)) +
  geom_point() +
  geom_smooth()

# Coeficiente de Pearson
cor(cars$speed, cars$dist)

# Calculo semi-manual do Coeficiente de Pearson
cov(cars$speed, cars$dist) / (sd(cars$speed) * sd(cars$dist))

# MODELOS DE REGRESSAO LINEAR
linear_model <- lm(dist ~ speed, cars)

# formula matematica construida pelo modelo
print(linear_model) # dist = −17.579 + 3.932 ∗ speed

# Analise de significancia estatistica
summary(linear_model)

# Predicao de valores de dist baseada no modelo
predict(linear_model, data.frame(speed = c(21, 5, 9)))


## AVALIANDO O DESEMPENHO DE MODELOS DE REGRESSAO

# holdout validation
# divisao em conjunto de treino e de teste
prepare_hold_out <- function(tbl, training_perc) {
  # misturando as observacoes
  tbl_mixed <- tbl[sample(1:nrow(tbl)), ]
  nrow <- nrow(tbl_mixed)

  nrow_train <- ceiling(training_perc * nrow)
  data_trn <- tbl_mixed[1:nrow_train, ]
  data_tst <- tbl_mixed[(1 + nrow_train):(nrow), ]

  # retorna como uma lista nomeada
  list(training = data_trn, test = data_tst)
}

# vamos definir uma função que calcula as medidas de acurácia,
# retornando-as como uma lista nomeada
accuracy_measures <- function(predicted, observed) {
  e <- observed - predicted
  mae <- lapply(e, mean, na.rm = TRUE)
  mse <- lapply(e^2, mean, na.rm = TRUE)
  # rmse <- lapply(mse, sqrt, na.rm = TRUE)
  # mae <- mean(abs(e), na.rm = TRUE) # mean absolute error
  # mse <- mean(e^2, na.rm = TRUE) # mean squared error
  rmse <- sqrt(mse) # root mean squared error

  rss <- sum(e^2) # residual sum of squares
  tss <- sum((observed - mean(observed))^2) # total sum of squares
  r2 <- 1 - rss / tss

  pe <- e / observed * 100
  mape <- mean(abs(pe), na.rm = TRUE) # mean absolute percentage error

  list(MAE = mae, RMSE = rmse, MAPE = mape, R2 = r2)
}

set.seed(12345)

cars_mixed <- prepare_hold_out(cars, 0.8)

cars_mixed$training
cars_mixed$test

# construimos o modelo de regressao linear usando o conjunto de treino
linear_model <- lm(dist ~ speed, cars_mixed$training)

# predizemos os valores da variavel de interesse usando o modelo
# para isso, usamos o conjunto de treino
valores_preditos <- predict(linear_model, cars_mixed$test)

# agora avaliamos o desempenho do modelo de acordo com as medidas de acurácia
accuracy_measures(valores_preditos, cars_mixed$test[, 2])
