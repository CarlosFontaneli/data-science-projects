library(tidyverse)
library(datasets)
iris_data <- iris
# criação de um data.frame de 3 colunas
x <- -2:7
y <- rnorm(10) # opa! uma função nova, pesquise o que ela faz
# (intuitivamente, ela gera x números aleatórios usando uma distribuição normal)
quando <- c("Janeiro", "Fevereiro", "Janeiro", "Abril", "Dezembro", "Maio", "Junho", "Jun
ho", "Janeiro", "Agosto")
# definimos um data.frame para armazenar 2 valores referentes a um mês, por exemplo
periodo_xy <- data.frame(x, y, quando)
# repare que o nome das colunas do data.frame são os nomes das nossas variáveis
periodo_xy

# Renomeando colunas
outro_df <- data.frame("coluna1" = x, "coluna2" = y, "periodo" = quando)
outro_df

rownames(periodo_xy)
## [1] "1" "2" "3" "4" "5" "6"  "7" "8" "9" "10"
colnames(periodo_xy)
## [1] "x" "y"  "quando"
# modificando o nome das linhas:
rownames(periodo_xy) <- c("Linha 1", "Linha 2", "Linha 3", "Linha 4", "Linha 5", "Linha 6", "Linha 7", "Linha 8", "Linha 9", "Linha 10")
periodo_xy


nrow(periodo_xy) # número de linhas
## [1] 10
ncol(periodo_xy) # número de colunas
## [1] 3
dim(periodo_xy) # número de linhas e colunas
## [1] 10 3
names(periodo_xy)
## [1] "x" "y" "quando"
x <- -2:7
y <- rnorm(10) * 2
quando <- c("Janeiro", "Fevereiro", "Janeiro", "Abril", "Dezembro", "Maio", "Junho", "Jun
ho", "Janeiro", "Agosto")
# tibble já está previsto no superpacote tidyverse
tib <- tibble(x, y, quando)
tib <- tibble("essa é um coluna" = x, y, quando)
tib
tib$`essa é um coluna` # acesso pelo nome da coluna
tib[[1]] # acesso pelo índice da coluna, retorna como um vetor
tib[1:5, 2] # retorna como um tibble, linhas 1:5 coluna 2
tib[2] # retorna todas as linhas da coluna 2
tib[1, ] # retorna todas as colunas da linha 1


## FACTORS
mes_como_factor <- factor(quando, levels = c("Janeiro", "Fevereiro", "Março", "Abril", "Maio", "Junho", "Julho", "Agosto", "Setembro", "Outubro", "Novembro", "Dezembro"))
mes_como_factor

periodo_xy$mes <- mes_como_factor
periodo_xy

frutas <- c("pessego", "laranja", "maçã", "pera", "uva")
frutas
frutas_factor <- as.factor(frutas)
frutas_factor
data()

df <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv", col_names = c("Data", "Familia", "Denominação", "Quantidade"))
summary(df)

install.packages("xml2")
library(xml2)
dados_xml <- read_xml("/home/fonta42/Desktop/ICDuR/Datasets/PesquisaIndustrialAnual-Produto.xml")
# o pacote xml2 possui diversas funções para entendermos o nosso arquivo xml
xml_name(dados_xml) ## [1] "ArrayOfValorDescritoPorSuasDimensoes"
xml_children(dados_xml)
## {xml_nodeset (16)}
## [1] <ValorDescritoPorSuasDimensoes>\n
## [2] <ValorDescritoPorSuasDimensoes>\n
## [3] <ValorDescritoPorSuasDimensoes>\n
## [4] <ValorDescritoPorSuasDimensoes>\n
## [5] <ValorDescritoPorSuasDimensoes>\n
## [6] <ValorDescritoPorSuasDimensoes>\n
## [7] <ValorDescritoPorSuasDimensoes>\n
## [8] <ValorDescritoPorSuasDimensoes>\n
## [9] <ValorDescritoPorSuasDimensoes>\n
## [10] <ValorDescritoPorSuasDimensoes>\n
## [11] <ValorDescritoPorSuasDimensoes>\n
## [12] <ValorDescritoPorSuasDimensoes>\n
## [13] <ValorDescritoPorSuasDimensoes>\n
## [14] <ValorDescritoPorSuasDimensoes>\n
## [15] <ValorDescritoPorSuasDimensoes>\n
## [16] <ValorDescritoPorSuasDimensoes>\n
# em suma, nosso XML possui 13 tags que denotam atributos (é importante enfatizar que essa
# não é uma organização padrão de arquivos XML e isso pode variar bastante conforme a aplic
# ação)
# essa função vai conseguir identificar os nomes das tags sem precisar do namespace completo
xml_ns_strip(dados_xml)
# essa função extrai todos os nós que seguem um padrão do xpath (linguagem de XML)
nodes_v <- xml_find_all(dados_xml, "//V")
# aqui conseguimos extrair o valor dentro da tag (para extrair de atributos, usamos xml_attr)
val_v <- xml_text(nodes_v)
val_v
# note que o primeiro valor de val_v é uma palavra (na verdade, nome da coluna), e por iss
# o não conseguimos converter para o tipo numeric. Podemos fazer isso da seguinte forma:
val_v <- as.numeric(val_v[2:length(val_v)]) # note que extraímos somente os valores 2 até
# o tamanho do vetor (ignorando o primeiro valor) --> isso é feito pelo operador : Posterio
# rmente, o resultado disso é convertido em numeric, por meio da função
val_v
# agora que entendemos como capturar os elementos do nosso XML, podemos fazer um data.frame. Uma das formas possíveis é a seguinte:
nodes_mc <- xml_find_all(dados_xml, "//MC")
val_mc <- xml_text(nodes_mc)
val_mc <- as.numeric(val_mc[2:length(val_mc)])

nodes_mn <- xml_find_all(dados_xml, "//MN")
val_mn <- xml_text(nodes_mn)
val_mn <- val_mn[2:length(val_mn)]

nodes_nc <- xml_find_all(dados_xml, "//NC")
val_nc <- xml_text(nodes_nc)
val_nc <- as.numeric(val_nc[2:length(val_nc)])

nodes_nn <- xml_find_all(dados_xml, "//NN")
val_nn <- xml_text(nodes_nn)
val_nn <- val_nn[2:length(val_nn)]

nodes_d1c <- xml_find_all(dados_xml, "//D1C")
val_d1c <- xml_text(nodes_d1c)
val_d1c <- as.numeric(val_d1c[2:length(val_d1c)])

nodes_d1n <- xml_find_all(dados_xml, "//D1N")
val_d1n <- xml_text(nodes_d1n)
val_d1n <- val_d1n[2:length(val_d1n)]

nodes_d2c <- xml_find_all(dados_xml, "//D2C")
val_d2c <- xml_text(nodes_d2c)
val_d2c <- as.numeric(val_d2c[2:length(val_d2c)])

nodes_d2n <- xml_find_all(dados_xml, "//D2N")
val_d2n <- xml_text(nodes_d2n)
val_d2n <- val_d2n[2:length(val_d2n)]

nodes_d3c <- xml_find_all(dados_xml, "//D3C")
val_d3c <- xml_text(nodes_d3c)
val_d3c <- as.numeric(val_d3c[2:length(val_d3c)])

nodes_d3n <- xml_find_all(dados_xml, "//D3N")
val_d3n <- xml_text(nodes_d3n)
val_d3n <- as.numeric(val_d3n[2:length(val_d3n)])

nodes_d4c <- xml_find_all(dados_xml, "//D4C")
val_d4c <- xml_text(nodes_d4c)
val_d4c <- as.numeric(val_d4c[2:length(val_d4c)])

nodes_d4n <- xml_find_all(dados_xml, "//D4N")
val_d4n <- xml_text(nodes_d4n)
val_d4n <- as.numeric(val_d4n[2:length(val_d4n)])

df_do_xml <- data.frame(
  "Valor" = val_v,
  "Unidade de Medida (Código)" = val_mc,
  "Unidade de Medida" = val_mn,
  "Nível Territorial (Código)" = val_nc,
  "Nível Territorial" = val_nn,
  "Brasil (Código)" = val_d1c,
  "Brasil" = val_d1n,
  "Variável (Código)" = val_d2c,
  "Variável" = val_d2n,
  "Ano (Código)" = val_d3c,
  "Ano" = val_d3c,
  "Classes das atividades industriais e produtos - Prodlist 2016 (Código)" = val_d4c,
  "Classes das atividades industriais e produtos - Prodlist 2016" = val_d4n
)
dados_xml <- read_xml("/home/fonta42/Desktop/ICDuR/Datasets/PesquisaIndustrialAnual-Produto.xml")
xml_ns_strip(dados_xml)


pegar_dados_xml <- function(xml, nome_tag, formato_numerico = FALSE) {
  nodes <- xml_find_all(xml, paste0("//", nome_tag))
  valores <- xml_text(nodes)
  valores <- valores[2:length(valores)]
  # aqui retornamos o que queremos já convertendo os valores para numérico, se for o caso
  if (formato_numerico) {
    as.numeric(valores)
  } else {
    valores
  }
}

df_do_xml2 <- data.frame(
  "Valor" = pegar_dados_xml(dados_xml, "V", TRUE),
  "Unidade de Medida (Código)" = pegar_dados_xml(dados_xml, "MC", TRUE),
  "Unidade de Medida" = pegar_dados_xml(dados_xml, "MN"),
  "Nível Territorial (Código)" = pegar_dados_xml(dados_xml, "NC", TRUE),
  "Nível Territorial" = pegar_dados_xml(dados_xml, "NN"),
  "Brasil (Código)" = pegar_dados_xml(dados_xml, "D1C", TRUE),
  "Brasil" = pegar_dados_xml(dados_xml, "D1N"),
  "Variável (Código)" = pegar_dados_xml(dados_xml, "D2C", TRUE),
  "Variável" = pegar_dados_xml(dados_xml, "D2N"),
  "Ano (Código)" = pegar_dados_xml(dados_xml, "D3C", TRUE),
  "Ano" = pegar_dados_xml(dados_xml, "D3N", TRUE),
  "Classes das atividades industriais e produtos - Prodlist 2016 (Código)" = pegar_dados_xml(dados_xml, "D4C", TRUE),
  "Classes das atividades industriais e produtos - Prodlist 2016" = pegar_dados_xml(dados_xml, "D4N", TRUE)
)

df_do_xml2

df <- data.frame(
  x = c(10, 2, 5, 1, 0.3, 2, 1, 3, 9, 6, 8, 2, 6),
  y = c(0, 2.8, 1, 5, 0.3, 2.2, 1.5, 7, 9, 4, 6, 8, 9)
)

df$y
df$x[[5]]
df[[1]]
df[[2]][[2]]
df[2, ]
df[, 2]