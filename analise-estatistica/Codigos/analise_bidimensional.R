# Leitura do conjunto de dados
dados <- read.table(file.choose(), header = FALSE, sep = "", dec = ".")
attach(dados)

# Variaveis 
estados <- V1
pop <- V2
percap <- V3
analf <- V4
expvida <- V5
crime <- V6
estud <- V7
ndias <- V8
area <- V9
dens <- pop / area

##### Análise descritiva bidimensional #####

## Correlação com renda per capta
plot(expvida, percap, ylab = "Renda per capita (USD)", xlab = "Expectativa de vida (anos)")
cor(expvida, percap)


## Correlação com taxa de analfabetismo
plot(expvida, analf, ylab = "Taxa de analfabetismo", xlab = "Expectativa de vida (anos)")
cor(expvida, analf)

## Correlação com taxa de criminalidade
plot(expvida, crime, ylab = "Taxa de criminalidade", xlab = "Expectativa de vida (anos)")
cor(expvida, crime)

## Correlação com porcentagem de estudantes que concluem o ensino médio
plot(expvida, estud, ylab = "Porcentagem de conclusão do ensino médio", xlab = "Expectativa de vida (anos)")
cor(expvida, estud)

## Correlação com dias do ano com temperatura abaixo de zero
plot(expvida, ndias, ylab = "Dias do ano com temperatura abaixo de 0°C", xlab = "Expectativa de vida (anos)")
cor(expvida, ndias)

## Correlação com densidade populacional
plot(expvida, dens, ylab = "Densidade populacional (hab/milhas²)", xlab = "Expectativa de vida (anos)")
cor(expvida, dens)