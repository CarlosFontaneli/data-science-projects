library(tidyverse)

circulacao_dinheiro <- read_csv2(
  "/home/fonta42/Desktop/ICDuR/Datasets/MeioCirculante_DadosAbertos.csv",
  col_names = c("Data", "Família", "Denominação", "Quantidade")
)

moedas_2019 <- mutate(circulacao_dinheiro,
  Dia = as.numeric(format(Data, "%d")),
  Mês = as.numeric(format(Data, "%m"))
) %>%
  filter(as.numeric(format(Data, "%Y")) == 2019 & Denominação %in% c(
    "0.01",
    "0.05",
    "0.10",
    "0.25",
    "0.50",
    "1.00"
  )) %>%
  select(Dia, Mês, Denominação, Quantidade) %>%
  arrange(desc(Mês), desc(Dia)) %>%
  group_by(Mês, Denominação) %>%
  summarise(Média = mean(Quantidade, na.rm = TRUE))


# GRÁFICOS DE LINHA
ggplot(data = moedas_2019) +
  geom_line(aes(
    x = as.factor(Mês),
    y = Média,
    group = Denominação, # agrupamento de coluna que formará as linhas
    colour = Denominação,
    linetype = Denominação,
    # size = Denominação,
    # alpha = Média # transparência na cor, conforme variacao dos dados
  )) +
  ggtitle("Moedass em Circulação", subtitle = "Brasil - 2019") +
  xlab("Mês") +
  ylab("Quantidade Média") +
  labs(
    x = "Mês",
    y = "Quantidade Média",
    title = "Moedas em Circulação",
    subtitle = "Brasil - 2019",
    caption = "Portal Brasileiro de Dados Abertos",
    tag = "Criado por Carlos",
    colour = "Valor da Moeda"
  ) +
  theme(
    legend.title = element_text(face = "bold"),
    legend.text = element_text(
      size = 10,
      colour = "blue"
    ),
    plot.title = element_text(face = "bold"),
    axis.title = element_text(
      size = 8,
      colour = "red"
    ),
    panel.background = element_rect(fill = "white", colour = "black")
  ) +
  theme_bw() + # Temas pré definidos
  # theme_gray() +
  # theme_dark() +
  scale_x_discrete(breaks = c(1, 3, 6, 9, 12), labels = c( # edita os tick de x
    "Janeiro",
    "Março",
    "Junho",
    "Setembro",
    "Dezembro"
  )) +
  scale_y_continuous(n.breaks = 8, labels = scales::number_format(
    big.mark = ".",
    decimal.mark = ","
  ))


# GRÁFICOS DE PONTOS
ggplot(data = moedas_2019) +
  geom_point(aes(
    x = as.factor(Mês),
    y = Média,
    group = Denominação,
    colour = Denominação,
  )) +
  labs(
    x = "Mês",
    y = "Quantidade Média",
    title = "Moedas em Circulação"
  )

dados_artificias <- tibble(
  "CONSUMO" = abs(rnorm(5000, mean = 15, sd = 2)),
  "PRODUÇÃO" = abs(rnorm(5000, mean = 55, sd = 12)),
  "CATEGORIA" = sample(c("A", "B", "C"),
    5000,
    replace = TRUE
  )
)

ggplot(data = dados_artificias) +
  geom_point(aes(
    x = CONSUMO,
    y = PRODUÇÃO,
    colour = CATEGORIA,
    # size = CONSUMO,
    shape = CATEGORIA,
  ),
  fill = "black",
  size = 5,
  stroke = 2,
  shape = 21,
  )


# GRÁFICOS DE BARRA
ggplot(data = moedas_2019) +
  geom_col(
    aes(
      x = as.factor(Mês),
      y = Média,
      fill = Denominação,
    ),
    position = position_dodge(), # Mantém as barras lado a lado
    linetype = "solid",
    colour = "black",
  ) +
  labs(
    x = "Mês",
    y = "Quantidade Média",
    title = "Moedas em Circulação",
  )


# HISTOGRAMA
moedas_2019_bruto <- mutate(
  circulacao_dinheiro,
  Dia = as.numeric(format(Data, "%d")),
  Mês = as.numeric(format(Data, "%m")),
) %>%
  filter(
    as.numeric(format(Data, "%Y")) == 2019 &
      Denominação %in% c("0.01", "0.05", "0.10", "0.25", "0.50", "1.00")
  ) %>%
  select(
    Dia,
    Mês,
    Denominação,
    Quantidade,
  )

ggplot(data = moedas_2019_bruto) +
  geom_histogram(
    aes(
      x = Quantidade,
      fill = Denominação
    ),
    bins = 100
  ) +
  labs(
    x = "Quantidade em Circulação",
    y = "Contagem",
    title = "Histograma - Moedas em Circulação",
  )

moedas_2019_bruto_menores <- filter(moedas_2019_bruto, Quantidade < 100000)

ggplot(data = moedas_2019_bruto_menores) +
  geom_histogram(
    aes(
      x = Quantidade,
      fill = Denominação,
    )
  ) +
  labs(
    x = "Quantidade em Circulação",
    y = "Contagem",
    title = "Histrograma - Moedas em Circulação"
  )

ggplot(data = dados_artificias) +
  geom_histogram(
    aes(x = CONSUMO, colour = CATEGORIA),
    # binwidth = 0.01,
    position = position_dodge()
  )


# COMBINANDO GRÁFICOS
ggplot(data = moedas_2019) +
  geom_line(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    colour = Denominação, group = Denominação
  )) +
  geom_point(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    shape = Denominação
  )) +
  labs(x = "Mês", y = "Quantidade Média", title = "Moedas em Circulação")


ggplot(data = moedas_2019) +
  geom_line(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    colour = Denominação, group = Denominação
  )) +
  geom_point(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    colour = Denominação
  ), fill = "white", size = 2, stroke = 2, shape = 21)
+
  labs(x = "Mês", y = "Quantidade Média", title = "Moedas em Circulação")

ggplot(data = moedas_2019) +
  geom_point(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    colour = Denominação
  ), fill = "white", size = 2, stroke = 2, shape = 21) +
  geom_line(aes(
    x = as.factor(Mês), y = Média, # lembre-se, x e y são obrigatórios!
    colour = Denominação, group = Denominação
  )) +
  labs(x = "Mês", y = "Quantidade Média", title = "Moedas em Circulação")


ggplot(data = moedas_2019, aes(
  x = as.factor(Mês), y = Média,
  colour = Denominação, group = Denominação
)) +
  geom_line() + # as características estéticas serão herdadas do aes() definido no ggplot
  geom_point(fill = "white", size = 2, stroke = 2, shape = 21) +
  labs(x = "Mês", y = "Quantidade Média", title = "Moedas em Circulação")



# PEQUENOS GRÁFICOS
ggplot(
  data = moedas_2019,
  aes(x = as.factor(Denominação), y = Média)
) +
  geom_col() +
  labs(
    x = "Denominação",
    y = "Quantidade Média",
    title = "Moedas em Circulação"
  ) +
  # facet_grid(cols = vars(Mês))
  facet_wrap(vars(Mês), nrow = 6, scales = "free_y")


moedas_circulacao_media <- mutate(circulacao_dinheiro,
  Dia = as.numeric(format(Data, "%d")),
  Mês = as.numeric(format(Data, "%m")),
  Ano = as.numeric(format(Data, "%Y"))
) %>%
  filter(Ano >= 2010 & Mês
  %in% c(1, 2, 3) &
    Denominação %in% c("0.01", "0.05", "0.10", "0.25", "0.50", "1.00")) %>%
  arrange(desc(Ano), desc(Mês), desc(Dia)) %>%
  group_by(Mês, Ano, Denominação) %>%
  summarise(Média = mean(Quantidade, na.rm = TRUE))

meu_graficos <- ggplot(data = moedas_circulacao_media, aes(x = as.factor(Denominação), y = Média, fill = Denominação), ) +
  geom_col() + # as características estéticas serão herdadas do aes() definido no ggplot
  labs(x = "Denominação", y = "Quantidade Média", title = "Moedas em Circulação") +
  facet_wrap(vars(Ano, Mês), ncol = 3)

ggsave("nome_do_arquivo_do_grafico.png", plot = meu_graficos, height = 20, dpi = "print")