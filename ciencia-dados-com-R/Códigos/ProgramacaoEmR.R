library(tidyverse)

df <- tibble(
  a = rnorm(50),
  b = rnorm(50),
  c = rnorm(50),
  d = rnorm(50),
)

df$a <- (df$a - min(df$a, na.rm = TRUE)) / (max(df$a, na.rm = TRUE) - min(df$a, na.rm = TRUE))
df$b <- (df$b - min(df$b, na.rm = TRUE)) / (max(df$b, na.rm = TRUE) - min(df$b, na.rm = TRUE))
df$c <- (df$c - min(df$c, na.rm = TRUE)) / (max(df$c, na.rm = TRUE) - min(df$c, na.rm = TRUE))
df$d <- (df$d - min(df$d, na.rm = TRUE)) / (max(df$d, na.rm = TRUE) - min(df$d, na.rm = TRUE))

normaliza_01 <- function(v) {
  # fazemos as validações especificadas
  if (is.null(v) || length(v) == 0) {
    stop("O parâmetro é nulo ou possui tamanho 0.") # nossa mensagem de erro
  }
  # existe algum NA dentro de v?
  if (any(is.na(v))) {
    warning("Existe NA em v. Todos os NA serão ignorados no cálculo da normalização.")
  }
  aux <- (v - min(v, na.rm = TRUE)) / (max(v, na.rm = TRUE) - min(v, na.rm = TRUE)) # usam
  # os uma variável auxiliar para guardar o resultado
  aux # retornamos o resultado
}

df$a <- normaliza_01(df$a)
df$b <- normaliza_01(df$b)
df$c <- normaliza_01(df$c)
df$d <- normaliza_01(df$d)

df