a <- 2
b <- 8
c <- 3
print(a + b + c)

# Baskara
x1 <- (-b - sqrt(b^2 - 4 * a * c)) / (2 * a)
x2 <- (-b + sqrt(b^2 - 4 * a * c)) / (2 * a)
print(paste0("O valor de x1 é ", x1, " e o valor de x2 é ", x2))

# Numeric: este tipo de dado pode assumir dois sub tipos - integer e double. Alguns exemplos:
y <- 10
is.numeric(y)
## [1] TRUE
is.double(y)
## [1] TRUE
is.integer(y)
## [1] FALSE
class(y)
## [1] "numeric"
y <- 10L # Para “forçar” o tipo inteiro, deve-se colocar a letra L após o valor indicado, tal como:
is.numeric(y)
## [1] TRUE
is.double(y)
## [1] FALSE
is.integer(y)
## [1] TRUE
class(y)
## [1] "integer"


# Character (também conhecido como Nominal): este tipo de dado manipula cadeias de
# caracteres (conhecidas como strings). P
nome <- "anderson"
is.character(nome)
## [1] TRUE
class(nome)
## [1] "character"


# Date: este tipo de dado armazena datas (possivelmente com hora).
# Para criar um objeto deste tipo de dado, usamos
# as funções as.Date() e as.POSIXct , informando a data no formato ISO 8601
data <- "2020-05-09"
class(data)
## [1] "character"
data <- as.Date(data)
class(data)
## [1] "Date"
data_com_hora <- as.POSIXct("2020-05-09 09:00")
data_com_hora
## [1] "2020-05-09 09:00:00 -03"


# Vetores e listas
x <- c(1, 2, 4, 5, 6, 10)
x
## [1] 1 2 4 5 6 10
coisas <- c("casa", "carro", "televisão")
coisas
## [1] "casa"
"carro"
"televisão"
l <- list("casa", "carro", 1:5, x)
l
## [[1]]
## [1] "casa"
##
## [[2]]
## [1] "carro"
##
## [[3]]
## [1] 1 2 3 4 5
##
## [[4]]
## [1] 1 2 4 5 6 10
nl <- list(nome = "casa", tipo = "comercial", valores = 1:5, elementos = c("cozinha", "qu
arto", "sala"))
nl
## $nome
## [1] "casa"
##
## $tipo
## [1] "comercial"
##
## $valores
## [1] 1 2 3 4 5
##
## $elementos
## [1] "cozinha" "quarto" "sala"
typeof(l)
## [1] "list"
length(l)
## [1] 4
typeof(x)
## [1] "double"
length(x)
## [1] 6

# vários operadores podem ser usados sobre vetores
x <- c(25, 2, 5, 8, 9)
x * 2
y <- c(3, 5, 6, 1, 0)
z <- c(45, -9, 2, 4, 5)
x + y
## [1] 28 7 11 9 9
x - y
## [1] 22 -3 -1 7 9
x^y + 1


# Operadores lógicos
v <- c(10, 3, 2.5, 9, 11, 245, 3, 14, 56, 1, 2, 0)
# vamos "marcar" as posições dos números pares (círculo da esquerda) e
# que são maiores que 6 (círculo da direita)
v %% 2 == 0 & v > 6
v_2 <- v[v %% 2 == 0 & v > 6]
v_2 ## [1] 10 14 56

seq()
2 == 2
?sd()