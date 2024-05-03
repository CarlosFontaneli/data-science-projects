library("tidyverse")
library("sf")

estados_br <- st_read('/home/fonta42/Desktop/ICDuR/Datasets/BR_UF_2020')
estados_br

# podemos fazer filtros sobre atributos alfanuméricos de maneira normal
sp <- filter(estados_br, SIGLA_UF == 'SP')
sp
mg <- filter(estados_br, SIGLA_UF == 'MG')
mg

# capturando a geometria de cada estado como um sfg
sp <- sp$geometry[[1]]
plot(sp)
mg <- mg$geometry[[1]]
plot(mg)

# uniao e intersecção
union_sp_mg <- st_union(sp, mg)
plot(union_sp_mg)

int_sp_mg <- st_intersection(sp, mg)
plot(int_sp_mg)


# VISUALIZANDO OBJETOS ESPACIAIS
plot <- ggplot() + geom_sf(data = estados_br, 
                           mapping=aes(geometry = geometry))
plot

# cores fixas
ggplot() + geom_sf(data = estados_br, fill = "blue")

# cores conforme a regiao
ggplot() + geom_sf(data = estados_br, mapping = aes(fill = NM_REGIAO))

ggplot() + geom_sf(data = estados_br, 
                   mapping = aes(fill = NM_REGIAO)) +
  scale_fill_discrete("Região") + 
  theme_void()
