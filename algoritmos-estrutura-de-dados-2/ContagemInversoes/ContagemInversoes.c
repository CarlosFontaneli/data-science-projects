/*
  Trabalho Prático - TPO2
  Aluno: Carlos Eduardo Fontaneli
  Curso: BCC - Bacharelado em Ciência da Computação
*/
#include <stdio.h>
#include <stdlib.h>

#define MAX 100

unsigned long long intercalaContando(int vetor[], int inicioVetor, int meioVetor, int finalVetor)
{
  int i, j, k, tam;
  unsigned long long num_inv = 0;
  i = inicioVetor;
  j = meioVetor;
  k = 0;
  tam = finalVetor - inicioVetor;
  int *vetorAux = malloc(tam * sizeof(int));
  while (i < meioVetor && j < finalVetor)
  {
    if (vetor[i] <= vetor[j])
      vetorAux[k++] = vetor[i++];
    else
    {
      vetorAux[k++] = vetor[j++];
      num_inv += meioVetor - i;
    }
  }
  while (i < meioVetor)
    vetorAux[k++] = vetor[i++];
  while (j < finalVetor)
    vetorAux[k++] = vetor[j++];
  for (k = 0; k < tam; k++)
    vetor[inicioVetor + k] = vetorAux[k];
  free(vetorAux);
  return num_inv;
}

unsigned long long contarInversoesR(int vetor[], int inicioVetor, int finalVetor)
{
  int meioVetor;
  unsigned long long num_inv = 0;
  if (finalVetor - inicioVetor > 1)
  {
    meioVetor = (inicioVetor + finalVetor) / 2;
    num_inv += contarInversoesR(vetor, inicioVetor, meioVetor);
    num_inv += contarInversoesR(vetor, meioVetor, finalVetor);
    num_inv += intercalaContando(vetor, inicioVetor, meioVetor, finalVetor);
  }
  return num_inv;
}

/* main fornecida  */
int main(int argc, char *argv[])
{
  char file_name[MAX];
  FILE *entrada;
  int i, n;
  unsigned long long num_inv = 0;

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
  // lendo do arquivo da instância
  fscanf(entrada, "%d", &n);
  int *v = (int *)malloc(n * sizeof(int));
  for (i = 0; i < n; i++)
    fscanf(entrada, "%d", &v[i]);
  // imprime(v, n);
  num_inv = contarInversoesR(v, 0, n);

  // printf("%I64u\n", num_inv);
  printf("%llu\n", num_inv);

  fclose(entrada);
  return 0;
}