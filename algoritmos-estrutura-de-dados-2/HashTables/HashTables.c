/*
  Trabalho Prático - TPO1
  Aluno: Carlos Eduardo Fontaneli
  Curso: BCC - Bacharelado em Ciência da Computação
*/
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <ctype.h>

/* Estrutura das células da Tabela de Símbolos */
typedef struct celulaTS celulaTS;

struct celulaTS
{
  char chave[11]; // Chaves com tamanho Fixado
  int telefone;
  celulaTS *prox;
};

/* Declaração global da Tabela de Símbolos */
static celulaTS **tabelaSimbolos = NULL;
static int n_Chaves = 0;
static int tamanho_TS = 250;

/* Declaração das funções e procedimentos*/
int hash(char chave[10], int tamanho_TS);

void iniciaTabelaSimbolos();

celulaTS *procuraCelula(char chave[10]);

void insereCelula(char chave[10], int telefone);

void deletaCelula(char chave[10]);

void determinaOperacao();

void liberaTabelaSimbolos();

int main()
{
  iniciaTabelaSimbolos(); // Iniciando tabela
  determinaOperacao();    // Rodando Operações
  liberaTabelaSimbolos(); // Limpando a memória
  return 0;               // Finalização do programa
}

/* Implementação das funções e procedimentos */

/* Função HASH */
int hash(char chave[10], int tamanho_TS)
{
  int i, h = 0;
  int primo = 127;
  for (i = 0; chave[i] != '\0'; i++)
    h = (h * primo + chave[i]) % tamanho_TS;
  return h;
}

/* Função para iniciar a Tabela Símbolos */
void iniciaTabelaSimbolos()
{
  int h;
  n_Chaves = 0;
  tabelaSimbolos = (celulaTS **)malloc(tamanho_TS * sizeof(celulaTS *));
  for (h = 0; h < tamanho_TS; h++)
  {
    tabelaSimbolos[h] = NULL;
  }
}

/* Procura por uma célula na tabela dado uma chave */
celulaTS *procuraCelula(char chave[10])
{
  celulaTS *p;
  int h = hash(chave, tamanho_TS);
  p = tabelaSimbolos[h];
  while (p != NULL && strcmp(p->chave, chave) != 0)
    p = p->prox;
  if (p != NULL)
    return p;
  return NULL;
}

/* Função para inserir e alterar uma célula na tabela */
void insereCelula(char chave[10], int telefone)
{
  celulaTS *p;
  int h = hash(chave, tamanho_TS);
  p = tabelaSimbolos[h];
  /* Procura a posição a ser inserida a célula */
  while (p != NULL && strcmp(p->chave, chave))
    p = p->prox;

  /* Caso 1 - Inserção na lista ligada */
  if (p == NULL)
  {
    p = (celulaTS *)malloc(sizeof(*p));
    strcpy(p->chave, chave);
    p->telefone = telefone;
    n_Chaves += 1;
    p->prox = tabelaSimbolos[h];
    tabelaSimbolos[h] = p;
    return;
  }
  /* Caso 2 - Contatinho ja presente na lista */
  else
  {
    printf("Contatinho ja inserido\n");
  }
}

/* Função para deletar célula da lista ligada */
void deletaCelula(char chave[10])
{
  celulaTS *p, *aux;
  int h = hash(chave, tamanho_TS);
  p = tabelaSimbolos[h];
  /*
    Caso 1 - Lista vazia
    contatinho não foi encontrado
  */
  if (p == NULL)
  {
    printf("Operacao invalida: contatinho nao encontrado\n");
    return;
  }
  /*
    Caso 2 - Remoção no início da lista
    contatinho foi encontrado
  */
  if (strcmp(p->chave, chave) == 0)
  {
    tabelaSimbolos[h] = p->prox;
    free(p);
    n_Chaves--;
    return;
  }
  /*
    Caso 3 - Remoção no interior da lista
    retorno depende de existência ou
    não do contatinho na lista
  */
  while (p->prox != NULL && strcmp((p->prox)->chave, chave) != 0)
    p = p->prox;
  if (p->prox != NULL) // Caso 3.1 - Contatinho foi encontrado e removido
  {
    aux = p->prox;
    p->prox = aux->prox;
    free(aux);
    n_Chaves--;
    return;
  }
  printf("Operacao invalida: contatinho nao encontrado\n"); // Caso 3.2 - Contatinho não encontrado
}

/* Libera(apaga) a Tabela de Símbolos da memória */
void liberaTabelaSimbolos()
{
  celulaTS *p = NULL, *q = NULL;
  int h;
  /*
    Liberação sequencial das
    células de cada lista ligada
  */
  for (h = 0; h < tamanho_TS; h++)
  {
    p = tabelaSimbolos[h];
    while (p != NULL)
    {
      q = p;
      p = p->prox;
      free(q);
    }
  }
  free(tabelaSimbolos); // Liberação da tabela
  tabelaSimbolos = NULL;
  n_Chaves = 0;
}

/* Função para determinar e
executar a operação solicitada */
void determinaOperacao()
{
  char operacao;
  char nome[11];
  int telefone;
  celulaTS *r;

  /* Leitura da operação */
  do
  {
    scanf("%c", &operacao);
    /* Determinação da execução */
    switch (operacao)
    {
    /* Inserção de contatinho */
    case 'I':
      scanf("%s", nome);
      scanf("%d", &telefone);
      insereCelula(nome, telefone);
      break;
    /* Pesquisa por contatinho */
    case 'P':
      scanf("%s", nome);
      r = procuraCelula(nome);
      if (r != NULL)
      {
        printf("Contatinho encontrado: telefone %d\n", r->telefone);
      }
      else
      {
        printf("Contatinho nao encontrado\n");
      }
      break;
    /* Remoção de contatinho */
    case 'R':
      scanf("%s", nome);
      deletaCelula(nome);
      break;
    /* Atualização de dados de contatinho */
    case 'A':
      scanf("%s", nome);
      scanf("%d", &telefone);
      r = NULL;
      r = procuraCelula(nome);
      if (r != NULL)
      {
        r->telefone = telefone;
      }
      else
      {
        printf("Operacao invalida: contatinho nao encontrado\n");
      }
      break;
    }
  } while (operacao != '0');
  /* Encerramento de execução */
}