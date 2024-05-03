/*
  Trabalho Prático - TPO3
  Aluno: Carlos Eduardo Fontaneli
  Curso: BCC - Bacharelado em Ciência da Computação
*/

/* Para resolver o problema utilizou-se BFS (Breadth-First Search) para verificar se é possível dividir os vértices do grafo em 2 grupos independentes(0 e 1), tornando-o um grafo bipartido. Tal estratégia foi adotada, pois, ao mapear os alunos e suas questões, se for possível gerar um grafo bipartido dado a entrada é possível ocorrer o debate. Caso contrário, não deve ocorrer debate.  */

#include <stdio.h>
#include <stdlib.h>

#define MAX 100

// Estrutura de fila com estrutura de vetor circular
typedef struct
{
    int capacidade;
    int *elementos;
    int primeiro;
    int ultimo;
    int qtde_itens;
} Fila;

// Função responsável por iniciar uma fila
Fila *criaFila(int capacidade)
{
    Fila *fila = (Fila *)malloc(sizeof(Fila));
    fila->capacidade = capacidade;
    fila->elementos = (int *)malloc(fila->capacidade * sizeof(int));
    fila->primeiro = 0;
    fila->ultimo = 0;
    fila->qtde_itens = 0;
    return fila;
}

// Insere um elemento na fila
void insereFila(Fila *fila, int elemento)
{
    // Reinicializa a fila, caso a mesma tenha completado
    if (fila->ultimo == fila->capacidade - 1)
    {
        fila->ultimo = 0;
    }
    fila->elementos[fila->ultimo] = elemento;
    fila->ultimo++;
    fila->qtde_itens++;
}

// Remove um elemento na fila
int removeFila(Fila *fila)
{
    int removido = fila->elementos[fila->primeiro];
    fila->primeiro++;
    // Reinicializa a fila, caso a mesma tenha esvaziado
    if (fila->primeiro == fila->capacidade - 1)
    {
        fila->primeiro = 0;
    }
    fila->qtde_itens--;
    return removido;
}

// Confere se a fila está vazia
int filaVazia(Fila *fila)
{
    return (fila->qtde_itens == 0);
}

// Estrutura de noh para grafos implementados
// com lista de adjacência
typedef struct noh Noh;
struct noh
{
    int rotulo;
    Noh *proximo;
};

// Grafo com lista de adjacência
typedef struct grafo *Grafo;
struct grafo
{
    Noh **Adjacencia;
    int vertices; //   número   de   vértices
    int arestas;  //   número   de   arestas/arcos
};

// Insere, sem confirmação de existência précia, de aresta em grafo
void insereArcoNaoSeguraGrafo(Grafo Grafo, int v, int w)
{
    Noh *ponteiro_auxiliar;
    ponteiro_auxiliar = malloc(sizeof(Noh));
    ponteiro_auxiliar->rotulo = w;
    ponteiro_auxiliar->proximo = Grafo->Adjacencia[v];
    Grafo->Adjacencia[v] = ponteiro_auxiliar;
    Grafo->arestas++;
}

// Libera memórica alocada para um grafo
Grafo liberaGrafo(Grafo Grafo)
{
    int i;
    Noh *ponteiro_auxiliar;
    for (i = 0; i < Grafo->vertices; i++)
    {
        ponteiro_auxiliar = Grafo->Adjacencia[i];
        while (ponteiro_auxiliar != NULL)
        {
            Grafo->Adjacencia[i] = ponteiro_auxiliar;
            ponteiro_auxiliar = ponteiro_auxiliar->proximo;
            free(Grafo->Adjacencia[i]);
        }
        Grafo->Adjacencia[i] = NULL;
    }
    free(Grafo->Adjacencia);
    Grafo->Adjacencia = NULL;
    free(Grafo);
    return NULL;
}

// Inicializa e aloca memória para um grafo
Grafo inicializaGrafo(int n_vertices)
{
    int i;
    Grafo Grafo = malloc(sizeof *Grafo);
    Grafo->vertices = n_vertices;
    Grafo->arestas = 0;
    Grafo->Adjacencia = malloc(n_vertices * sizeof(Noh *));
    for (i = 0; i < n_vertices; i++)
        Grafo->Adjacencia[i] = NULL;
    return Grafo;
}

// Confere se um dado grafo é bipartido por meio de BFS
int ehGrafoBipartido(Grafo Grafo, int origem)
{
    int v, w, *bipartido;
    Fila *fila;
    Noh *p;
    bipartido = malloc(Grafo->vertices * sizeof(int));
    fila = criaFila(Grafo->vertices);
    // Iniciliaza vértices como -1, menos a origem que é 0
    for (v = 0; v < Grafo->vertices; v++)
    {
        bipartido[v] = -1;
    }
    bipartido[origem] = 0;
    insereFila(fila, origem);
    while (!filaVazia(fila))
    {
        v = removeFila(fila);
        p = Grafo->Adjacencia[v];
        while (p != NULL)
        {
            w = p->rotulo;
            if (bipartido[w] == -1)
            {
                // Coloca o vértice no grupo oposto ao seu vizinho anterior
                bipartido[w] = !bipartido[v];
                insereFila(fila, w);
            }
            // Se os 2 vizinhos forem do mesmo grupo,
            // o grafo não é bipartido
            if (bipartido[w] == bipartido[v])
            {
                return 0;
            }
            p = p->proximo;
        }
    }
    free(fila->elementos);
    free(fila);
    // Não há 2 vizinhos no mesmo grupo de vértices,
    // logo o grafo é bipartido
    return 1;
}

int main(int argc, char *argv[])
{
    char file_name[MAX];
    FILE *entrada;
    int qtde_estudantes, qtde_perguntas, aluno_perguntado, i, j;
    Grafo debate;

    if (argc != 1)
    {
        printf("Numero incorreto de parametros. Ex: .\\nome_arquivo_executavel\n");
        return 0;
    }
    scanf("%s", file_name);
    entrada = fopen(file_name, "r");
    if (entrada == NULL)
    {
        printf("\nNao encontrei o arquivo! Informe o nome da instancia\n");
        exit(EXIT_FAILURE);
    }

    // Leitura da quantidade total de estudantes
    fscanf(entrada, "%d", &qtde_estudantes);
    // Inicialização do grafo que representa o debate
    debate = inicializaGrafo(qtde_estudantes);
    // Lendo as perguntas de cada estudante
    for (i = 0; i < qtde_estudantes; i++)
    {
        fscanf(entrada, "%d", &qtde_perguntas);
        for (j = 0; j < qtde_perguntas; j++)
        {
            fscanf(entrada, "%d", &aluno_perguntado);
            // Inserindo no grafo a aresta que representa
            // ambos os direcionamentos da pergunta,
            // pois é grafo bipartido
            insereArcoNaoSeguraGrafo(debate, i, aluno_perguntado);
            insereArcoNaoSeguraGrafo(debate, aluno_perguntado, i);
        }
    }
    // Confere se o grafo é bipartido e
    // imprime a saída correspondente
    if (ehGrafoBipartido(debate, (debate->vertices) - 1))
    {
        printf("Vai ter debate\n");
    }
    else
    {
        printf("Impossivel\n");
    }
    // Libera a memória alocada para o grafo e
    // fecha o arquivo de entradas
    liberaGrafo(debate);
    fclose(entrada);
    return 0;
}
