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

##### Expvida x Percap#####
plot(percap, expvida, xlab = "Renda percapita em USD", ylab = "Expectativa de vida")
ajuste1 <- lm(expvida~percap, data = dados)
ypredito1 <- predict(ajuste1) 
lines(x = percap, y = ypredito1, col = "red")
summary(ajuste1)


##### Expvida x Analf #####
plot(analf, expvida, xlab = "Propor??o de analfabetos", ylab = "Expectativa de vida")
ajuste2 <- lm(expvida~analf, data = dados)
ypredito2 <- predict(ajuste2) 
lines(x = analf, y = ypredito2, col = "red")
summary(ajuste2)


##### Expvida x Crime #####
plot(crime, expvida,xlab = "Taxa de criminalidade", ylab = "Expectativa de vida")
ajuste3 <- lm(expvida~crime, data = dados)
ypredito3 <- predict(ajuste3) 
lines(x = crime, y = ypredito3, col = "red")
summary(ajuste3)


##### Expvida x Estud #####
plot(estud, expvida, xlab = "Porcentagem de estudante com segundo grau", ylab = "Expectativa de vida")
ajuste4 <- lm(expvida~estud,data = dados)
ypredito4 <- predict(ajuste4) 
lines(x = estud, y = ypredito4, col = "red")
summary(ajuste4)


##### Expvida x ndias #####
plot(ndias, expvida, xlab = "N?meros de dias com temperatura abaixo de zero", ylab = "Expectativa de vida")
ajuste5 <- lm(expvida~ndias, data = dados)
ypredito5 <- predict(ajuste5) 
lines(x = ndias, y = ypredito5, col = "red")
summary(ajuste5)


##### Expvida x dens #####
plot(dens, expvida, xlab = "Densidade demogr?fica", ylab = "Expectativa de vida")
ajuste6 <- lm(expvida~dens, data = dados)
ypredito6 <- predict(ajuste6) 
lines(x = dens, y = ypredito6, col = "red")
summary(ajuste6)

