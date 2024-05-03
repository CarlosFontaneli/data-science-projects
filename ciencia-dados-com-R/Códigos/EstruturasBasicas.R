library(tidyverse)

str <- "essa é uma string"
str
"Hello World!" # string são executáveis

a <- 10
b <- 3
a < b
a > b
(a == b) == 0

## MANIPULAÇÃO DE STRINGS

str_length(str)
length(str) # tam de elementos de um vetor
v <- c("anderson", "chaves", "carniel")

# aqui ele contará o número de caracteres de
# cada string dentro de v
str_length(v) ## [1] 8 6 7
# aqui ele retornará o número de elementos
# dentro do vetor v
length(v) ## [1] 3

str_to_upper(v) ## [1] "ANDERSON" "CHAVES"
str_to_lower(v) ## [1] "anderson" "chaves"
str_to_title(v) ## [1] "Anderson" "Chaves"

strings <- c(
  "palavra sem espaço no começo ou fim",
  "
opa vários espaços no começo",
  "aqui     o usuário deixou muitos espaços no fim
", "outro exemplo "
)
# remove espaços do começo e fim
str_trim(strings)
col <- c(
  "01-Solteiro", "02-Casado",
  "03-Divorciado", "04-Viúvo"
)

str_sub(col, start = 4, end = 5)
str_sub(col, start = 4)
str_sub(col, end = 2)

df <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv",
  col_names = c("Data", "Familia", "Denominação", "Quantidade")
)
moedas_comemorativas <- filter(df, str_detect(
  str_to_lower(Familia),
  "comemorativas"
))
view(moedas_comemorativas)


col <- c("01-Solteiro", "02-Casado", "03-Divorciado", "04-Viúvo")
# vamos trocar o 0 por "Opção - ":
col <- str_replace(col, "0", "Opção -")
col