# Projeto do Curso de Aprendizado de Máquina II

Este projeto é dedicado a explorar técnicas avançadas de aprendizado de máquina na classificação de imagens e combinação de modelos. Utilizando redes neurais convolucionais e várias estratégias de agregação de modelos, este projeto visa melhorar a precisão preditiva e entender o comportamento de modelos complexos em cenários do mundo real.

## Autores

- Carlos Eduardo Fontaneli
- Ivan Duarte Calvo
- Eduardo Minoru Takeda

## Instrutor

- Prof. Dr. Murilo Coelho Naldi

## Visão Geral do Projeto

Este projeto envolve dois componentes principais: **Classificação de Imagens usando Redes Neurais Convolucionais (CNNs)** e **Combinação de Modelos**. Cada componente é projetado para enfrentar desafios específicos no campo do aprendizado de máquina e fornecer insights abrangentes sobre a aplicação dessas tecnologias.

## Palavras-chave

- Aprendizado de Máquina
- Redes Neurais Convolucionais
- Combinação de Modelos
- Classificação de Imagens

## Metodologia

### Classificação de Imagens com CNNs

- **Conjunto de Dados**: Utilizado uma coleção de imagens de paisagens rotuladas em categorias como Montanhas, Ruas, Geleiras, Prédios, Mares e Florestas. Cada imagem tem 150x150 pixels com três canais de cor.
- **Pré-processamento de Dados**: As imagens foram redimensionadas para 150x150 pixels e normalizadas. O conjunto de dados foi embaralhado e reduzido para se ajustar às limitações de hardware.
- **Implementação do Modelo**: Uma rede neural convolucional foi projetada para classificar as imagens, treinada ao longo de 20 épocas com métricas de desempenho analisadas após o treinamento.

### Combinação de Modelos

- **Conjunto de Dados**: Atributos relacionados a passageiros de companhias aéreas, como idade, sexo, classe do voo e distância do voo, foram usados para prever a satisfação do passageiro.
- **Tipos de Modelo**: Árvores de Decisão, KNN, MLP e Redes Neurais Artificiais (RNAs) usando técnicas de combinação de modelos.
- **Treino e Teste**: Os modelos foram treinados e testados individualmente, e depois combinados usando técnicas como votação por pontuação e votação por maioria para melhorar a precisão e a confiabilidade.

## Objetivos

- **Classificação de Imagens**: Classificar precisamente imagens em categorias pré-definidas usando CNNs.
- **Combinação de Modelos**: Melhorar o desempenho preditivo combinando diferentes modelos e analisando sua saída coletiva.

## Resultados Esperados

- **Classificação de Imagens**: Alcançar alta precisão na classificação correta de imagens de paisagens, entendendo o comportamento do modelo por meio de métricas como precisão e análise de erro.
- **Combinação de Modelos**: Demonstrar a eficácia das estratégias de combinação de modelos na melhoria da precisão geral do modelo e na redução da probabilidade de sobreajuste.

## Ferramentas

- **Linguagem de Programação**: Python
- **Ambiente de Desenvolvimento**: Notebooks Jupyter via Google Colab
- **Software de Apresentação**: Canva

## Conclusão

O projeto visa fornecer insights profundos sobre as capacidades de CNNs e estratégias de combinação de modelos em aprendizado de máquina. Ao analisar o desempenho individual e combinado de vários modelos, buscamos contribuir com conhecimento valioso para o campo e desenvolver técnicas robustas para aplicações no mundo real.
