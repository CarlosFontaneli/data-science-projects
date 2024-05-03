library(tidyverse)
circulacao_dinheiro <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv", col_names = c("Data", "Família", "Denominação", "Quantidade"))

# Retorna dinheiros circulados em 29 de novembro de 1996
dinheiro_29nov96 <- filter(circulacao_dinheiro, Data == "1996-11-29")
dinheiro_29nov96

# Retorna todas as circulações das moedas de valor 0.01 e considerando o ano de 1998
moeda001_98 <- filter(circulacao_dinheiro, as.numeric(format(Data, "%Y")) == 1998 & Denominação == 0.01)
moeda001_98

# Retorne todas as circulações das moedas de valor -.05 ou 0.10 no ano de 2010
moedas_010_005_2010 <- filter(circulacao_dinheiro, as.numeric(format(Data, "%Y")) == 2010 & (Denominação == 0.10 | Denominação == 0.05))
moedas_010_005_2010 <- filter(circulacao_dinheiro, as.numeric(format(Data, "%Y")) == 2010 & Denominação %in% c(0.05, 0.10))
moedas_010_005_2010

# Retorne todas as circulações de dinheiro que são do tipo cédula entre os anos 2000 e 2003:
cedulas_00_03 <- filter(circulacao_dinheiro, between(as.numeric(format(Data, "%Y")), 2000, 2003) & str_detect(Familia, "Cédula"))
cedulas_00_03

# Comparação de igualdade entre doubles
near(sqrt(2)^2, 2) # o primeiro argumento é próximo ao segundo argumento?


# Ordenar os dados tabulares pela coluna Quantidade:
circulacao_dinheiro_ordenada <- arrange(circulacao_dinheiro, Quantidade)
circulacao_dinheiro_ordenada
view(circulacao_dinheiro_ordenada)

# Ordenar os dados tabulares por Denominacao, Data e depois Familia
circulacao_dinheiro_ordenada <- arrange(circulacao_dinheiro, Denominação, Data, Familia)
circulacao_dinheiro_ordenada

# Ordenar os dados tabulares pelas datas mais recentes (ou seja, de maneira decrescente), e então ordenação
# ascendente das colunas Denominação e Família:
circulacao_dinheiro_ordenada <- arrange(circulacao_dinheiro, desc(Data), Denominação, Familia)
circulacao_dinheiro_ordenada
circulacao_dinheiro_ordenada <- arrange(circulacao_dinheiro, desc(Quantidade), desc(Data), Denominação, Familia)
circulacao_dinheiro


# SELEÇÃO DE COLUNAS

# Recupere todas as linhas mostrando as colunas Denominação e Quantidade
denomin_quanti <- select(circulacao_dinheiro, Denominação, Quantidade)
denomin_quanti

# Recupere todas as linhas mostrando as colunas entre Família e Quantidade:
denomin_quanti <- select(circulacao_dinheiro, Familia:Quantidade)
denomin_quanti


# SELECIONANDO LINHAS DISTINTAS
# Recupere os valores distintos de Denominação
denomin_distin <- distinct(circulacao_dinheiro, Denominação)
denomin_distin

# Recupere as combinações de valores distintos de Família e Denominação:
denomin_distin <- distinct(circulacao_dinheiro, Familia, Denominação)
denomin_distin


# ADIÇÃO DE COLUNAS
# Adicione colunas para dia, mes e ano
circulacao_dinheiro_detalhado <- mutate(circulacao_dinheiro, Dia = as.numeric(format(Data, "%d")), Mês = as.numeric(format(Data, "%m")), Ano = as.numeric(format(Data, "%Y")))
circulacao_dinheiro_detalhado

# Adicione uma coluna que representa o valor em Reais de circulação (note que a coluna Quantidade refere-se à
# quantidade de uma moeda ou cédula em circulação e não o valor monetário em si). Por fim, crie uma outra coluna
# equivalente em Dólar (considerando a cotação de 0,179 para cada Real):
circulacao_dinheiro_detalhado <- mutate(circulacao_dinheiro_detalhado, ValorCirculado = Quantidade * as.numeric(Denominação), ValorDolar = ValorCirculado * 0.179)
circulacao_dinheiro_detalhado


# RESUMO DOS DADOS
media_circulacao <- summarise(circulacao_dinheiro_detalhado,
  media = mean(ValorCirculado, na.rm = TRUE),
  maximo = max(ValorCirculado, na.rm = TRUE),
  minimo = min(ValorCirculado, na.rm = TRUE)
)
media_circulacao


# AGRUPAMENTO DE DADOS
por_ano_denominacao <- group_by(circulacao_dinheiro_detalhado, Ano, Denominação)
por_ano_denominacao
view(por_ano_denominacao)

media_circulacao <- summarise(por_ano_denominacao,
  media = mean(ValorCirculado, na.rm = TRUE),
  maximo = max(ValorCirculado, na.rm = TRUE),
  minimo = min(ValorCirculado, na.rm = TRUE)
)
media_circulacao

curiosidade <- filter(circulacao_dinheiro, as.numeric(Denominação) == 3 | as.numeric(Denominação) == 20)
curiosidade
view(curiosidade)


exercicio <- filter(circulacao_dinheiro_detalhado, Denominação %in% c(0.01, 0.05, 0.10, 0.25, 0.50), as.numeric(format(Data, "%Y")) >= 2010)
exercicio
exercicio <- summarise(exercicio, Ano, Denominação, "Quantidade Média" = mean(Quantidade), "Valor Médio Circulado" = mean(ValorCirculado))
exercicio

resultado <- filter(circulacao_dinheiro, Denominação == "2.00" & str_detect(Familia, "Cédula"))
resultado


t2 <- filter(circulacao_dinheiro, (Denominação == "5.00" | Denominação == "10.00") & str_detect(Familia, "Moeda")) %>%
  arrange(desc(Quantidade)) %>%
  select(Denominação, Quantidade)
t2
t <- select(arrange(filter(circulacao_dinheiro, (Denominação == "5.00" | Denominação == "10.00") & str_detect(Familia, "Moeda")), desc(Quantidade)), Denominação, Quantidade)
t

circulacao_dinheiro <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv", col_names = c("Data", "Família", "Denominação", "Quantidade"))
circulacao_dinheiro <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv", col_names = c("Data", "Família", "Denominação", "Quantidade"))


circulacao_dinheiro_extendido <- mutate(circulacao_dinheiro,
  Ano = as.numeric(format(Data, "%Y")),
  ValorCirculado = Quantidade * as.numeric(Denominação)
)

moedas_fam1 <- filter(
  circulacao_dinheiro_extendido,
  between(as.numeric(format(Data, "%Y")), 2002, 2004) & Família == "Moedas - 1a. Família (inox)"
)
moedas_fam1_agrup <- group_by(moedas_fam1, Denominação, Ano)
conjunto_final_1 <- summarise(
  moedas_fam1_agrup,
  "Quantidade Média" = mean(Quantidade),
  "Valor Médio Circulado" = mean(ValorCirculado)
)
conjunto_final_1

moedas_com_06_2020 <- filter(circulacao_dinheiro, as.numeric(format(Data, "%Y")) == 2020 &
  as.numeric(format(Data, "%m")) == 06 &
  str_detect(Família, "Moedas comemorativas"))

moedas_agrup <- group_by(moedas_com_06_2020, Denominação, Família)

conjunto_final_2 <- summarise(moedas_agrup,
  "Quantidade Média" = mean(Quantidade)
)
conjunto_final_2

moedas_copa_periodo <- filter(
  circulacao_dinheiro,
  Data > "2015-06-12" & Data < "2015-06-16" &
    str_detect(Família, "Copa 2014")
)
conjunto_final_3 <- select(moedas_copa_periodo, Família, Denominação, Quantidade) %>%
  arrange(desc(Quantidade))
conjunto_final_3