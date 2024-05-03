library(tidyverse)
circulacao_dinheiro <- read_csv2("/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv", col_names = c("Data", "Família", "Denominação", "Quantidade"))

#criação de novas colunas para gerenciar dia, mes e ano
circulacao_dinheiro_detalhado <- mutate(circulacao_dinheiro,
                                        Dia = as.numeric(format(Data, "%d")),
                                        Mes = as.numeric(format(Data, "%m")),
                                        Ano = as.numeric(format(Data, "%Y")))

# Qual é quantidade média de circulação de moedas menores de 1 real (ou seja, 0.01, 0.05,
# 0.10, 0.25 e 0.50) nos últimos 10 anos no Brasil?

grafico_moedas <- ggplot(data = circulacao_dinheiro_detalhado) + geom_bar(stat = 'identity', mapping = aes(x = Ano, y = Quantidade))

grafico_moedas

# Dados de interesse 
moedas_menores_1real <- filter(circulacao_dinheiro_detalhado, as.numeric(Denominação) < 1.00 & between(Ano, 2012, 2022))

# Agrupando os dados
moedas_menores_1real_agrupado <- group_by(moedas_menores_1real, Ano, Denominação)

# Conjunto analise
conjunto_analise <- summarise(moedas_menores_1real_agrupado, "Quantidade Média" = mean(Quantidade))
conjunto_analise


# Grafico com dados que respondem a questao
grafico_moedas <- ggplot(data = conjunto_analise) + geom_bar(stat = 'identity', mapping = aes(x = Ano, y = `Quantidade Média`))
grafico_moedas


# Melhorias visuais do grafico
grafico_moedas_barra <- ggplot(data = conjunto_analise) + 
  geom_col(stat = 'identity', 
           position = position_dodge(), # Garante que as barras estejam lado a lado
           mapping = aes(x = as.factor(Ano), 
                         y = `Quantidade Média`, 
                         fill = Denominação)) + # Define o que preenche as barras
  scale_y_continuous(n.breaks = 10) + # Define as paradas(linhas) do eixo y
  labs(x = 'Ano', y = 'Quantidade Média em Circulação') +
  theme(axis.title = element_text(size = 10), 
        plot.title = element_text(size = 12, face = 'bold')) +
  ggtitle('Primeiro Grafico de Barras')

grafico_moedas_barra


# Gráfico de linhas
grafico_moedas_linha <- ggplot(data = conjunto_analise) + 
  geom_line(mapping = aes(x = as.factor(Ano),
                          y = `Quantidade Média`,
                          group = Denominação,
                          color = Denominação)) +
  scale_y_continuous(n.breaks = 8) +
  labs(x = 'Ano', y = 'Quantidade Média em Circulação') + 
  theme(axis.title = element_text(size = 10),
        plot.title = element_text(size = 12, face = 'bold')) +
  ggtitle('Primeiro gráfico de linha')

grafico_moedas_linha

# Gráfico de linhas  diferenciadas
grafico_moedas_linha_dif <- ggplot(data = conjunto_analise) + 
  geom_line(mapping = aes(x = as.factor(Ano),
                          y = `Quantidade Média`,
                          group = Denominação,
                          color = Denominação, 
                          linetype = Denominação)) +
  scale_y_continuous(n.breaks = 8) +
  labs(x = 'Ano', y = 'Quantidade Média em Circulação') + 
  theme(axis.title = element_text(size = 10),
        plot.title = element_text(size = 12, face = 'bold')) +
  ggtitle('Primeiro gráfico de linha')

grafico_moedas_linha_dif

# Gráfico de linhas  diferenciadas com pontos dispostos sobre ele
grafico_moedas_linha_dif_ponto <- ggplot(data = conjunto_analise) + 
  geom_line(mapping = aes(x = as.factor(Ano),
                          y = `Quantidade Média`,
                          group = Denominação,
                         colour = Denominação, 
                          linetype = Denominação)) +
  geom_point(mapping = aes(x = as.factor(Ano),
                           y = `Quantidade Média`,
                           group = Denominação,
                           color = Denominação, 
                           shape = Denominação), size = 3 ) +
  scale_y_continuous(n.breaks = 8) +
  labs(x = 'Ano', y = 'Quantidade Média em Circulação') + 
  theme(axis.title = element_text(size = 10),
        plot.title = element_text(size = 12, face = 'bold')) +
  ggtitle('Primeiro gráfico de linha')

grafico_moedas_linha_dif_ponto

# REFATORANDO Gráfico de linhas  diferenciadas com pontos dispostos sobre ele
grafico_moedas_linha_ponto <- ggplot(data = conjunto_analise, 
                                     mapping = aes(x = as.factor(Ano), 
                                                   y = `Quantidade Média`, 
                                                   group = Denominação, 
                                                   colour = Denominação)) +
  geom_line(mapping = aes(linetype=Denominação)) +
  geom_point(mapping = aes(shape=Denominação), size = 3) +
  scale_y_continuous(n.breaks = 8) +
  labs(x = "Ano", y = "Quantidade Média em Circulação") +
  theme(axis.title = element_text(size=10), plot.title = element_text(size=12, face="bol
d")) +
  ggtitle("Nosso primeiro gráfico de linha")
grafico_moedas_linha_dif_ponto


# ATIVIDADE DA SEMANA
#Adicionando as colunas 'Ano' e 'ValorCirculado'
circulacao_dinheiro_extendido <-mutate(circulacao_dinheiro,
                                        Ano = as.numeric(format(Data, "%Y")),
                                        ValorCirculado = Quantidade * as.numeric(Denominação))
#selecionando somente as Moedas - 1a. Família(inox) de 2002
moedas_fam1 <-filter(circulacao_dinheiro_extendido, as.numeric(format(Data, '%Y')) == 2002 & Família == 'Moedas - 1a. Família (inox)' & as.numeric(Denominação) < 0.50)
#agrupando os dados de tab1 por ano e denominação
moedas_fam1_agrup <-group_by(moedas_fam1, Denominação, Ano)
#Calculando o valor médio circulado
conjunto_de_analise_2 <-summarise(moedas_fam1_agrup,
                                   "Valor Médio Circulado" = mean(ValorCirculado) / 1000000)
ggplot(data = conjunto_de_analise_2) +
  
  geom_bar(stat = 'identity', position = position_dodge(), mapping = aes(x = Denominação, y = `Valor Médio Circulado` , fill = Denominação)) +
  scale_y_continuous(n.breaks = 10) +
  labs(x = "Denominação", y = "Valor Médio Circulado em milhões de reais") +
  theme(axis.title = element_text(size = 15), plot.title = element_text(size = 18, face = "bold"), axis.text = element_text(size = 15)) +
  
  ggtitle("Valor médio circulado das 'Moedas - 1a. Família (inox)' menores que 50 centavos em 2002")


library(ggplot2)
df <- data.frame(
  x = c(10, 2, 5, 25),
  y = c(2, 52, 12, 39),
  label = c("A", "B", "C", "D")
)
p <- ggplot(df, aes(x, y, label = label)) + #nesta linha definimos a estética do gráfico (ou seja, os eixos x e o y)
  labs(x = NULL, y = NULL) + #aqui definimos que não mostraremos nenhum nome do eixo
  theme(plot.title = element_text(size = 15)) #definimos o tamanho do título do gráfico => por meio do ggtitle


p + geom_line() + ggtitle("bem vindo ao ggplot2")