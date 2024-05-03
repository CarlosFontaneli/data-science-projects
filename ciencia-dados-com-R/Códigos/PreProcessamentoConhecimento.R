library(dplyr)

set.seed(7)
starwars[c(4, 5, 52), 'height'] <- round(runif(3, min = -100, -1))

starwars

# Filtro de Hampel, valores fora dessa faixa sao considerados outliers
limite_minimo = median(starwars$height, na.rm = TRUE) - 3 * mad(starwars$height, na.rm = TRUE)
limite_minimo

limite_maximo = median(starwars$height, na.rm = TRUE) + 3 * mad(starwars$height, na.rm = TRUE)
limite_maximo
