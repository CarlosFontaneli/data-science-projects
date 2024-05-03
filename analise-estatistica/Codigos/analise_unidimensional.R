# Bibliotecas
library(gt)
library(glue)
library(magrittr)
library(knitr)
library(gtsummary)
library(dplyr)

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

##### RENDA PER CAPITA #####

# Tabelas
per_capita_intervalos <- seq(3000, 6500, 500) # Seta a divisão dos dados
# Rótulos para cada linhas
per_capita_classes <- c("[$3000,  $3500[", "[$3500,  $4000[", "[$4000,  $4500[", "[$4500,  $5000[", "[$5000,  $5500[", "[$5500,  $6000[", "[$6000, $6500[")

# Criando as tabelas, divididas pelos intervalos, com os rótulos como classes
per_capita_absoluta <- table(cut(percap, breaks = per_capita_intervalos, right = TRUE, labels = per_capita_classes))
per_capita_relativa <- prop.table(per_capita_absoluta)
# Tabela de porcentagem
per_capita_relativa_porcentagem <- (per_capita_relativa * 100)

# Classes tem que ir junto para ser considerada como uma coluna da table
per_capita_tabela <- cbind(per_capita_classes, per_capita_absoluta, per_capita_relativa_porcentagem) 

# Formatando a tabela
per_capita_tabela %>%
  gt(groupname_col = "Classes") %>% # Nomeia a primeira coluna
  # Edita o cabeçalho
  tab_header(title = md("**Renda per capita**"), subtitle = "Tabela de frequências") %>%
  # Formata os nomes de cada label
  cols_label(
    per_capita_absoluta = md("**Absoluta**"), # Usando de markdown para deixar em negrito
    per_capita_relativa_porcentagem = md("**Relativa %**"),
    per_capita_classes = md("**Valores**")
  )  %>%
  # Formata estilos da tabela
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

resumo_per_capita <-as.array(summary(percap))
resumo_per_capita %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos

# Sequência de 3000 a 7000 incrementando em 500
intervalos <- seq(3000, 7000, 500)

dados_percap <- percap

# Histograma com frequência absoluta
hist(dados_percap,
     xlab = "Renda per capita (USD)",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = intervalos,
     main = "")

# Gráfico de densidade
plot(density(dados_percap),
     xlab = "Renda per capita (USD)",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Resumo dos dados
summary(percap)

# Boxplot
boxplot(percap, ylab = "Renda per capita (USD)", col = "bisque")



##### POPULAÇÃO #####

# Tabelas
populacao_intervalos <- seq(365, 21400, 2083.3)
populacao_classes <- c("[365, 2448.3[", "[2448.3, 4531.6[", "[4531.6, 6614.9[", "[6614.9, 8698.2[", "[8698.2, 10781.5[", "[10781.5, 12864.8[", "[12864.8, 14948.1[", "[14948.1, 17031.4[", "[17031.4, 19114.7[", "[19114.7, 21198[")

pop_absoluta <- table(cut(pop, breaks = populacao_intervalos, right = TRUE, labels = populacao_classes, include.lowest = TRUE))
pop_relativa <- prop.table(pop_absoluta)
pop_relativa_percentual <- pop_relativa * 100
pop_relativa_percentual <-round(pop_relativa_percentual, digits = 2)
pop_tabela <- cbind(populacao_classes, pop_absoluta, pop_relativa_percentual)

pop_tabela%>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**População**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    pop_absoluta = md("**Absoluta**"),
    pop_relativa_percentual = md("**Relativa %**"),
    populacao_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) 

resumo_pop <-as.array(summary(pop))
resumo_pop %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos 
# Sequência de 365 a 21198 incrementando em 2083.3
intervalos <- seq(365, 21198, 2083.3)

dados_pop <- pop

# Histograma com frequência absoluta
hist(dados_pop,
     xlab = "População estimada",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = intervalos,
     main = "")

# Gráfico de densidade
plot(density(dados_pop),
     xlab = "População estimada",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Boxplot
# Resumo dos dados
summary(pop)

# Boxplot
boxplot(pop, ylab = "População estimada", col = "bisque")



##### População de Analfabetos #####
# Tabelas
analfabetismo_intervalos <- seq(0.5, 2.8, 0.2875)
analfabetismo_classes <- c("[0.5, 0.7875[", "[0,7875, 1.075[", "[1.075, 1.3625[", "[1.3625, 1.651[", "[1.651, 1.9375[", "[1.9375, 2.225[", "[2.225, 2.5125[", "[2.5125, 2.8[")

analt_absoluta <- table(cut(analf, breaks = analfabetismo_intervalos, right = TRUE, labels = analfabetismo_classes, include.lowest = TRUE))
analt_relativo <- prop.table(analt_absoluta)
analt_relativo_percent <- round((analt_relativo * 100), digits = 2)
analfabetismo_tabela <- cbind(analfabetismo_classes, analt_absoluta, analt_relativo_percent)        

analfabetismo_tabela %>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Analfabetismo**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    analt_absoluta = md("**Absoluta**"),
    analt_relativo_percent = md("**Relativa %**"),
    analfabetismo_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) 

resumo_analfabetismo <-as.array(summary(analf))
resumo_analfabetismo %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos
# Histograma com frequência absoluta
hist(dados_analf,
     xlab = "População de Analfabetos em 1970",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = seq(0.5, 2.8, 0.2875),
     main = "")

# Gráfico de densidade
plot(density(dados_analf),
     xlab = "Renda per capita (USD)",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Resumo dos dados
summary(analf)

# Boxplot
boxplot(analf, ylab = "População de analfabetos", col = "bisque")


##### EXPECTATIVA DE VIDA #####
# Tabelas
intervalos_expvida <- seq(67.96, 73.96, 1)
classes_expvida <- c("[67.96, 68.96[", "[68.96, 69.96[", "[69.96, 70.96[", "[70.96, 71.96[", "[71.96, 72.96[", "[72.96, 73.96[")

expvida_freq_absoluta <- table(cut(expvida, breaks = intervalos_expvida, right = FALSE, labels = classes_expvida))
expvida_freq_relativa <- prop.table(expvida_freq_absoluta)
expvida_freq_porcentagem <- round((expvida_freq_relativa * 100), digits = 2)
expvida_tabela <- cbind(classes_expvida, expvida_freq_absoluta, expvida_freq_porcentagem)


expvida_tabela%>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Expectativa de Vida**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    expvida_freq_absoluta = md("**Absoluta**"),
    expvida_freq_porcentagem = md("**Relativa %**"),
    classes_expvida = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) 
resumo_expectativa_vida<-as.array(summary(expvida))
resumo_expectativa_vida %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos 
# Histograma com frequência absoluta
hist(dados_expvida,
     xlab = "Expectativa de vida em anos",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = intervalos_expvida,
     main = "")

plot(density(expvida),
     xlab = "Expectativa de vida em anos",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Boxplot
# Resumo dos dados
summary(expvida)

# Boxplot
boxplot(expvida, ylab = "Expectativa de vida", col = "bisque")



##### CRIMINALIDADE #####
# Tabelas
crime_intervalos <- seq(1.4, 17.5, 2.283333)
crime_classes <- c("[1.4, 3.683333[", "[3.683333, 5.966667[", "[5.966667, 8.25[", "[8.25, 10.533333[", "[10.533333, 12.816667[", "[12.816667, 15.1]", "[15.1, 17.3[")

crime_absoluta <- table(cut(crime, breaks = crime_intervalos, right = TRUE, labels = crime_classes, include.lowest = TRUE))
crime_relativa <- prop.table(crime_absoluta)
crime_porcentagem <- round((crime_relativa * 100), digits = 2)
crime_tabela<- cbind(crime_classes, crime_absoluta, crime_porcentagem)

crime_tabela %>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Taxa de Criminalidade**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    crime_absoluta = md("**Absoluta**"),
    crime_porcentagem = md("**Relativa %**"),
    crime_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

resumo_crime <-as.array(summary(crime))
resumo_crime %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos 
dados_crime <- crime

# Histograma com frequência absoluta
hist(dados_crime,
     xlab = "Taxa de criminalidade por 100.000 habitantes",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = seq(1.4, 15.1, 2.2833333),
     main = "")

plot(density(dados_crime),
     xlab = "Taxa de criminalidade por 100.000 habitantes",
     ylab = "Densidade empírica",
     col = "red",
     main = "")


# Resumo dos dados
summary(crime)

# Boxplot
boxplot(crime, ylab = "Taxa de criminalidade", col = "bisque")



##### ESTUDO -> CONCLUSÃO DE SEGUNDO GRAU #####
# Tabelas
estudo_intervalos <- seq(37.8, 67.3, 2.95)
estudo_classes <- c("[37.8, 40.75[", "[40.75, 43.7[", "[43.7, 46.65[", "[46.65, 49.6[", "[49.6, 52.55[", "[52.55, 55.5[", "[55.5, 58.45[", "[58.45, 61.4[", "[61.4, 64.35[", "[64.35, 67.3[")

estudo_absoluto <- table(cut(estud, breaks = estudo_intervalos, labels = estudo_classes, include.lowest = TRUE))
tabela_estudo_relativo <- prop.table(estudo_absoluto)
estudo_porcentagem <- round((tabela_estudo_relativo * 100), digits = 2)
tabela_estudo <- cbind(estudo_classes, estudo_absoluto, estudo_porcentagem)

tabela_estudo %>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Taxa de conclusão do segundo grau**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    estudo_absoluto = md("**Absoluta**"),
    estudo_porcentagem = md("**Relativa %**"),
    estudo_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )
resumo_estudo <-as.array(summary(estud))
resumo_estudo %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos
dados_estud <- estud
intervalos <- seq(37.8, 67.3, 2.95)

# Histograma com frequência absoluta
hist(dados_estud,
     xlab = "Porcentagem de conclusão do ensino médio",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = intervalos,
     main = "")

# Gráfico de densidade
plot(density(dados_estud),
     xlab = "Porcentagem de conclusão do ensino médio",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Resumo dos dados
summary(estud)

# Boxplot
boxplot(estud, ylab = "Porcentagem de conclusão do ensino médio", col = "bisque")

##### DIAS COM TEMPERATURA ABAIXO DE 0 #####
# Tabelas
ndias_absoluto <-ndias
estados_nomes <- estados[]
ndias_relativa <- prop.table(ndias_absoluto)
ndias_relativa_percentual <- round((ndias_relativa * 100), digits = 2)
ndias_tabela <- cbind(as.vector(estados), ndias_absoluto,  ndias_relativa_percentual)
ndias_tabela %>%
  gt(groupname_col = "Estados") %>%
  tab_header(title = md("**Tabela 7 : Dias com temperatura abaixo de 0 graus Celsius.**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    ndias_absoluto = md("**Absoluta**"),
    ndias_relativa_percentual = md("**Relativa %**"),
    V1 = md("**Estados**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) %>%
  tab_options(
    container.height = px(500),
    table.layout = "auto",
    table_body.hlines.style = "auto"
  )
resumo_ndias <-as.array(summary(ndias))
resumo_ndias %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos
# Grafico de linha
plot(ndias,
     xlab = "Número de dias do ano com temperatura abaixo de 0°C",
     ylab = "Frequência absoluta",
     col = "green")

# Resumo dos dados
summary(ndias)

# Boxplot
boxplot(ndias, ylab = "Número de dias do ano com temperatura abaixo de 0°C", col = "bisque")



##### AREA #####
# Tabelas
area_intervalos <- seq(0, 600000, 60000)
area_classes <- c("[0, 60000[", "[60000, 120000[", "[120000, 180000[", "[180000, 240000[", "[240000, 300000[", "[300000, 360000[", "[360000, 420000[", "[420000, 480000[", "[480000, 540000[", "[540000, 600000[")

area_absoluta <- table(cut(area, breaks = area_intervalos, labels = area_classes))
area_relativa <- prop.table(area_absoluta)
area_porcentagem <- round((area_relativa * 100), digits = 2)
area_tabela <- cbind(area_classes, area_absoluta, area_porcentagem)

area_tabela %>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Taxa de área em milhas**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    area_absoluta = md("**Absoluta**"),
    area_porcentagem = md("**Relativa %**"),
    area_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) 
resumo_area <-as.array(summary(area))
resumo_area %>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos
dados_area <- area

intervalos <- seq(0, 600000, 60000)


# Histograma com frequência absoluta
hist(dados_area,
     xlab = "Área do estado em milhas quadradas",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = intervalos,
     main = "")

plot(density(dados_area),
     xlab = "Área do estado em milhas quadradas",
     ylab = "Densidade empírica",
     col = "red",
     main = "")

# Resumo dos dados
summary(area)

# Boxplot
boxplot(area, ylab = "Área do estado", col = "bisque")

##### DENSIDADE #####
# Tabelas
densidade_intervalos <- seq(0.0000000, 3.1319168, 0.4473028)
densidade_classes <- c("[0.0000000, 0.4479472[", "[0.4479472, 0.89525[", "[0.89525, 1.3425528[", "[1.3425528, 1.7898556[", "[1.7898556, 2.2371584[", "[2.2371584, 2.6844614[", "[2.6844614, 3.1319168[")

dens_freq_absoluta <- table(cut(dens, breaks = densidade_intervalos, labels = densidade_classes))
dens_freq_relativa <- prop.table(dens_freq_absoluta)
dens_freq_porcentagem <- round((dens_freq_relativa * 100), digits = 2)
dens_tabela <- cbind(densidade_classes, dens_freq_absoluta, dens_freq_porcentagem)

dens_tabela %>%
  gt(groupname_col = "Classes") %>%
  tab_header(title = md("**Densidade**"), subtitle = "Tabela de frequências") %>%
  cols_label(
    dens_freq_absoluta = md("**Absoluta**"),
    dens_freq_porcentagem = md("**Relativa %**"),
    densidade_classes = md("**Quantidade**")
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  ) 
resumo_densidade <-as.array(summary(dens))
resumo_densidade%>%
  gt_preview() %>%
  cols_label(
    Var1 = md("**Medida**"),
    Freq = md("**Valor**"),
  )  %>%
  cols_align(
    align = "center",
  ) %>%
  cols_align(
    align = "center",
  ) %>%
  tab_style(
    cell_text(
      size = "large",
      align = "center",
      v_align = "middle",
      stretch = "expanded"
    ),
    locations = cells_body(columns = TRUE)
  )

# Gráficos
# Histograma de dens
dados_dens <- dens

brk <- seq(0.0006444, 2.6844614, 0.447302825)

# Histograma com frequência absoluta
hist(dados_dens,
     xlab = "Densidade populacional (hab/milhas²)",
     ylab = "Frequência absoluta",
     col = "orange",
     breaks = brk,
     main = "")

plot(density(dados_dens),
     xlab = "Densidade populacional (hab/milhas²)",
     ylab = "Densidade empírica",
     col = "red",
     main = "")


# Resumo dos dados
summary(dens)

# Boxplot
boxplot(dens, ylab = "Densidade populacional (hab/milhas²)", col = "bisque")
