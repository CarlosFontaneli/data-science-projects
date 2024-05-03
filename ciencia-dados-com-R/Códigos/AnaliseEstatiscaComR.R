library(tidyverse)

circulacao_dinheiro <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv",
  col_names = c("Data", "Familia", "Denominação", "Quantidade")
)

x <- c(23, 46, 3, 4, 57, 4, 2, 35, 23, 46, 2, 2, 3)
### medidas de tendência central
mean(x, na.rm = TRUE)
## [1] 19.23077
median(x, na.ram = TRUE)
## [1] 4
# não existe suporte nativo para calcular a moda no R, então precisamos criar uma função p
# rópria para isso
mode <- function(x) {
  ux <- unique(x) # extrai os valores únicos
  tab <- tabulate(match(x, ux)) # recomenda-se a busca para entender a funcionalidade dess
  # as funções
  ux[tab == max(tab)] # captura os valores com maior frequência, note que pode ser mais que um
}
mode(x)
## [1] 2
# vamos também definir uma função para o midrange
midrange <- function(x) {
  (max(x, na.rm = TRUE) + min(x, na.rm = TRUE)) / 2
}
midrange(x)
## [1] 29.5
### medidas de dispersão
# variância
var(x, na.rm = TRUE)
## [1] 418.1923
# desvio padrão
sd(x, na.rm = TRUE)
## [1] 20.44975
sqrt(var(x, na.rm = TRUE))
## [1] 20.44975
# no R, por padrão, a função mad calcula o median absolute deviation!
mad(x, na.rm = TRUE)
## [1] 2.9652
# podemos trocar a medida de tendência central usada para calcular nosso MAD
mad(x, center = mean(x), na.rm = TRUE)
## [1] 24.06374
## o cálculo dessas medidas pode ser bastante comum em nossos problemas e podemos definir
# uma função que retorna uma lista desses valores
## por exemplo, uma função que retorna algumas medidas de tendência central como uma list
# a nomeada
calcular_medidas_tendencia_central <- function(x, na.rm = FALSE) {
  avg <- mean(x, na.rm = na.rm)
  med <- median(x, na.rm = na.rm)
  mod <- mode(x)
  mr <- midrange(x)
  # aqui é retorno da função por ser a última instrução executada
  list(mean = avg, median = med, mode = mod, midrange = mr)
}
# usando nossa função nova
mtc <- calcular_medidas_tendencia_central(x, na.rm = TRUE)
mtc_cd <- calcular_medidas_tendencia_central(circulacao_dinheiro$Quantidade, na.rm = TRUE)
mtc
## $mean
## [1] 19.23077
##
## $median
## [1] 4
##
## $mode
## [1] 2
##
## $midrange
## [1] 29.5
mtc_cd
## $mean
## [1] 317692877
##
## $median
## [1] 19039
##
## $mode
## [1] 5000
##
## $midrange
## [1] 3079279181